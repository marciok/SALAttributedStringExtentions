//
//  SALViewController.m
//  SALAttributedStringExample
//
//  Created by Marcio Klepacz on 8/26/14.
//  Copyright (c) 2014 Seeking Alpha. All rights reserved.
//

#import "SALViewController.h"
#import "SALAttributedStringExtensions.h"

@interface SALViewController ()

@property (nonatomic, strong) IBOutlet UITextView *textView;

@end

@implementation SALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableString *superDuperImgTags = [NSMutableString string];
    
    for (NSUInteger i = 0; i < 22; i++) {
        [superDuperImgTags appendString:[NSString stringWithFormat:@"<img src='http://fakeimg.pl/500/?text=%@' /><h2>Header Level 2</h2> <ol> <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li><li>Aliquam tincidunt mauris eu risus.</li> </ol> <blockquote><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at felis aliquet congue. Ut a est eget ligula molestie gravida. Curabitur massa. Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam. Vivamus pretium ornare est.</p></blockquote> <h3>Header Level 3</h3> <ul> <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li> <li>Aliquam tincidunt mauris eu risus.</li></ul>", [SALViewController randomString:10]]];
    }
    
    NSString *HTML = [NSString stringWithFormat:@"<h1>HTML Ipsum Presents</h1>%@", superDuperImgTags];
    
    SALAttributedStringExtensions *attributedStringExtended = [[SALAttributedStringExtensions alloc] init];
    attributedStringExtended.delegate = self;
    
    NSAttributedString *attrString = [attributedStringExtended attributedStringFromHTML:HTML limitingImageHeight:300];
    
//    NSAttributedString *attrString = [attributedStringExtended attributedStringFromHTML:HTML];
//    NSAttributedString *attrString = [[NSAttributedString alloc] initWithData:[HTML dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)} documentAttributes:nil error:nil];
    
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
    return [UIImage imageNamed:@"placeholder.jpg"];
}

- (void)textAttachmentDownloaded:(SALResizableTextAttachment *)textAttachment inRange:(NSRange)range
{
    [self.textView.textStorage addAttribute:NSAttachmentAttributeName value:textAttachment range:range];
}

#pragma mark - Utils

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
