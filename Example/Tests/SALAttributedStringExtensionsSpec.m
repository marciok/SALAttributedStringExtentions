//
//  SALAttributedStringExtensionsSpec.m
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/29/14.
//  Copyright 2014 Seeking Alpha. All rights reserved.
//

#import "SALAttributedStringExtensions.h"

@interface SALAttributedStringExtensions()

- (NSString *)filterElementsOnHTML:(NSString *)HTML;

@property (nonatomic, strong) NSMutableArray *imagesURL;
@property (nonatomic, strong) NSMutableArray *imagesRanges;

@end


SPEC_BEGIN(SALAttributedStringExtensionsSpec)

describe(@"SALAttributedStringExtensions", ^{
    
    __block SALAttributedStringExtensions *sut;
    __block NSAttributedString *convertedAndParsedAttributedString;
    __block NSAttributedString *returnedAttributedString;
    __block NSString *HTML;
    __block NSString *HTMLReplaced;
    
    
    context(@"When converting a HTML to attributed string", ^{
        
        
        beforeAll(^{
            sut = [[SALAttributedStringExtensions alloc] init];
            
            HTML = @"<p><img src='http://fakeimg.pl/500x300/000000/?text=test' /><h2>Header Level 2</h2></p>";
            
            returnedAttributedString = [sut attributedStringFromHTML:HTML];
            
            HTMLReplaced = @"<p><img src='http://s3.amazonaws.com/opensourceprojects/onepiximg.png' /><h2>Header Level 2</h2></p>";
            
            NSData *HTMLData = [HTMLReplaced dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)};
            convertedAndParsedAttributedString = [[NSAttributedString alloc] initWithData:HTMLData options:options documentAttributes:nil error:nil];
        });
        
        it(@"it should call attributedStringFromHTML limitingImageHeight 0 and return convertedAttributedString", ^{
            [[sut should] receive:@selector(attributedStringFromHTML:limitingImageHeight:) andReturn:convertedAndParsedAttributedString withArguments:HTML,theValue(0)];
            
            [sut attributedStringFromHTML:HTML];
            
        });
        
        it(@"it should call attributedStringFromHTML limitingImageHeight 0 withTextAttachmentBackgroundColor white and return convertedAttributedString", ^{
            [[sut should] receive:@selector(attributedStringFromHTML:limitingImageHeight:withTextAttachmentBackgroundColor:) andReturn:convertedAndParsedAttributedString withArguments:HTML,theValue(0),[UIColor whiteColor]];
            
            [sut attributedStringFromHTML:HTML];
            
        });
        
        context(@"when attributedStringFromHTML it's called out of the main thread", ^{
            
            xit(@"should raise an exception", ^{

            });
        });
        
        it(@"should initiate imagesURL", ^{
            [[sut.imagesURL shouldNot] beNil];
        });
        
        context(@"when creating with image height limit", ^{
            __block CGFloat heightLimit;
            
            beforeAll(^{
                heightLimit = 200;
                [sut attributedStringFromHTML:HTML limitingImageHeight:heightLimit];
            });
            
            it(@"should assing imageHeightLimit", ^{
                [[theValue(sut.imageHeightLimit) should] equal:theValue(heightLimit)];
            });
        });
        
        it(@"should call replaceImgsTagsFromHTML", ^{
            [[sut should] receive:@selector(filterElementsOnHTML:) withArguments:HTML];
            
            [sut attributedStringFromHTML:HTML];
        });
        
        context(@"when converting HTML generates an error", ^{            
            
            it(@"should return nil", ^{
                [[[sut attributedStringFromHTML:nil] should] beNil];
            });
            
        });
        
    });

});

SPEC_END
