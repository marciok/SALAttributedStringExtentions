//
//  NSURL+SALURLDataDetection.m
//  Pods
//
//  Created by Marcio Klepacz on 10/5/14.
//
//

#import "NSURL+SALAttributedStringExtentionsURLDataDetection.h"

@implementation NSURL (SALAttributedStringExtentionsURLDataDetection)

- (BOOL)hasImageExtension
{
    NSString *urlString = [self absoluteString];
    NSString *lastPath = [urlString lastPathComponent];
    
    NSArray *imageFileTypes = @[@".jpg", @".png", @".gif", @".jpeg", @".bmp", @".tiff"];
    
    for (NSString *fileType in imageFileTypes) {
        
        if ([lastPath rangeOfString:fileType].location != NSNotFound) {
            return YES;
        }
        
        if ([lastPath rangeOfString:[fileType uppercaseString]].location != NSNotFound) {
            return YES;
        }
    }
    
    return NO;
}

@end
