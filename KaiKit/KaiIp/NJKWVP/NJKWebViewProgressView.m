//
//  NJKWebViewProgressView.m
//
//  Created by Satoshi Aasanoon 11/16/13.
//  Copyright (c) 2013 Satoshi Asano. All rights reserved.
//

#import "NJKWebViewProgressView.h"

@implementation NJKWebViewProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureViews];
}

-(void)configureViews
{
    self.userInteractionEnabled = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _progressBarView = [[UIView alloc] initWithFrame:self.bounds];
    _progressBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    UIColor *tintColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.f]; // iOS7 Safari bar color
    if ([UIApplication.sharedApplication.delegate.window respondsToSelector:@selector(setTintColor:)] && UIApplication.sharedApplication.delegate.window.tintColor) {
        tintColor = UIApplication.sharedApplication.delegate.window.tintColor;
    }
    _progressBarView.backgroundColor = tintColor;
    [self addSubview:_progressBarView];
    
    _barAnimationDuration = 0.27f;
    _fadeAnimationDuration = 0.27f;
    _fadeOutDelay = 0.1f;
}

-(void)setProgress:(float)progress
{
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    BOOL isGrowing = progress > 0.f;
    [UIView animateWithDuration:(isGrowing && animated) ? _barAnimationDuration : 0.f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self->_progressBarView.frame;
        frame.size.width = progress * self.bounds.size.width;
        self->_progressBarView.frame = frame;
    } completion:nil];
    
    if (progress >= 1.f) {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration : 0.f delay:_fadeOutDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self->_progressBarView.alpha = 0.f;
        } completion:^(BOOL completed){
            CGRect frame = self->_progressBarView.frame;
            frame.size.width = 0.f;
            self->_progressBarView.frame = frame;
        }];
    }
    else {
        [UIView animateWithDuration:animated ? _fadeAnimationDuration : 0.f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self->_progressBarView.alpha = 1.f;
        } completion:nil];
    }
}

@end
