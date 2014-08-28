//
//  SALAutoResizeTextAttachment.m
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/27/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "SALResizableTextAttachment.h"
#import "UIImage+SALImageResizeToFit.h"
@import AVFoundation;

@implementation SALResizableTextAttachment //TODO: Rename Class

- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    
    CGFloat lineWidth = CGRectGetWidth(lineFrag);
    
    if (self.fitInHeight) {
        CGSize sizeToFit = CGSizeMake(lineWidth, self.fitInHeight);
        CGSize finalSize = [self scaleImageSizeToFit:CGSizeMake(sizeToFit.width, sizeToFit.height)];
        self.image = [self.image imageByScalingToFillSize:finalSize drawingOnCanvas:sizeToFit withFillColor:self.backgroundColor];
        
        return CGRectMake(0, 0, sizeToFit.width, sizeToFit.height);
    }
    
    return [self scaleImageSizeToWidth:lineWidth];
}

// Scale the image to fit the line width less 10%
- (CGRect)scaleImageSizeToWidth:(float)width
{
    
    float scalingFactor = 1.0;
    
    CGSize imageSize = [self.image size];
    
    if (width < imageSize.width) {
        scalingFactor = (width * 0.9) / imageSize.width;
    }
    
    CGRect rect = CGRectMake(0, 0, imageSize.width * scalingFactor, imageSize.height * scalingFactor);
    
    return rect;
}

- (CGSize)scaleImageSizeToFit:(CGSize)sizeToFit
{
    CGRect imageResizedRect = AVMakeRectWithAspectRatioInsideRect(self.image.size, CGRectMake(0, 0, sizeToFit.width, sizeToFit.height));
    
    return CGSizeMake(CGRectGetWidth(imageResizedRect), CGRectGetHeight(imageResizedRect));
}


@end
