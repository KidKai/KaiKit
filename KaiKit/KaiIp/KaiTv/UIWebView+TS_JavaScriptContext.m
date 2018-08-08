//
//  UIWebView+TS_JavaScriptContext.m
//
//  Created by Nicholas Hodapp on 11/15/13.
//  Copyright (c) 2013 CoDeveloper, LLC. All rights reserved.
//

#import "UIWebView+TS_JavaScriptContext.h"
#import <objc/runtime.h>

static NSHashTable *g_webViews = nil;

@interface UIWebView (TS_JavaScriptCore_private)
- (void)ts_didCreateJavaScriptContext:(JSContext *)ts_javaScriptContext;
@end

@protocol TSWebFrame <NSObject>
- (id)parentFrame;
@end

@implementation NSObject (TS_JavaScriptContext)

- (void)webView:(id)unused didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id<TSWebFrame>)frame
{
    NSParameterAssert([frame respondsToSelector:@selector(parentFrame)]);
    
    // Only interested in root-level frames.
    if ([frame respondsToSelector:@selector(parentFrame)] && frame.parentFrame) {
        return;
    }
    
    void (^notifyDidCreateJavaScriptContext)(void) = ^{
        for (UIWebView *webView in g_webViews) {
            NSString *cookie = [NSString stringWithFormat:@"ts_jscWebView_%lud", webView.hash];
            NSString *script = [NSString stringWithFormat:@"var %@ = '%@'", cookie, cookie];
            [webView stringByEvaluatingJavaScriptFromString:script];
            
            if ([ctx[cookie].toString isEqualToString:cookie]) {
                [webView ts_didCreateJavaScriptContext:ctx];
                return;
            }
        }
    };
    
    if (NSThread.isMainThread) {
        notifyDidCreateJavaScriptContext();
    } else {
        dispatch_async(dispatch_get_main_queue(), notifyDidCreateJavaScriptContext);
    }
}

@end

@implementation UIWebView (TS_JavaScriptContext)

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_webViews = [NSHashTable weakObjectsHashTable];
    });
    
    NSAssert(NSThread.isMainThread, @"Out of the main thread.");
    
    UIWebView *webView = [super allocWithZone:zone];
    [g_webViews addObject:webView];
    return webView;
}

- (void)ts_didCreateJavaScriptContext:(JSContext *)ts_javaScriptContext
{
    SEL ts_javaSelector = @selector(ts_javaScriptContext);
    [self willChangeValueForKey:NSStringFromSelector(ts_javaSelector)];
    objc_setAssociatedObject(self,
                             ts_javaSelector,
                             ts_javaScriptContext,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:NSStringFromSelector(ts_javaSelector)];
    
    if ([self.delegate respondsToSelector:@selector(webView:didCreateJavaScriptContext:)]) {
        id<TSWebViewDelegate> delegate = (id<TSWebViewDelegate>)self.delegate;
        [delegate webView:self didCreateJavaScriptContext:ts_javaScriptContext];
    }
}

- (JSContext *)ts_javaScriptContext
{
    return (JSContext *)objc_getAssociatedObject(self, _cmd);
}

@end
