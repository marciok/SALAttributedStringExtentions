//
//  SALImageDownloader.h
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/28/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SALImageCache : NSObject

+ (instancetype)sharedCache; 

- (void)queryImageForKey:(NSString *)key withCompletion:(void (^)(UIImage *image))imageQueryCompletionBlock;

@end
