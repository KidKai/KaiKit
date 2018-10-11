//
//  KKScanController.m
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

#import "KKScanController.h"
#import "UIAlertController+Blocks.h"
#import "UIViewController+KKNavigationBar.h"
#import "UIViewController+AVCaptureVideoPreviewLayer.h"

@interface KKScanController ()

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *prelayer;
@property (nonatomic, strong) KKScanView *scanView;

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation KKScanController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"扫码", @"");
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    Class kind = [AVCaptureVideoPreviewLayer classForCoder];
    if (![self.scanView.layer.sublayers.firstObject isKindOfClass:kind]) {
        if (self.prelayer) {
            [self.scanView.layer insertSublayer:self.prelayer atIndex:0];
        }
    }
    [self.session startRunning];
    [self presentCameraAlertController];
}

- (AVCaptureVideoPreviewLayer *)prelayer
{
    if (!self.session) return nil;
    
    if (!_prelayer) {
        _prelayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        _prelayer.videoGravity = AVLayerVideoGravityResizeAspect;
        _prelayer.frame = self.scanView.bounds;
    }
    return _prelayer;
}

- (KKScanView *)scanView
{
    if (!_scanView) {
        _scanView = [[KKScanView alloc] initWithFrame:screenBounds()];
        [self.view addSubview:_scanView];
        _scanView.clipsToBounds = YES;
    }
    return _scanView;
}

- (AVCaptureDevice *)device
{
    if (!_device) {
        if (@available(iOS 10.0, *)) {
            id deviceTypes = @[AVCaptureDeviceTypeBuiltInWideAngleCamera];
            _device = [AVCaptureDeviceDiscoverySession
                       discoverySessionWithDeviceTypes:deviceTypes
                       mediaType:AVMediaTypeVideo
                       position:AVCaptureDevicePositionBack]
            .devices.firstObject;
        } else {
            _device = [AVCaptureDevice
                       defaultDeviceWithMediaType:AVMediaTypeVideo];
        }
    }
    return _device;
}

- (AVCaptureSession *)session
{
    if (!self.device) return nil;
    
    if (!_session) {
        id input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:NULL];
        if (!input) return nil;
        
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [output setRectOfInterest:self.rectOfInterest];
        
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPresetHigh;
        if ([_session canAddInput:input]) [_session addInput:input];
        if ([_session canAddOutput:output]) [_session addOutput:output];
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    }
    return _session;
}

- (CGRect)rectOfInterest
{
    CGRect rect = self.view.bounds;
    CGRect scan = [self.scanView scanned:rect];
    CGFloat per1 = CGRectGetHeight(rect) / CGRectGetWidth(rect);
    CGFloat per2 = 1920.f / 1080.f;
    CGFloat minX, minY, width, height;
    if (per1 < per2) {
        CGFloat upright = CGRectGetWidth(rect) * per2;
        CGFloat padding = upright / 2.f - CGRectGetHeight(rect) / 2.f;
        minX = (CGRectGetMinY(scan) + padding) / upright;
        minY = CGRectGetMinX(scan) / CGRectGetWidth(rect);
        width = CGRectGetHeight(scan) / upright;
        height = CGRectGetWidth(scan) / CGRectGetWidth(rect);
    } else {
        CGFloat aclinic = CGRectGetHeight(rect) / per2;
        CGFloat padding = aclinic / 2.f - CGRectGetWidth(rect) / 2.f;
        minX = CGRectGetMinY(scan) / CGRectGetHeight(rect);
        minY = (CGRectGetMinX(scan) + padding) / aclinic;
        width = CGRectGetHeight(scan) / CGRectGetHeight(rect);
        height = CGRectGetWidth(scan) / aclinic;
    }
    return CGRectMake(minX, minY, width, height);
}

- (void)startRunning
{
    [self.scanView roll];
    [self.session startRunning];
}

- (void)stopRunning
{
    [self.scanView stop];
    [self.session stopRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output
didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count < 1) return;
    
    [self stopRunning];
    if (self.didOutputMetadataObjects) {
        self.didOutputMetadataObjects(metadataObjects);
        return;
    }
    
    AVMetadataMachineReadableCodeObject *metadataObject =
    (AVMetadataMachineReadableCodeObject *)metadataObjects.firstObject;
    NSString *message = metadataObject.stringValue;
    NSString *cancelButtonTitle = NSLocalizedString(@"知道了", @"");
    NSArray *otherButtonTitles = @[NSLocalizedString(@"扫码", @"")];
    
    [UIAlertController
     showAlertInViewController:self
     withTitle:nil
     message:NSLocalizedString(message, @"")
     cancelButtonTitle:cancelButtonTitle
     destructiveButtonTitle:nil
     otherButtonTitles:otherButtonTitles
     tapBlock:^(UIAlertController * _Nonnull controller,
                UIAlertAction * _Nonnull action,
                NSInteger buttonIndex) {
         if (buttonIndex == controller.cancelButtonIndex) {
             [self popOrDismissViewControllerAnimated:YES];
         }
         if (buttonIndex == controller.firstOtherButtonIndex) {
             [self startRunning];
         }
     }];
}

@end
