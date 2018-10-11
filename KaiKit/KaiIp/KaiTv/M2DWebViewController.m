//
//  M2DWebViewController.m
//  BoostMedia
//
//  Created by Akira Matsuda on 2013/01/11.
//  Copyright (c) 2013 akira.matsuda. All rights reserved.
//

#import "M2DWebViewController.h"

static const CGSize M2DArrowIconSize = {10.f, 18.f};
static const CGFloat M2DArrowIconLineWidth = 1.3f;

typedef NS_ENUM(NSUInteger, M2DArrowIconDirection) {
    M2DArrowIconDirectionLeft,
    M2DArrowIconDirectionRight
};

@implementation UIImage (M2DArrowIcon)

+ (UIImage *)m2d_arrowIconWithDirection:(M2DArrowIconDirection)direction size:(CGSize)size
{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        return [[UIImage alloc] init];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = {CGPointZero, size};
    
    CGContextSaveGState(context);
    
    CGContextSetLineJoin(context, kCGLineJoinMiter);
    CGContextSetLineWidth(context, M2DArrowIconLineWidth);
    CGContextBeginPath(context);
    
    if (direction == M2DArrowIconDirectionRight) {
        CGContextMoveToPoint(context, M2DArrowIconLineWidth, M2DArrowIconLineWidth);
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - M2DArrowIconLineWidth, CGRectGetMidY(rect));
        CGContextAddLineToPoint(context, M2DArrowIconLineWidth, CGRectGetMaxY(rect) - M2DArrowIconLineWidth);
    }
    else {
        CGContextMoveToPoint(context, CGRectGetMaxX(rect) - M2DArrowIconLineWidth, M2DArrowIconLineWidth);
        CGContextAddLineToPoint(context, M2DArrowIconLineWidth, CGRectGetMidY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect) - M2DArrowIconLineWidth, CGRectGetMaxY(rect) - M2DArrowIconLineWidth);
    }
    
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    UIImage *icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return icon;
}

@end

@interface M2DWebViewController ()
{
    NSURL *url_;
    UIBarButtonItem *goBackButton_;
    UIBarButtonItem *goForwardButton_;
    UIBarButtonItem *actionButton_;
    id webView_;
    M2DWebViewType type_;
}

@property (nonatomic, copy) UIImage *backArrowImage;
@property (nonatomic, copy) UIImage *forwardArrowImage;

@end

@implementation M2DWebViewController

static NSString * const kM2DWebViewControllerGetTitleScript = @"var elements=document.getElementsByTagName(\'title\');elements[0].innerText";

