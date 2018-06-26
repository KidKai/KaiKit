//
//  TAIndicatorView.m
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-22.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import "TAIndicatorView.h"

@interface TAIndicatorView ()
- (void)initialize;
@end

@implementation TAIndicatorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.backgroundColor    = [UIColor clearColor];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2.f;
    self.layer.borderWidth  = 2.f;
    self.layer.borderColor  = [UIColor whiteColor].CGColor;
}

- (void)changeActivityState:(BOOL)active
{
    id reason = [NSString stringWithFormat:@"You must override %@ in %@", NSStringFromSelector(_cmd), self.class];
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
}

@end


@implementation TAAnimatedIView

- (void)initialize
{
    [super initialize];
    self.tintColor = [UIColor whiteColor];
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    self.layer.borderColor = tintColor.CGColor;
}

- (void)changeActivityState:(BOOL)active
{
    if (active) {
        [self animateToActiveState];
    } else {
        [self animateToInactiveState];
    }
}

- (void)animateToActiveState
{
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5f initialSpringVelocity:-20.f options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = self.tintColor;
        self.transform = CGAffineTransformMakeScale(1.4f, 1.4f);
    } completion:nil];
}

- (void)animateToInactiveState
{
    [UIView animateWithDuration:1.f delay:0.f usingSpringWithDamping:0.5f initialSpringVelocity:0.f options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.transform = CGAffineTransformIdentity;
    } completion:nil];
}

@end


@implementation TAColoringIView

- (void)changeActivityState:(BOOL)active
{
    if (active) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
