//
//  SALViewController.m
//  SALAttributedStringExample
//
//  Created by Marcio Klepacz on 8/26/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "SALViewController.h"
#import "SALMyCustomAttributedStringExtentions.h"
#import "UIImage+SALGenerateImage.h"

@interface SALViewController ()

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) UIImage *placeholder;

@end

@implementation SALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableString *superDuperImgTags = [NSMutableString string];
    
    for (NSUInteger i = 0; i < 50; i++) {
        [superDuperImgTags appendString:[NSString stringWithFormat:@"<img src='http://fakeimg.pl/500x300/000000/?text=%@' /><h2>Header Level 2</h2> <ol> <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li><li>Aliquam tincidunt mauris eu risus.</li> </ol> <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.<iframe src='http://www.google.com/'></iframe> Vivamus magna. Cras in mi at  <iframe width='420' height='315' src='http://www.youtube.com/embed/QH2-TGUlwu4' frameborder='0' allowfullscreen></iframe>felis aliquet <table><tr><td>Hi I'm table</td></tr></table> congue. Ut a est eget ligula molestie gravida.<blockquote> Curabitur massa. Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam.</blockquote> Vivamus pretium ornare est.</p> <h3>Header Level 3</h3> <ul> <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li> <li>Aliquam tincidunt mauris eu risus.</li></ul>", [SALViewController randomString:10]]];
    }
    
    NSString *HTML = [NSString stringWithFormat:@"<h1>HTML Ipsum Presents</h1>%@", superDuperImgTags];
    
    SALMyCustomAttributedStringExtentions *attributedStringExtended = [[SALMyCustomAttributedStringExtentions alloc] init];
    attributedStringExtended.delegate = self;
    
    NSAttributedString *attrString = [attributedStringExtended attributedStringFromHTML:HTML limitingImageHeight:300];
    
    self.textView.editable = NO;
    self.textView.attributedText = attrString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SALAttributedStringDelegate

- (UIImage *)imagePlaceholder
{
    return self.placeholder;
}

- (void)textAttachmentDownloaded:(SALResizableTextAttachment *)textAttachment inRange:(NSRange)range
{
    [self.textView.textStorage addAttribute:NSAttachmentAttributeName value:textAttachment range:range];
}

#pragma mark - Utils

- (UIImage *)placeholder
{
    if (_placeholder) {
        return _placeholder;
    }
    
    //Finding placeholder width;
    CGSize placeholderSize = CGSizeMake(500, 300);
    
    UIImage *placeholderAlphaImage = [UIImage imageNamed:@"placeholder"];
    
    _placeholder = [placeholderAlphaImage imageByDrawingOnCanvas:placeholderSize withFillColor:[UIColor colorWithWhite:0.9 alpha:1.0] strokeColor:[UIColor colorWithWhite:0.75 alpha:1.0] withCornerRadius:20];
    
    return _placeholder;
}

static const char __alphabet[] = "0123456789" "ABCDEFGHIJKLMNOPQRSTUVWXYZ" "abcdefghijklmnopqrstuvwxyz";

+ (NSString *)randomString:(int)length
{
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    u_int32_t alphabetLength = (u_int32_t)strlen(__alphabet);
    for (int i = 0; i < length; i++) {
        [randomString appendFormat:@"%c", __alphabet[arc4random_uniform(alphabetLength)]];
    }
    return randomString;
}

@end
