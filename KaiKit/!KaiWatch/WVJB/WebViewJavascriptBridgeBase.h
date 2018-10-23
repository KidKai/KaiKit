//
//  WebViewJavascriptBridgeBase.h
//
//  Created by @LokiMeyburg on 10/15/14.
//  Copyright (c) 2014 @LokiMeyburg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kOldProtocolScheme @"wvjbscheme"
#define kNewProtocolScheme @"https"
#define kWVJSBQueueMessage @"__wvjb_queue_message__"
#define kJavaSBridgeLoaded @"__bridge_loaded__"

typedef void (^WVJBResponseCallback)(id responseData);
typedef void (^WVJBHandler)(id data, WVJBResponseCallback responseCallback);
typedef NSDictionary WVJBMessage;

@protocol WebViewJavascriptBridgeBaseDelegate <NSObject>
- (NSString *)_evaluateJavascript:(NSString *)javascriptCommand;
@end

@interface WebViewJavascriptBridgeBase : NSObject

@property (weak, nonatomic) id<WebViewJavascriptBridgeBaseDelegate> delegate;
@property (strong, nonatomic, nullable) NSMutableArray *startupMessageQueue;
@property (strong, nonatomic, nullable) NSMutableDictionary *responseCallbacks;
@property (strong, nonatomic, nullable) NSMutableDictionary *messageHandlers;
@property (strong, nonatomic) WVJBHandler messageHandler;

+ (void)enableLogging;
+ (void)setLogMaxLength:(int)length;
- (void)reset;
- (void)sendData:(nullable id)data responseCallback:(nullable WVJBResponseCallback)responseCallback handlerName:(nullable NSString *)handlerName;
- (void)flushMessageQueue:(NSString *)messageQueueString;
- (void)injectJavascriptFile;
- (BOOL)isWebViewJavascriptBridgeURL:(NSURL *)url;
- (BOOL)isQueueMessageURL:(NSURL *)url;
- (BOOL)isBridgeLoadedURL:(NSURL *)url;
- (void)logUnknownMessage:(NSURL *)url;
- (NSString *)webViewJavascriptFetchQueue;
- (NSString *)webViewJavascriptCheckCommand;
- (void)disableJavscriptAlertBoxSafetyTimeout;

@end

NS_ASSUME_NONNULL_END
