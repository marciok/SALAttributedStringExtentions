//
//  SALHTMLParser.m
//  SALAttributedStringExample
//
//  Created by Marcio Klepacz on 8/26/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "SALHTMLParser.h"
#import "TFHpple.h"

@interface SALHTMLParser ()

@property (nonatomic, strong) TFHpple *hppleParser;
@property (nonatomic, copy) NSString *HTML;

@end


@implementation SALHTMLParser

- (instancetype)initWithHTML:(NSString *)HTML
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.hppleParser = [TFHpple hppleWithHTMLData:[HTML dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSArray *allElements = [self.hppleParser searchWithXPathQuery:@"//*"];
    TFHppleElement *documentParentElement = [allElements firstObject];
    HTML = documentParentElement.raw;


    self.HTML = HTML;
    
    return self;
}


- (NSString *)replaceTag:(NSString *)HTMLTag withStringUsingBlock:(NSString *(^)(TFHppleElement *htmlElement))blockWithString
{
    //Validating block
    NSAssert(blockWithString, @"blockWithString can't be nil ");
    
    NSString *xpathQuery = [NSString stringWithFormat:@"//%@", HTMLTag];
    NSArray *tagOccurences = [self.hppleParser searchWithXPathQuery:xpathQuery];
    
    for (TFHppleElement *hppleElement in [tagOccurences reverseObjectEnumerator]) {
        
        NSString *replacementString = blockWithString(hppleElement);
        
        self.HTML = [self.HTML stringByReplacingOccurrencesOfString:hppleElement.raw withString:replacementString];
    }
    
    return self.HTML;
}

@end
