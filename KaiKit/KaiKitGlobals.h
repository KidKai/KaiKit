//
//  KaiKitGlobals.h
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

#if TARGET_OS_OSX
#import <AppKit/AppKit.h>
#else
#import <UIKit/UIKit.h>
#endif

CF_IMPLICIT_BRIDGING_ENABLED

NS_ASSUME_NONNULL_BEGIN

CG_EXTERN CGColorRef CGColorGetBlack(void);     // 0.0 white
CG_EXTERN CGColorRef CGColorGetDarkGray(void);  // 0.333 white
CG_EXTERN CGColorRef CGColorGetLightGray(void); // 0.667 white
CG_EXTERN CGColorRef CGColorGetWhite(void);     // 1.0 white
CG_EXTERN CGColorRef CGColorGetGray(void);      // 0.5 white
CG_EXTERN CGColorRef CGColorGetRed(void);       // 1.0, 0.0, 0.0 RGB
CG_EXTERN CGColorRef CGColorGetGreen(void);     // 0.0, 1.0, 0.0 RGB
CG_EXTERN CGColorRef CGColorGetBlue(void);      // 0.0, 0.0, 1.0 RGB
CG_EXTERN CGColorRef CGColorGetCyan(void);      // 0.0, 1.0, 1.0 RGB
CG_EXTERN CGColorRef CGColorGetYellow(void);    // 1.0, 1.0, 0.0 RGB
CG_EXTERN CGColorRef CGColorGetMagenta(void);   // 1.0, 0.0, 1.0 RGB
CG_EXTERN CGColorRef CGColorGetOrange(void);    // 1.0, 0.5, 0.0 RGB
CG_EXTERN CGColorRef CGColorGetPurple(void);    // 0.5, 0.0, 0.5 RGB
CG_EXTERN CGColorRef CGColorGetBrown(void);     // 0.6, 0.4, 0.2 RGB
CG_EXTERN CGColorRef CGColorGetClear(void);     // 0.0 white, 0.0 alpha

NS_ASSUME_NONNULL_END

CF_IMPLICIT_BRIDGING_DISABLED
