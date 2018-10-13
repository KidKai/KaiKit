//
//  UIWebView+TS_JavaScriptContext.h
//
//  Created by Nicholas Hodapp on 11/15/13.
//  Copyright (c) 2013 CoDeveloper, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

API_UNAVAILABLE(tvos) @protocol TSWebViewDelegate <UIWebViewDelegate>

@optional
- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)ctx API_DEPRECATED("No longer supported.", ios(2.0, 12.0));

@end

UIKIT_EXTERN API_DEPRECATED("No longer supported; please adopt WKWebView.", ios(2.0, 12.0)) API_UNAVAILABLE(tvos, macos) @interface UIWebView (TS_JavaScriptContext)

@property (nonatomic, readonly) JSContext *ts_javaScriptContext;

@end
