//
//  UIImage+SALGenerateImage.h
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/28/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SALGenerateImage)

//canvasSize and fillColor are required.
//strokeColor and cornerRadius are optional.
- (UIImage *)imageByDrawingOnCanvas:(CGSize)canvasSize withFillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor withCornerRadius:(CGFloat)cornerRadius;

@end
