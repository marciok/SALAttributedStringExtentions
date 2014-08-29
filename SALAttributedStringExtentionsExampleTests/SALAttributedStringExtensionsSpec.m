//
//  SALAttributedStringExtensionsSpec.m
//  SALAttributedStringExtentionsExample
//
//  Created by Marcio Klepacz on 8/29/14.
//  Copyright 2014 Seeking Alpha. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "SALAttributedStringExtensions.h"


SPEC_BEGIN(SALAttributedStringExtensionsSpec)

describe(@"SALAttributedStringExtensions", ^{
    
    __block SALAttributedStringExtensions *sut;
    __block NSAttributedString *convertedAttributedString;
    __block NSString *HTML;
    
    
    context(@"When converting a HTML to attributed string", ^{
        
        beforeAll(^{
            sut = [[SALAttributedStringExtensions alloc] init];
            
            HTML = @"<img src='http://fakeimg.pl/500x300/000000/?text=%@' /><h2>Header Level 2</h2> <ol> <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li><li>Aliquam tincidunt mauris eu risus.</li> </ol> <blockquote><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at felis aliquet congue. Ut a est eget ligula molestie gravida. Curabitur massa. Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam. Vivamus pretium ornare est.</p></blockquote> <h3>Header Level 3</h3> <ul> <li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li> <li>Aliquam tincidunt mauris eu risus.</li></ul>";
                convertedAttributedString = [sut attributedStringFromHTML:HTML];
        });
        
        it(@"it should call attributedStringFromHTML with limitingImageHeight 0 and return convertedAttributedString", ^{
            [[sut should] receive:@selector(attributedStringFromHTML:limitingImageHeight:) andReturn:convertedAttributedString withArguments:HTML,0];
            [sut attributedStringFromHTML:HTML];
            
        });
        
        context(@"when attributedStringFromHTML it's called out of the main thread", ^{
            
            xit(@"should throw an exception", ^{

            });
            
        });
    });

});

SPEC_END
