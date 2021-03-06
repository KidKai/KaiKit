//
//  KaiTvGlobals.m
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

#import "KaiTvGlobals.h"

CGRect screenBounds()
{
    return UIScreen.mainScreen.bounds;
}

CGFloat screenWidth()
{
    return CGRectGetWidth(screenBounds());
}

CGFloat screenHeight()
{
    return CGRectGetHeight(screenBounds());
}

NSString *sysVersion()
{
    return UIDevice.currentDevice.systemVersion;
}

NSString *bundleName()
{
    id dict = NSBundle.mainBundle.infoDictionary;
    return [dict valueForKey:@"CFBundleName"];
}

NSString *appVersion()
{
    NSDictionary *dict = NSBundle.mainBundle.infoDictionary;
    return [dict valueForKey:@"CFBundleShortVersionString"];
}

static UIViewController *playgroundUnder(UIViewController *controller)
{
    if ([controller isKindOfClass:[UITabBarController classForCoder]]) {
        UITabBarController *tab = (UITabBarController *)controller;
        return playgroundUnder(tab.selectedViewController);
    }
    if ([controller isKindOfClass:[UINavigationController classForCoder]]) {
        UINavigationController *nav = (UINavigationController *)controller;
        return playgroundUnder(nav.visibleViewController);
    }
    UIViewController *presentedController = controller.presentedViewController;
    if (presentedController) return playgroundUnder(presentedController);
    return controller;
}

UIViewController *rootground()
{
    UIApplication *app = UIApplication.sharedApplication;
    return app.keyWindow.rootViewController;
}

UIViewController *playground()
{
    return playgroundUnder(rootground());
}
