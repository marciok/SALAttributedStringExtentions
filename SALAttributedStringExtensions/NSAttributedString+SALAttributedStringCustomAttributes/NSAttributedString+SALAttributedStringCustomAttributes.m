//
//  NSAttributedString+SALAttributedStringCustomAttributes.m
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/27/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "NSAttributedString+SALAttributedStringCustomAttributes.h"
#import "SALResizableTextAttachment.h"

@implementation NSAttributedString (SALAttributedStringCustomAttributes)

- (NSDictionary *)addImagePlaceholder:(UIImage *)imagePlaceholder forImagesURL:(NSArray *)imagesURL limitingTextAttachmentHeight:(CGFloat)textAttachmentHeightLimit withTextAttachmentBackgroundColor:(UIColor *)textAttachmentBackgroundColor
{
    NSMutableAttributedString *attributedStringWithPlaceholders = [self mutableCopy];
    __block NSUInteger imageURLIndex = 0;
    NSMutableArray *imagesRange = [NSMutableArray array];
    
    NSRange attributedStringFullRange = NSMakeRange(0, self.length);
    
    [self enumerateAttribute:NSAttachmentAttributeName inRange:attributedStringFullRange options:NSAttributedStringEnumerationReverse usingBlock:^(id value, NSRange range, BOOL *stop) {
        
        NSTextAttachment *textAttchment = value;
        
        if (textAttchment) {
            SALResizableTextAttachment *resizableTextAttachment = [[SALResizableTextAttachment alloc] init];
            resizableTextAttachment.fitInHeight = textAttachmentHeightLimit;
            resizableTextAttachment.backgroundColor = textAttachmentBackgroundColor;
            resizableTextAttachment.image = resizableTextAttachment.image ?: imagePlaceholder;
            
            [attributedStringWithPlaceholders addAttribute:NSAttachmentAttributeName value:resizableTextAttachment range:range];
            [attributedStringWithPlaceholders addAttribute:NSLinkAttributeName value:imagesURL[imageURLIndex] range:range];
            
            [imagesRange addObject:NSStringFromRange(range)];
            
            imageURLIndex++;
        }        
        
        
    }];
    
    return @{@"attributedStringWithPlaceholders" : [[NSAttributedString alloc] initWithAttributedString:attributedStringWithPlaceholders], @"imagesRange" : imagesRange};
}

@end
