//
//  SALAttributedString.m
//  SALAttributedStringExample
//
//  Created by Marcio Klepacz on 8/26/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "SALAttributedStringExtensions.h"
#import "NSAttributedString+SALAttributedStringCustomAttributes.h"
#import "SALResizableTextAttachment.h"
#import "SALImageDownloader.h"
#import "SALHTMLParser.h"

static NSString * const kSALDummyImgURL = @"http://s3.amazonaws.com/opensourceprojects/onepiximg.png";

@interface SALAttributedStringExtensions ()

@property (nonatomic, strong) NSMutableArray *imagesURL;
@property (nonatomic, strong) NSMutableArray *imagesRanges;

@end

@implementation SALAttributedStringExtensions

- (NSAttributedString *)attributedStringFromHTML:(NSString *)HTML limitingImageHeight:(CGFloat)imageHeightLimit withTextAttachmentBackgroundColor:(UIColor *)textAttachmentBackgroundColor
{
    /**
     "Since OS X v10.4, NSAttributedString has used WebKit for all import (but not for export) of HTML documents. Because WebKit document loading is not thread safe, this has not been safe to use on background threads.." for more: https://developer.apple.com/library/ios/documentation/cocoa/Conceptual/AttributedStrings/Tasks/CreatingAttributedStrings.html
    **/
    
    if (![NSThread isMainThread]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"This method can only be called on the main thread" userInfo:nil];
    }
    
    self.imagesURL = [NSMutableArray array];
    self.imageHeightLimit = imageHeightLimit;
    self.textAttachmentBackgroundColor = textAttachmentBackgroundColor;
    
    //Filtering
    HTML = [self filterElementsOnHTML:HTML];
    
    //Only supporting UTF8 encoding
    NSData *HTMLData = [HTML dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
    NSError *parsingError;
    
    //Parsing to NSAttributedString
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:HTMLData options:options documentAttributes:nil error:&parsingError];
    
    if (parsingError) {
        NSLog(@"Parsing error %li - %@", (long)parsingError.code, parsingError.userInfo);
        
        return nil;
    }
    
    UIImage *imagePlaceholder = [self.delegate respondsToSelector:@selector(imagePlaceholder)] ? [self.delegate imagePlaceholder] : nil;
    
    NSDictionary *attributedStringAndRanges = [attributedString addImagePlaceholder:imagePlaceholder forImagesURL:self.imagesURL limitingTextAttachmentHeight:self.imageHeightLimit withTextAttachmentBackgroundColor:self.textAttachmentBackgroundColor];
    
    self.imagesRanges = attributedStringAndRanges[@"imagesRange"];
    
    [self downloadImages];
    
    return attributedStringAndRanges[@"attributedStringWithPlaceholders"];
}

- (NSAttributedString *)attributedStringFromHTML:(NSString *)HTML limitingImageHeight:(CGFloat)imageHeightLimit
{
    return [self attributedStringFromHTML:HTML limitingImageHeight:imageHeightLimit withTextAttachmentBackgroundColor:[UIColor whiteColor]];
}

- (NSAttributedString *)attributedStringFromHTML:(NSString *)HTML
{
    return [self attributedStringFromHTML:HTML limitingImageHeight:0];
}

- (NSString *)filterElementsOnHTML:(NSString *)HTML
{
    HTML = [self replaceIframesTagsForLinksOnHTML:HTML];
    HTML = [self replaceImgsTagsOnHTML:HTML];
    
    return HTML;
}

- (NSString *)replaceIframesTagsForLinksOnHTML:(NSString *)HTML
{
    SALHTMLParser *parser = [[SALHTMLParser alloc] initWithHTML:HTML];
    
    return [parser replaceTag:@"iframe" withStringUsingBlock:^(TFHppleElement *htmlElement){
        
        NSString *iframeSrc = htmlElement.attributes[@"src"];
        
        return [NSString stringWithFormat:@"<a href='%@'>%@</a>", iframeSrc, iframeSrc];
    }];
}


- (NSString *)replaceImgsTagsOnHTML:(NSString *)HTML
{
    SALHTMLParser *parser = [[SALHTMLParser alloc] initWithHTML:HTML];
    
    return [parser replaceTag:@"img" withStringUsingBlock:^(TFHppleElement *htmlElement){
        
        NSURL *imageURL = [NSURL URLWithString:htmlElement.attributes[@"src"]];
        
        if (!imageURL) {
            NSLog(@"Unable to parse image src, check if url it's malformed");
            
            return htmlElement.raw;
        }
        
        [self.imagesURL addObject:imageURL];
        
        /**
         This is required to work:
         If you don't create an img tag with a valid src it will not generate a NSTextAttachment when calling NSAttributedString initWithData...
         So a 1px image it's downloaded, at least it is cached :/
         **/
        
        return [NSString stringWithFormat:@"<img src='%@' />", kSALDummyImgURL];
    }];
}

- (void)downloadImages
{
    [SALImageDownloader downloadImagesFromURL:self.imagesURL withCompletion:^(UIImage *image, NSUInteger imageURLIndex, NSError *error) {
        
        NSRange range = NSRangeFromString(self.imagesRanges[imageURLIndex]);
        
        SALResizableTextAttachment *resizableTextAttachment = [[SALResizableTextAttachment alloc] init];
        resizableTextAttachment.fitInHeight = self.imageHeightLimit;
        resizableTextAttachment.backgroundColor = self.textAttachmentBackgroundColor;
        resizableTextAttachment.image = image;
        
        [self.delegate textAttachmentDownloaded:resizableTextAttachment inRange:range];
    }];
}



@end
