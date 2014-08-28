//
//  UIImage+SALImageResizeToFit.h
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/28/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SALImageResizeToFit)

- (UIImage *)imageByScalingToFillSize:(CGSize)newImageSize drawingOnCanvas:(CGSize)canvasSize withFillColor:(UIColor *)fillColor;

@end
