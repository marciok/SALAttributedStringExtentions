//
//  SALMyCustomAttributedStringExtentions.m
//  SALAttributedStringExtentions
//
//  Created by Marcio Klepacz on 9/17/14.
//  Copyright (c) 2014 Marcio Klepacz. All rights reserved.
//

#import "SALMyCustomAttributedStringExtentions.h"
#import <SALAttributedStringExtentions/SALHTMLParser.h>

static NSString * const kSALYouTubeHostURL = @"www.youtube.com";

@interface SALMyCustomAttributedStringExtentions ()

@end

@implementation SALMyCustomAttributedStringExtentions

- (NSString *)replaceIframesTagsForLinksOnHTML:(NSString *)HTML
{
    SALHTMLParser *parser = [[SALHTMLParser alloc] initWithHTML:HTML];
    
    return [parser replaceTag:@"iframe" withStringUsingBlock:^(TFHppleElement *htmlElement){
        
        NSString *iframeSrc = htmlElement.attributes[@"src"];
        
        if ([[[NSURL URLWithString:iframeSrc] host] isEqualToString:kSALYouTubeHostURL]) {
            return  [NSString stringWithFormat:@"<a href='%@'>Tap to watch the video</a>", iframeSrc];
        }
        
        return [NSString stringWithFormat:@"<a href='%@'>%@</a>", iframeSrc, iframeSrc];
    }];
}

- (NSString *)customFiltersHTML:(NSString *)HTML
{
    HTML = [self replaceBlockquotesTagsForParagraph:HTML];
    
    return HTML;
}

- (NSString *)replaceBlockquotesTagsForParagraph:(NSString *)HTML
{
    SALHTMLParser *parser = [[SALHTMLParser alloc] initWithHTML:HTML];
    
    return [parser replaceTag:@"blockquote" withStringUsingBlock:^(TFHppleElement *htmlElement){
        
        NSString *blockQuoteContentHTML = htmlElement.text;
        
        return [NSString stringWithFormat:@"<p>\"%@\"</p>", blockQuoteContentHTML];
    }];
}


@end
