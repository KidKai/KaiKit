//
//  This file contains the source for the Javascript side of the
//  WebViewJavascriptBridge. It is plain text but converted to an NSString
//  via some preprocessor tricks.
//
//  Previous implementations of WebViewJavascriptBridge loaded the Javascript
//  source from a resource. This worked fine for app developers, but library
//  developers who included the bridge into their library awkwardly had to ask
//  consumers of their library to include the resource, violating their
//  encapsulation. By including the Javascript as a string resource, the
//  encapsulation of the library is maintained.
//

#import <Foundation/Foundation.h>

NSString *WebViewJavascriptBridge_js(void);
