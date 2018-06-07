//
//  M2DWebViewController.h
//  BoostMedia
//
//  Created by Akira Matsuda on 2013/01/11.
//  Copyright (c) 2013 akira.matsuda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
#import <WebKit/WebKit.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@protocol M2DWebViewControllerDelegate <NSObject>
@optional

// WKUIDelegate
- (nullable WKWebView *)m2d_webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;
- (void)m2d_webViewDidClose:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0));
- (void)m2d_webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;
- (void)m2d_webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;
- (void)m2d_webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler;
- (BOOL)m2d_webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo API_AVAILABLE(ios(10.0));
- (nullable UIViewController *)m2d_webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id<WKPreviewActionItem>> *)previewActions API_AVAILABLE(ios(10.0));
- (void)m2d_webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController API_AVAILABLE(ios(10.0));

// WKNavigationDelegate
- (void)m2d_webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
- (void)m2d_webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;
- (void)m2d_webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
- (void)m2d_webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation;
- (void)m2d_webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
- (void)m2d_webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation;
- (void)m2d_webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation;
- (void)m2d_webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
- (void)m2d_webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;
- (void)m2d_webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0));

// UIWebViewDelegate
- (BOOL)m2d_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)m2d_webViewDidFinishLoad:(UIWebView *)webView;
- (void)m2d_webViewDidStartLoad:(UIWebView *)webView;
- (void)m2d_webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end

@class M2DWebViewController;

typedef NS_ENUM(NSUInteger, M2DWebViewType) {
    M2DWebViewTypeUIKit,
    M2DWebViewTypeWebKit,
    M2DWebViewTypeAutoSelect,
};

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
@interface M2DWebViewController : UIViewController <WKUIDelegate, WKNavigationDelegate, UIWebViewDelegate>
#else
@interface M2DWebViewController : UIViewController <UIWebViewDelegate>
#endif

@property (nonatomic, readonly) id _Nullable webView;
@property (nonatomic, assign) BOOL toolbarHidden;
@property (nonatomic, assign) BOOL smoothScroll;
@property (nonatomic, weak) id<M2DWebViewControllerDelegate> _Nullable delegate;
@property (nonatomic, copy) void (^actionButtonPressedHandler)(NSString * _Nullable pageTitle, NSURL * _Nullable url);

- (instancetype)initWithURL:(nullable NSURL *)url type:(M2DWebViewType)type;
- (instancetype)initWithURL:(nullable NSURL *)url type:(M2DWebViewType)type backArrowImage:(nullable UIImage *)backArrowImage forwardArrowImage:(nullable UIImage *)forwardArrowImage;
- (instancetype)initWithConfiguration:(WKWebViewConfiguration *)configuration url:(nullable NSURL *)url;
- (instancetype)initWithConfiguration:(WKWebViewConfiguration *)configuration url:(nullable NSURL *)url backArrowImage:(nullable UIImage *)backArrowImage forwardArrowImage:(nullable UIImage *)forwardArrowImage;
- (void)goForward:(id)sender;
- (void)goBack:(id)sender;
- (void)refresh:(id)sender;
- (void)stop:(id)sender;
- (void)doAction:(id)sender;
- (void)loadURL:(nullable NSURL *)url;
- (void)setSmoothScroll:(BOOL)smoothScroll;
- (void)setToolbarHidden:(BOOL)toolbarHidden;

@end

NS_ASSUME_NONNULL_END
