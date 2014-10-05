//
//  SALImageDownloader.m
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/28/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "SALAttributedStringImageCache.h"
#import <SDWebImage/SDImageCache.h>

static NSString *const SALSharedCacheNamespace = @"sharedCache";

@interface SALAttributedStringImageCache ()

@property (nonatomic, strong) SDImageCache *sdImageCache;

@end

@implementation SALAttributedStringImageCache

+ (instancetype)sharedCache
{
    static SALAttributedStringImageCache *_sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCache = [[self alloc] initWithCacheName:SALSharedCacheNamespace];
    });
    
    return _sharedCache;
}

- (instancetype)initWithCacheName:(NSString *)cacheName
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.sdImageCache = [[SDImageCache alloc] initWithNamespace:cacheName];
    
    return self;
}

- (void)queryImageForKey:(NSString *)key withCompletion:(void(^)(UIImage *image))imageQueryCompletionBlock
{
    if (!imageQueryCompletionBlock) {
        return;
    }
    
    [self.sdImageCache queryDiskCacheForKey:key done:^(UIImage *image, SDImageCacheType cacheType) {
        imageQueryCompletionBlock(image);
    }];
    
}

@end
