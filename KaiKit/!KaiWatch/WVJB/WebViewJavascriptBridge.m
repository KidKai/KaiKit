//
//  WebViewJavascriptBridge.m
//
//  Created by Marcus Westin on 6/14/13.
//  Copyright (c) 2013 Marcus Westin. All rights reserved.
//

#import "WebViewJavascriptBridge.h"

#ifdef supportsWKWebView
#import "WKWebViewJavascriptBridge.h"
#endif

#if __has_feature(objc_arc_weak)
#define WVJB_WEAK __weak
#else
#define WVJB_WEAK __unsafe_unretained
#endif

#if !TARGET_OS_TV

@implementation WebViewJavascriptBridge {
    WVJB_WEAK WVJB_WEBVIEW_TYPE *_webView;
    WVJB_WEAK id _webViewDelegate;
    long _uniqueId;
    WebViewJavascriptBridgeBase *_base;
}

#pragma mark - API

+ (void)enableLogging { [WebViewJavascriptBridgeBase enableLogging]; }

+ (void)setLogMaxLength:(int)length {
    [WebViewJavascriptBridgeBase setLogMaxLength:length];
}

+ (instancetype)bridgeForWebView:(id)webView {
#ifdef supportsWKWebView
    if ([webView isKindOfClass:[WKWebView class]]) {
        return (WebViewJavascriptBridge *)[WKWebViewJavascriptBridge bridgeForWebView:webView];
    }
#endif
    if ([webView isKindOfClass:[WVJB_WEBVIEW_TYPE class]]) {
        WebViewJavascriptBridge *bridge = [[self alloc] init];
        [bridge _platformSpecificSetup:webView];
        return bridge;
    }
    [NSException raise:@"BadWebViewType" format:@"Unknown web view type."];
    return nil;
}

- (void)setWebViewDelegate:(WVJB_WEBVIEW_DELEGATE_TYPE)webViewDelegate {
    _webViewDelegate = webViewDelegate;
}

- (void)send:(id)data {
    [self send:data responseCallback:nil];
}

- (void)send:(id)data responseCallback:(WVJBResponseCallback)responseCallback {
    [_base sendData:data responseCallback:responseCallback handlerName:nil];
}

- (void)callHandler:(NSString *)handlerName {
    [self callHandler:handlerName data:nil responseCallback:nil];
}

- (void)callHandler:(NSString *)handlerName data:(id)data {
    [self callHandler:handlerName data:data responseCallback:nil];
}

- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback {
    [_base sendData:data responseCallback:responseCallback handlerName:handlerName];
}

- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)handler {
    _base.messageHandlers[handlerName] = [handler copy];
}

- (void)removeHandler:(NSString *)handlerName {
    [_base.messageHandlers removeObjectForKey:handlerName];
}

- (void)disableJavscriptAlertBoxSafetyTimeout {
    [_base disableJavscriptAlertBoxSafetyTimeout];
}

#pragma mark - Platform Agnostic Internals

- (void)dealloc {
    [self _platformSpecificDealloc];
    _base = nil;
    _webView = nil;
    _webViewDelegate = nil;
}

- (NSString *)_evaluateJavascript:(NSString *)javascriptCommand {
    return [_webView stringByEvaluatingJavaScriptFromString:javascriptCommand];
}

#ifdef WVJB_PLATFORM_OSX
#pragma mark Platform Agnostic Internals: OSX

- (void)_platformSpecificSetup:(WVJB_WEBVIEW_TYPE *)webView {
    _webView = webView;
    _webView.policyDelegate = self;
    _base = [[WebViewJavascriptBridgeBase alloc] init];
    _base.delegate = self;
}

- (void)_platformSpecificDealloc {
    _webView.policyDelegate = nil;
}

- (void)webView:(WebView *)webView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id<WebPolicyDecisionListener>)listener {
    if (webView != _webView) { return; }
    
    NSURL *url = [request URL];
    if ([_base isWebViewJavascriptBridgeURL:url]) {
        if ([_base isBridgeLoadedURL:url]) {
            [_base injectJavascriptFile];
        } else if ([_base isQueueMessageURL:url]) {
            NSString *messageQueueString = [self _evaluateJavascript:[_base webViewJavascriptFetchQueue]];
            [_base flushMessageQueue:messageQueueString];
        } else {
            [_base logUnknownMessage:url];
        }
        [listener ignore];
    } else if (_webViewDelegate && [_webViewDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:request:frame:decisionListener:)]) {
        [_webViewDelegate webView:webView decidePolicyForNavigationAction:actionInformation request:request frame:frame decisionListener:listener];
    } else {
        [listener use];
    }
}

#endif

#ifdef WVJB_PLATFORM_IOS
#pragma mark Platform Agnostic Internals: iOS

- (void)_platformSpecificSetup:(WVJB_WEBVIEW_TYPE *)webView {
    _webView = webView;
    _webView.delegate = self;
    _base = [[WebViewJavascriptBridgeBase alloc] init];
    _base.delegate = self;
}

- (void)_platformSpecificDealloc {
    _webView.delegate = nil;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView != _webView) { return; }
    
    __strong WVJB_WEBVIEW_DELEGATE_TYPE strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [strongDelegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (webView != _webView) { return; }
    
    __strong WVJB_WEBVIEW_DELEGATE_TYPE strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [strongDelegate webView:webView didFailLoadWithError:error];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (webView != _webView) { return YES; }
    
    NSURL *url = [request URL];
    if ([_base isWebViewJavascriptBridgeURL:url]) {
        if ([_base isBridgeLoadedURL:url]) {
            [_base injectJavascriptFile];
        } else if ([_base isQueueMessageURL:url]) {
            NSString *messageQueueString = [self _evaluateJavascript:[_base webViewJavascriptFetchQueue]];
            [_base flushMessageQueue:messageQueueString];
        } else {
            [_base logUnknownMessage:url];
        }
        return NO;
    }
    
    __strong WVJB_WEBVIEW_DELEGATE_TYPE strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [strongDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (webView != _webView) { return; }
    
    __strong WVJB_WEBVIEW_DELEGATE_TYPE strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [strongDelegate webViewDidStartLoad:webView];
    }
}

#endif

@end

#endif
