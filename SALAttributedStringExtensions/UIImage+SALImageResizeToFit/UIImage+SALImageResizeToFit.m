//
//  UIImage+SALImageResizeToFit.m
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/28/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "UIImage+SALImageResizeToFit.h"

@implementation UIImage (SALImageResizeToFit)

- (UIImage *)imageByScalingToFillSize:(CGSize)newImageSize drawingOnCanvas:(CGSize)canvasSize withFillColor:(UIColor *)fillColor
{
    CGFloat width = canvasSize.width;
    CGFloat height = canvasSize.height;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), YES, 0.0);
    UIGraphicsPushContext(UIGraphicsGetCurrentContext());
    
    //Adding a background color
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [fillColor CGColor]);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height));
    
    //Drawing:
    [self drawInRect:CGRectMake((width - newImageSize.width) / 2.0f, (height - newImageSize.height) / 2.0f, newImageSize.width, newImageSize.height)];
    
    // Clean up and get the new image.
    UIGraphicsPopContext();
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
