//
//  KKScanController.h
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
#import "KaiTvGlobals.h"
#import <AVKit/AVKit.h>
#import "KKScanView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKScanController : KKViewController
<AVCaptureMetadataOutputObjectsDelegate>

@property (nullable, nonatomic, readonly) AVCaptureVideoPreviewLayer *prelayer;

@property (nonatomic, strong, readonly) KKScanView *scanView;

@property (nullable, nonatomic, readonly) AVCaptureDevice *device;
@property (nullable, nonatomic, readonly) AVCaptureSession *session;

@property (nullable, nonatomic, copy) void (^didOutputMetadataObjects)(id data);

- (void)startRunning;
- (void)stopRunning;

@end

NS_ASSUME_NONNULL_END
