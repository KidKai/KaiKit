//
//  LCIndicatorView.m
//  LCAnimatedPageControl
//
//  Created by beike on 8/14/15.
//  Copyright (c) 2015 beike. All rights reserved.
//

#import "LCIndicatorView.h"

@implementation LCIndicatorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backView = [[UIView alloc] init];
        _frontView = [[UIView alloc] init];
        _backView.translatesAutoresizingMaskIntoConstraints = NO;
        _frontView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_backView];
        [self addSubview:_frontView];
        
        NSDictionary *dict = NSDictionaryOfVariableBindings(_frontView, _backView);
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-0-[_frontView]-0-|"
                              options:0 metrics:nil views:dict]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-0-[_frontView]-0-|"
                              options:0 metrics:nil views:dict]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-0-[_backView]-0-|"
                              options:0 metrics:nil views:dict]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-0-[_backView]-0-|"
                              options:0 metrics:nil views:dict]];
    }
    return self;
}

@end
