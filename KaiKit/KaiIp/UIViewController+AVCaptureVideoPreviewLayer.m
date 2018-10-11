//
//  UIViewController+AVCaptureVideoPreviewLayer.m
//
//  Copyright (c) 2018 KidKai
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "UIViewController+AVCaptureVideoPreviewLayer.h"
#import "UIViewController+KKNavigationBar.h"
#import "UIAlertController+Blocks.h"
#import <AVKit/AVKit.h>

@implementation UIViewController (AVCaptureVideoPreviewLayer)

- (BOOL)presentCameraAlertController
{
    AVAuthorizationStatus avAuthorizationStatus =
    [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (avAuthorizationStatus == AVAuthorizationStatusRestricted ||
        avAuthorizationStatus == AVAuthorizationStatusDenied) {
        id dictionKey = @"NSCameraUsageDescription";
        id dictionary = NSBundle.mainBundle.infoDictionary;
        NSString *message = [dictionary valueForKey:dictionKey];
        NSString *cancelButtonTitle = NSLocalizedString(@"知道了", @"");
        NSArray *otherButtonTitles = @[NSLocalizedString(@"设置", @"")];
        
        [UIAlertController
         showAlertInViewController:self
         withTitle:nil
         message:NSLocalizedString(message, @"")
         cancelButtonTitle:cancelButtonTitle
         destructiveButtonTitle:nil
         otherButtonTitles:otherButtonTitles
         tapBlock:^(UIAlertController * _Nonnull controller,
                    UIAlertAction * _Nonnull action,
                    NSInteger buttonIndex) {
             if (buttonIndex == controller.cancelButtonIndex) {
                 [self popOrDismissViewControllerAnimated:YES];
             }
             if (buttonIndex == controller.firstOtherButtonIndex) {
                 NSString *string = UIApplicationOpenSettingsURLString;
                 NSURL *url = [[NSURL alloc] initWithString:string];
                 [[UIApplication sharedApplication] openURL:url];
             }
         }];
        return YES;
    }
    return NO;
}

@end
