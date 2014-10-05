//
//  SALImageDownloader.m
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/28/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "SALImageDownloader.h"
#import <SDWebImage/SDWebImageManager.h>

@implementation SALImageDownloader

+ (void)downloadImagesFromURL:(NSArray *)imagesURL withCompletion:(void (^)(UIImage *image, NSURL *imageURL, NSUInteger imageURLIndex,  NSError *error))completionBlock
{
    for (NSUInteger i = 0; i < [imagesURL count]; i++) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:imagesURL[i] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            //Note: They are stored in disk.
            //TODO: Allow options on the image downloader.
            if (completionBlock) {
                completionBlock(image, imagesURL[i], i, error);
            }
        }];
    }
}

@end
