//
//  UIImage+SALGenerateImage.m
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/28/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "UIImage+SALGenerateImage.h"

@implementation UIImage (SALGenerateImage)

- (UIImage *)imageByDrawingOnCanvas:(CGSize)canvasSize withFillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor withCornerRadius:(CGFloat)cornerRadius
{
    NSCParameterAssert(fillColor);
    
    CGFloat width = canvasSize.width;
    CGFloat height = canvasSize.height;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), YES, 0.0);
    UIGraphicsPushContext(UIGraphicsGetCurrentContext());
    
    
    
    if (cornerRadius > 0) {
        //Adding a background color
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [[UIColor whiteColor] CGColor]);
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height));
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, height) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight |UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        
        [fillColor setFill];
        [path addClip];
        [path fill];
        
        if (strokeColor) {
            [strokeColor setStroke];
            [path stroke];
        }
    }
    else {
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), [fillColor CGColor]);
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height));
    }
    
    //Drawing:
    [self drawAtPoint:CGPointMake((width / 2.0f) - (self.size.width / 2.0f), (height / 2.0f) - (self.size.height / 2.0f))];
    
    // Clean up and get the new image.
    UIGraphicsPopContext();
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
