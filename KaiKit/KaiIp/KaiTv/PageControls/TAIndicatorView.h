//
//  TAIndicatorView.h
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-22.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAIndicatorView : UIView

- (void)changeActivityState:(BOOL)active;

@end


@interface TAAnimatedIView : TAIndicatorView

@end


@interface TAColoringIView : TAIndicatorView

@end

NS_ASSUME_NONNULL_END
