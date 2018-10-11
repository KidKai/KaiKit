//
//  UIViewController+KKNavigationBar.m
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

#import "UIViewController+KKNavigationBar.h"
#import "UIView+KKViewGeometry.h"
#import <objc/runtime.h>

@implementation UIViewController (KKNavigationBar)

- (UIView *)kkNavigationBar
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setKkNavigationBar:(UIView *)kkNavigationBar
{
    objc_setAssociatedObject(self, @selector(kkNavigationBar), kkNavigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)kkNavigationBarHeight
{
    return self.kkNavigationBar.height;
}

- (UIColor *)kkNavigationBarTintColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setKkNavigationBarTintColor:(UIColor *)kkNavigationBarTintColor
{
    objc_setAssociatedObject(self, @selector(kkNavigationBarTintColor), kkNavigationBarTintColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    id navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[[UIImage alloc] init]
                        forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // Associated kkNavigationBar added or renew.
    if (!kkNavigationBarTintColor) {
        [self.kkNavigationBar removeFromSuperview];
        [self setKkNavigationBar:nil];
        return;
    }
    
    UIView *kkNavigationBar = self.kkNavigationBar;
    if (!kkNavigationBar) {
        kkNavigationBar = [[UIView alloc] initWithFrame:CGRectZero];
    }
    kkNavigationBar.backgroundColor = kkNavigationBarTintColor;
    [self setKkNavigationBar:kkNavigationBar];
}

- (void)popOrDismissViewControllerAnimated:(BOOL)flag
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.navigationController.viewControllers.count < 2) {
            [self dismissViewControllerAnimated:flag completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:flag];
        }
    });
}

- (void)popToRootOrDismissViewControllerAnimated:(BOOL)flag
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.navigationController.viewControllers.count < 2) {
            [self dismissViewControllerAnimated:flag completion:nil];
        } else {
            [self.navigationController popToRootViewControllerAnimated:flag];
        }
    });
}

@end
