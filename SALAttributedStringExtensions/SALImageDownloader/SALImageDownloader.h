//
//  SALImageDownloader.h
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/28/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SALImageDownloader : NSObject

+ (void)downloadImagesFromURL:(NSArray *)imagesURL withCompletion:(void (^)(UIImage *image, NSUInteger imageURLIndex, NSError *error))completionBlock;

@end
