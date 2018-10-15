//
//  NJKWebViewProgressView.h
// iOS 7 Style WebView Progress Bar
//
//  Created by Satoshi Aasano on 11/16/13.
//  Copyright (c) 2013 Satoshi Asano. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NJKWebViewProgressView : UIView
@property (nonatomic) float progress;
@property (nonatomic, readonly) UIView *progressBarView;

@property (nonatomic) NSTimeInterval barAnimationDuration; // default 0.1f
@property (nonatomic) NSTimeInterval fadeAnimationDuration; // default 0.27f
@property (nonatomic) NSTimeInterval fadeOutDelay; // default 0.1f

- (void)setProgress:(float)progress animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
