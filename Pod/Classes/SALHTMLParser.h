//
//  SALHTMLParser.h
//  SALAttributedStringExample
//
//  Created by Marcio Klepacz on 8/26/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHppleElement.h"

@interface SALHTMLParser : NSObject

- (instancetype)initWithHTML:(NSString *)HTML;

- (NSString *)replaceTag:(NSString *)HTMLTag withStringUsingBlock:(NSString *(^)(TFHppleElement *htmlElement))blockWithString;

@end
