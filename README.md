# SALAttributedStringExtentions
================================

Improves NSAttributedString functionalities

#### Features

* Download images asynchonously while converting HTML into attributedString.
* Possibility to add a placeholders.

## Example:

###Normal           
![Without](https://s3.amazonaws.com/opensourceprojects/regularsetup.gif "Regular setup")

###SALAttributedStringExtentions           
![With the extentiosn](https://s3.amazonaws.com/opensourceprojects/withextentions.gif "Regular setup")



## Usage

You just need to create a new object and set the delegate:

``objective-c
    SALAttributedStringExtensions *attributedStringExtended = [[SALAttributedStringExtensions alloc] init];
        attributedStringExtended.delegate = self;    
            
                NSAttributedString *attrString = [attributedStringExtended attributedStringFromHTML:HTML limitingImageHeight:300];
                ``
                Implementing the delegates:
                
                ``objective-c
#pragma mark - SALAttributedStringDelegate
                - (UIImage *)imagePlaceholder
                {
                      return [UIImage imageNamed:@"your-image-placeholder-name"];
                      }
                      
                      - (void)textAttachmentDownloaded:(SALResizableTextAttachment *)textAttachment inRange:(NSRange)range
                      {
                            // Just add the textAttachment on your textStorage
                                [self.textView.textStorage addAttribute:NSAttachmentAttributeName value:textAttachment range:range];
                                }
                                ``
                                Other options
                                ``objective-c
                                //Creating without passing a limit height
                                NSAttributedString *attrString = [attributedStringExtended attributedStringFromHTML:HTML];
                                
                                //Creating with a custom textAttachment background color
                                NSAttributedString *attrString = [attributedStringExtended attributedStringFromHTML:HTML withTextAttachmentBackgroundColor:[UIColor blackColor]];
                                ``
                                
                                
## The horizon
                                - [x] Download images asynchonously.
                                - [ ] Cocoapod support. 
                                - [ ] 99% Unit test coverage
                                - [ ] Remove third party framewroks dependency.
                                - [ ] Recoginize data-image-width,height.
                                
