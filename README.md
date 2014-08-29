SALAttributedStringExtentions
================================

Improves NSAttributedString functionalities, starting with the convertion from HTML to attributed string
* Asynchrounsly download images.
* Adds placeholder.
* Auto Resize image to fit in line. 

Performance
-----------

###Converting using the default API 
![Without](https://s3.amazonaws.com/opensourceprojects/regularsetup.gif "Regular setup")

###Converting using SALAttributedStringExtentions           
![With the extentiosn](https://s3.amazonaws.com/opensourceprojects/withextentions.gif "Regular setup")

## Instalation
Copy SALAttributedStringExtentions folder into your project.

## Usage

Just need to create a new object and set the delegate:

```objective-c
SALAttributedStringExtensions *attributedStringExtended = [[SALAttributedStringExtensions alloc] init];
attributedStringExtended.delegate = self;    
            
NSAttributedString *attrString = [attributedStringExtended attributedStringFromHTML:HTML limitingImageHeight:300];
 ```
Implementing the delegates:

```objective-c
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
```
Other options:

```objective-c
//Creating without passing a limit height
NSAttributedString *attrString = [attributedStringExtended attributedStringFromHTML:HTML];
                                
//Creating with a custom textAttachment background color
NSAttributedString *attrString = [attributedStringExtended attributedStringFromHTML:HTML withTextAttachmentBackgroundColor:[UIColor blackColor]];
```
                                
## The horizon
- [x] Download images asynchonously.
- [ ] Add to Cocoapod.
- [ ] Tap to enlarge images.
- [ ] Iframe support.
- [ ] Table support.
- [ ] Youtube support.
- [ ] 99% Unit test coverage
- [ ] Remove third party framewroks dependency.
- [ ] Recoginize data-image-width,height.
                                
## License 
SALAttributedStringExtentions is available under the MIT license. See the LICENSE file for more info.

## Credits
Thanks [@natanrolnik](https://github.com/natanrolnik) for the inspiration.
