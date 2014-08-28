//
//  NSAttributedString+SALAttributedStringCustomAttributes.h
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/27/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (SALAttributedStringCustomAttributes)

- (NSDictionary *)addImagePlaceholder:(UIImage *)imagePlaceholder forImagesURL:(NSArray *)imagesURL limitingTextAttachmentHeight:(CGFloat)textAttachmentHeightLimit withTextAttachmentBackgroundColor:(UIColor *)textAttachmentBackgroundColor;

@end
