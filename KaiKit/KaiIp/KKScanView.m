//
//  KKScanView.m
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

#import "KKScanView.h"
#import "KaiIpGlobals.h"
#import "KaiKitGlobals.h"
#import "NSObject+KKDevice.h"

@interface KKScanView ()

@property (nonatomic, strong) CAShapeLayer *backLayer;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) CAShapeLayer *overLayer;

@property (nonatomic, strong) CAGradientLayer  *moveLayer;
@property (nonatomic, strong) CABasicAnimation *animation;

@end

@implementation KKScanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(roll)
         name:UIApplicationDidBecomeActiveNotification
         object:nil];
        self.tintColor = UIColor.whiteColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    _scanrect = [self scanned:rect];
    
    CGFloat rest = CGRectGetHeight(rect) - CGRectGetHeight(_scanrect);
    CGFloat minY = CGRectGetMinY(_scanrect);
    CGFloat backWidth = (rest - minY) > 0.f ? (rest - minY) : minY;
    CGFloat backInset = backWidth / 2.f + 0.5f;
    CGRect backFrame = CGRectInset(_scanrect, -backInset, -backInset);
    self.backLayer.lineWidth = backWidth;
    self.backLayer.path = [UIBezierPath bezierPathWithRect:backFrame].CGPath;
    
    CGRect lineFrame = CGRectInset(_scanrect, -1.f, -1.f);
    self.lineLayer.path = [UIBezierPath bezierPathWithRect:lineFrame].CGPath;
    
    NSNumber *number = @(CGRectGetWidth(_scanrect) - 30.f);
    self.overLayer.lineDashPattern = @[@30, number];
    
    self.moveLayer.frame = CGRectMake(CGRectGetMinX(_scanrect), CGRectGetMinY(_scanrect), CGRectGetWidth(_scanrect), 3.f);
    
    [self roll];
}

- (CAShapeLayer *)backLayer
{
    if (!_backLayer) {
        _backLayer = [[CAShapeLayer alloc] init];
        _backLayer.fillColor = CGColorGetClear();
        _backLayer.strokeColor = CGColorGetBlack();
        _backLayer.opacity = 0.5f;
        [self.layer addSublayer:_backLayer];
    }
    return _backLayer;
}

- (CAShapeLayer *)lineLayer
{
    if (!_lineLayer) {
        _lineLayer = [[CAShapeLayer alloc] init];
        _lineLayer.fillColor = CGColorGetClear();
        _lineLayer.strokeColor = self.tintColor.CGColor;
        _lineLayer.lineWidth = 0.5f;
        [self.layer addSublayer:_lineLayer];
    }
    return _lineLayer;
}

- (CAShapeLayer *)overLayer
{
    if (!_overLayer) {
        _overLayer = [[CAShapeLayer alloc] init];
        _overLayer.fillColor = CGColorGetClear();
        _overLayer.strokeColor = self.tintColor.CGColor;
        _overLayer.lineWidth = 3.f;
        _overLayer.lineDashPhase = 15.f;
        [self.layer addSublayer:_overLayer];
    }
    return _overLayer;
}

- (CAGradientLayer *)moveLayer
{
    if (!_moveLayer) {
        id clear = (id)CGColorGetClear();
        id white = (id)self.tintColor.CGColor;
        _moveLayer = [[CAGradientLayer alloc] init];
        _moveLayer.startPoint = CGPointZero;
        _moveLayer.endPoint = CGPointMake(1.f, 0.f);
        _moveLayer.colors = @[clear, white, clear];
        [self.layer addSublayer:_moveLayer];
    }
    return _moveLayer;
}

- (CABasicAnimation *)animation
{
    if (!_animation) {
        _animation = [[CABasicAnimation alloc] init];
        _animation.keyPath = @"position.y";
        _animation.fromValue = @(_moveLayer.position.y);
        _animation.toValue = @(CGRectGetMaxY(self.scanrect));
        _animation.speed = 0.1f;
        _animation.repeatCount = HUGE;
    }
    return _animation;
}

- (CGRect)scanned:(CGRect)rect
{
    KKIPhoneDisplaySize size = self.iPhoneDisplaySize;
    CGFloat inset = size >= KKIPhoneDisplaySize_4_7_inch ? 80.f : 64.f;
    CGRect rectangle = CGRectInset(rect, inset, inset);
    CGFloat height = CGRectGetHeight(rectangle);
    CGFloat width = CGRectGetWidth(rectangle);
    CGFloat minimum = MIN(height, width);
    if (width != minimum) {
        rectangle.origin.x += (width - minimum) / 2.f;
        rectangle.size.width = minimum;
    } else if (height != minimum) {
        rectangle.origin.y += (height - minimum) / 2.f;
        rectangle.size.height = minimum;
    }
    CGFloat dy = (-screenHeight() + screenWidth()) / 2.f + statusHeight();
    return CGRectOffset(rectangle, 0.f, dy);
}

- (void)roll
{
    if (![self.moveLayer.animationKeys containsObject:@"line"]) {
        [self.moveLayer addAnimation:self.animation forKey:@"line"];
    }
}

- (void)stop
{
    [self.moveLayer removeAnimationForKey:@"line"];
}

@end
