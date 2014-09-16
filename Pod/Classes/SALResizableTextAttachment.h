//
//  SALAutoResizeTextAttachment.h
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/27/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SALResizableTextAttachment : NSTextAttachment

@property (nonatomic, assign) CGFloat fitInHeight;

@property (nonatomic, strong) UIColor *backgroundColor;

@end