- (instancetype)initWithURL:(NSURL *)url type:(M2DWebViewType)type
{
    self = [super init];
    if (self) {
        url_ = [url copy];
        type_ = type;
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
            type_ = M2DWebViewTypeUIKit;
        }
        
        switch (type_) {
            case M2DWebViewTypeUIKit: {
                webView_ = [[UIWebView alloc] initWithFrame:self.view.bounds];
                [(UIWebView *)webView_ setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
                ((UIWebView *)webView_).delegate = self;
                [(UIWebView *)webView_ loadRequest:[NSURLRequest requestWithURL:url_]];
            } break;
                
            case M2DWebViewTypeWebKit:
            case M2DWebViewTypeAutoSelect: {
                webView_ = [[WKWebView alloc] initWithFrame:self.view.bounds];
                [(WKWebView *)webView_ setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
                ((WKWebView *)webView_).navigationDelegate = self;
                [(WKWebView *)webView_ loadRequest:[NSURLRequest requestWithURL:url_]];
            } break;
        }
        
        [self.view addSubview:webView_];
    }
    
    return self;
}

- (instancetype)initWithURL:(NSURL *)url type:(M2DWebViewType)type
             backArrowImage:(UIImage *)backArrowImage
          forwardArrowImage:(UIImage *)forwardArrowImage
{
    self = [self initWithURL:url type:type];
    if (self) {
        self.backArrowImage = backArrowImage;
        self.forwardArrowImage = forwardArrowImage;
    }
    
    return self;
}

- (instancetype)initWithConfiguration:(WKWebViewConfiguration *)configuration url:(NSURL *)url
{
    self = [super init];
    if (self) {
        url_ = [url copy];
        type_ = M2DWebViewTypeWebKit;
        webView_ = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        [(WKWebView *)webView_ setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        ((WKWebView *)webView_).navigationDelegate = self;
        [(WKWebView *)webView_ loadRequest:[NSURLRequest requestWithURL:url_]];
        [self.view addSubview:webView_];
    }
    
    return self;
}

- (instancetype)initWithConfiguration:(WKWebViewConfiguration *)configuration url:(NSURL *)url
                       backArrowImage:(UIImage *)backArrowImage
                    forwardArrowImage:(UIImage *)forwardArrowImage
{
    self = [self initWithConfiguration:configuration url:url];
    if (self) {
        self.backArrowImage = backArrowImage;
        self.forwardArrowImage = forwardArrowImage;
    }
    
    return self;
}

- (void)dealloc
{
    [goBackButton_ removeObserver:self forKeyPath:@"enabled" context:NULL];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (id)webView
{
    return webView_;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Loading...", @"");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
#pragma clang diagnostic pop
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:self.toolbarHidden animated:YES];
    if (goBackButton_ == nil) {
        goBackButton_ = [[UIBarButtonItem alloc] initWithImage:self.backArrowImage ?: [UIImage m2d_arrowIconWithDirection:M2DArrowIconDirectionLeft size:M2DArrowIconSize] style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
        goForwardButton_ = [[UIBarButtonItem alloc] initWithImage:self.forwardArrowImage ?: [UIImage m2d_arrowIconWithDirection:M2DArrowIconDirectionRight size:M2DArrowIconSize] style:UIBarButtonItemStylePlain target:self action:@selector(goForward:)];
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *fixedSpace19 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpace19.width = 19.f;
        UIBarButtonItem *fixedSpace6 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixedSpace6.width = 6.f;
        UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
        
        if (self.actionButtonPressedHandler) {
            actionButton_ = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(doAction:)];
            
            self.toolbarItems = @[fixedSpace6, goBackButton_, fixedSpace19, goForwardButton_, space, refreshButton, fixedSpace19, actionButton_, fixedSpace6];
        }
        else {
            self.toolbarItems = @[fixedSpace6, goBackButton_, fixedSpace19, goForwardButton_, space, refreshButton, fixedSpace6];
        }
        
        [goBackButton_ addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        
        goForwardButton_.enabled = NO;
        goBackButton_.enabled = NO;
    }
}

- (void)setSmoothScroll:(BOOL)smoothScroll
{
    _smoothScroll = smoothScroll;
    WKWebView *webView = webView_;
    if (smoothScroll) {
        webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    else {
        webView.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    }
}

- (void)setToolbarHidden:(BOOL)toolbarHidden
{
    _toolbarHidden = toolbarHidden;
    [self.navigationController setToolbarHidden:toolbarHidden animated:YES];
}

#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:createWebViewWithConfiguration:forNavigationAction:windowFeatures:)]) {
        return [self.delegate m2d_webView:webView createWebViewWithConfiguration:configuration forNavigationAction:navigationAction windowFeatures:windowFeatures];
    }
    
    return nil;
}

- (void)webViewDidClose:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0))
{
    if ([self.delegate respondsToSelector:@selector(m2d_webViewDidClose:)]) {
        [self.delegate m2d_webViewDidClose:webView];
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:runJavaScriptAlertPanelWithMessage:initiatedByFrame:completionHandler:)]) {
        [self.delegate m2d_webView:webView runJavaScriptAlertPanelWithMessage:message initiatedByFrame:frame completionHandler:completionHandler];
    }
    else {
        completionHandler();
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:runJavaScriptConfirmPanelWithMessage:initiatedByFrame:completionHandler:)]) {
        [self.delegate m2d_webView:webView runJavaScriptConfirmPanelWithMessage:message initiatedByFrame:frame completionHandler:completionHandler];
    }
    else {
        completionHandler(YES);
    }
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:runJavaScriptTextInputPanelWithPrompt:defaultText:initiatedByFrame:completionHandler:)]) {
        [self.delegate m2d_webView:webView runJavaScriptTextInputPanelWithPrompt:prompt defaultText:defaultText initiatedByFrame:frame completionHandler:completionHandler];
    }
    else {
        completionHandler(nil);
    }
}

- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo API_AVAILABLE(ios(10.0))
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:shouldPreviewElement:)]) {
        return [self.delegate m2d_webView:webView shouldPreviewElement:elementInfo];
    }
    
    return NO;
}

- (UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id<WKPreviewActionItem>> *)previewActions API_AVAILABLE(ios(10.0))
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:previewingViewControllerForElement:defaultActions:)]) {
        return [self.delegate m2d_webView:webView previewingViewControllerForElement:elementInfo defaultActions:previewActions];
    }
    
    return nil;
}

- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController API_AVAILABLE(ios(10.0))
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:commitPreviewingViewController:)]) {
        [self.delegate m2d_webView:webView commitPreviewingViewController:previewingViewController];
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:decidePolicyForNavigationAction:decisionHandler:)]) {
        [self.delegate m2d_webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    }
    else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:decidePolicyForNavigationResponse:decisionHandler:)]) {
        [self.delegate m2d_webView:webView decidePolicyForNavigationResponse:navigationResponse decisionHandler:decisionHandler];
    }
    else {
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    goBackButton_.enabled = [webView_ canGoBack];
    goForwardButton_.enabled = [webView_ canGoForward];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateToolbarItemsWithType:UIBarButtonSystemItemStop];
    
    if ([self.delegate respondsToSelector:@selector(m2d_webView:didStartProvisionalNavigation:)]) {
        [self.delegate m2d_webView:webView didStartProvisionalNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:didReceiveServerRedirectForProvisionalNavigation:)]) {
        [self.delegate m2d_webView:webView didReceiveServerRedirectForProvisionalNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:didFailProvisionalNavigation:withError:)]) {
        [self.delegate m2d_webView:webView didFailProvisionalNavigation:navigation withError:error];
    }
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:didCommitNavigation:)]) {
        [self.delegate m2d_webView:webView didCommitNavigation:navigation];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateToolbarItemsWithType:UIBarButtonSystemItemRefresh];
    
    if ([self.delegate respondsToSelector:@selector(m2d_webView:didFailNavigation:withError:)]) {
        [self.delegate m2d_webView:webView didFailNavigation:navigation withError:error];
    }
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    if ([self.delegate respondsToSelector:@selector(m2d_webView:didReceiveAuthenticationChallenge:completionHandler:)]) {
        [self.delegate m2d_webView:webView didReceiveAuthenticationChallenge:challenge completionHandler:completionHandler];
    }
    else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0))
{
    if ([self.delegate respondsToSelector:@selector(m2d_webViewWebContentProcessDidTerminate:)]) {
        [self.delegate m2d_webViewWebContentProcessDidTerminate:webView];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.title = webView.title;
    goBackButton_.enabled = [webView_ canGoBack];
    goForwardButton_.enabled = [webView_ canGoForward];
    url_ = [webView.URL copy];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateToolbarItemsWithType:UIBarButtonSystemItemRefresh];
    
    if ([self.delegate respondsToSelector:@selector(m2d_webView:didFinishNavigation:)]) {
        [self.delegate m2d_webView:webView didFinishNavigation:navigation];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType API_DEPRECATED("No longer supported.", ios(2.0, 12.0))
{
    self.title = [webView stringByEvaluatingJavaScriptFromString:kM2DWebViewControllerGetTitleScript];
    
    if ([self.delegate respondsToSelector:@selector(m2d_webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [self.delegate m2d_webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0))
{
    goBackButton_.enabled = [webView_ canGoBack];
    goForwardButton_.enabled = [webView_ canGoForward];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateToolbarItemsWithType:UIBarButtonSystemItemStop];
    
    if ([self.delegate respondsToSelector:@selector(m2d_webViewDidStartLoad:)]) {
        [self.delegate m2d_webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView API_DEPRECATED("No longer supported.", ios(2.0, 12.0))
{
    self.title = [webView stringByEvaluatingJavaScriptFromString:kM2DWebViewControllerGetTitleScript];
    goBackButton_.enabled = [webView_ canGoBack];
    goForwardButton_.enabled = [webView_ canGoForward];
    url_ = [webView.request.URL copy];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateToolbarItemsWithType:UIBarButtonSystemItemRefresh];
    
    if ([self.delegate respondsToSelector:@selector(m2d_webViewDidFinishLoad:)]) {
        [self.delegate m2d_webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error API_DEPRECATED("No longer supported.", ios(2.0, 12.0))
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateToolbarItemsWithType:UIBarButtonSystemItemRefresh];
    if ([self.delegate respondsToSelector:@selector(m2d_webView:didFailLoadWithError:)]) {
        [self.delegate m2d_webView:webView didFailLoadWithError:error];
    }
}

#pragma mark -

- (NSString *)realTitle
{
    if ([webView_ isKindOfClass:[UIWebView class]]) {
        return [webView_ stringByEvaluatingJavaScriptFromString:kM2DWebViewControllerGetTitleScript];
    }
    else {
        return [(WKWebView *)webView_ title];
    }
}

- (void)goForward:(id)sender
{
    WKWebView *webView = webView_;
    [webView goForward];
}

- (void)goBack:(id)sender
{
    WKWebView *webView = webView_;
    [webView goBack];
}

- (void)refresh:(id)sender
{
    WKWebView *webView = webView_;
    [webView reload];
}

- (void)stop:(id)sender
{
    WKWebView *webView = webView_;
    [webView stopLoading];
}

- (void)doAction:(id)sender
{
    if (self.actionButtonPressedHandler) {
        NSString *title = [self realTitle];
        self.actionButtonPressedHandler(title, url_);
    }
}

- (void)loadURL:(NSURL *)url
{
    WKWebView *webView = webView_;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (NSString *)resourceFilePath:(NSString *)filename
{
    return [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] pathForResource:@"M2DWebViewController" ofType:@"bundle"], filename];
}

- (void)updateToolbarItemsWithType:(UIBarButtonSystemItem)type
{
    if (type == UIBarButtonSystemItemRefresh) {
        NSMutableArray *items = [[self.navigationController.toolbar items] mutableCopy];
        UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
        [items replaceObjectAtIndex:5 withObject:refreshButton];
        [self.navigationController.toolbar setItems:items];
    }
    else if (type == UIBarButtonSystemItemStop) {
        NSMutableArray *items = [[self.navigationController.toolbar items] mutableCopy];
        UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(stop:)];
        [items replaceObjectAtIndex:5 withObject:refreshButton];
        [self.navigationController.toolbar setItems:items];
    }
}

@end
