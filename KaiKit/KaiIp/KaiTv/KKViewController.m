//
//  KKViewController.m
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

#import "KKViewController.h"
#import "UIViewController+KKNavigationBar.h"

#import "KaiIpGlobals.h"
#import "UIView+KKViewGeometry.h"

@implementation KKViewController

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size
          withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id  _Nonnull context) {
        UIView *navigationBar = self.navigationController.navigationBar;
        CGFloat height = navigationBar.maxY - self.kkNavigationBar.minY;
        self.kkNavigationBar.width = navigationBar.width;
        self.kkNavigationBar.height = height > 0.f ? height : 0.f;
    } completion:^(id  _Nonnull context) {
        UIView *navigationBar = self.navigationController.navigationBar;
        if (navigationBar.width == self.kkNavigationBar.width) return;
        CGFloat height = navigationBar.maxY - self.kkNavigationBar.minY;
        self.kkNavigationBar.width = navigationBar.width;
        self.kkNavigationBar.height = height > 0.f ? height : 0.f;
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didChangePreferredContentSize:)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.kkNavigationBar && !self.kkNavigationBar.superview) {
        [self.view addSubview:self.kkNavigationBar];
        UIView *navigationBar = self.navigationController.navigationBar;
        if (navigationBar.width == self.kkNavigationBar.width) return;
        CGFloat height = navigationBar.maxY - self.kkNavigationBar.minY;
        self.kkNavigationBar.width = navigationBar.width;
        self.kkNavigationBar.height = height > 0.f ? height : 0.f;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNavigationBarColors];
    });
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    id controller = self.navigationController.viewControllers.lastObject;
    if ([controller isKindOfClass:[KKViewController class]]) {
        [controller animateNavigationBarColors];
    }
    [self.view endEditing:YES];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (self.kkNavigationBar && self.kkNavigationBar.superview) {
        [self.view bringSubviewToFront:self.kkNavigationBar];
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    NSUInteger count = self.navigationController.viewControllers.count;
    id controller = self.navigationController.viewControllers.lastObject;
    if ([controller isKindOfClass:[KKViewController class]]) {
        if (controller == self && count > 1) {
            id papa = self.navigationController.viewControllers[count - 2];
            if ([papa isKindOfClass:[KKViewController class]]) {
                [papa setNavigationBarColors];
            }
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
}

- (void)setPreferredStatusBarStyle1:(UIStatusBarStyle)preferredStatusBarStyle1
{
    _preferredStatusBarStyle1 = preferredStatusBarStyle1;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setNavigationBarColors
{ /* Override in subclasses */ }

- (void)setBeforePopNavigationBarColors
{ /* Override in subclasses */ }

#if TARGET_OS_IOS
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.preferredStatusBarStyle1;
}
#endif

- (void)didChangePreferredContentSize:(NSNotification *)note
{ /* Override in subclasses */ }

- (void)cellularDataRestrictionDidUpdateNotifier
{ /* Override in subclasses */ }

- (void)setAFNetworkReachabilityStatusChangeBlock
{ /* Override in subclasses */ }

- (void)animateNavigationBarColors
{
    [self setBeforePopNavigationBarColors];
    [self.transitionCoordinator
     animateAlongsideTransition:^(id _Nonnull context) {
         [self setNavigationBarColors];
     }
     completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end


@implementation UIViewController (UIStoryboard)

+ (instancetype)storyboardController
{
    id name = NSStringFromClass([self classForCoder]);
    id aBundle = [NSBundle bundleForClass:[self classForCoder]];
    id storyboard = [UIStoryboard storyboardWithName:name bundle:aBundle];
    return [storyboard instantiateViewControllerWithIdentifier:name];
}

@end


@implementation UIView (UIViewController)

- (UIViewController *)viewController
{
    id next = self.superview.nextResponder;
    id vccl = [UIViewController classForCoder];
    while (next != nil && ![next isKindOfClass:vccl]) {
        next = [next nextResponder];
    }
    return (UIViewController *)next;
}

@end
