//
//  SALAttributedString.h
//  SALAttributedStringExample
//
//  Created by Marcio Klepacz on 8/26/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SALResizableTextAttachment;

@protocol SALAttributedStringDelegate <NSObject>

@optional

- (UIImage *)imagePlaceholder;

@required

- (void)textAttachmentDownloaded:(SALResizableTextAttachment *)textAttachment inRange:(NSRange)range;

@end

@interface SALAttributedStringExtensions : NSObject

- (NSAttributedString *)attributedStringFromHTML:(NSString *)HTML limitingImageHeight:(CGFloat)imageHeightLimit withTextAttachmentBackgroundColor:(UIColor *)textAttachmentBackgroundColor;

- (NSAttributedString *)attributedStringFromHTML:(NSString *)HTML limitingImageHeight:(CGFloat)imageHeightLimit;

- (NSAttributedString *)attributedStringFromHTML:(NSString *)HTML;

@property (nonatomic, weak) id <SALAttributedStringDelegate> delegate;

@property (nonatomic, assign) CGFloat imageHeightLimit;

@property (nonatomic, strong) UIColor *textAttachmentBackgroundColor;

@property (nonatomic, copy) NSSet *htmlTagsToReplace;

@end
