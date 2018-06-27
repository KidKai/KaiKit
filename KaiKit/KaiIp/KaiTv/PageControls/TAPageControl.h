//
//  TAPageControl.h
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-21.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TAPageControl : UIControl

/** Make sure to inherit the TAIndicatorView class. */
@property (nonatomic, assign) Class indicatorClass;

@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, assign) CGFloat indicatorMargin;
@property (nonatomic, assign) CGFloat indicatorDiameter;

@property (nonatomic, strong, nullable) UIImage *pageIndicatorImage;
@property (nonatomic, strong, nullable) UIImage *currentPageIndicatorImage;

@property (nonatomic, assign) BOOL hidesForSinglePage; // Default to YES

/** Let the control know if should grow bigger by keeping center. */
@property (nonatomic, assign) BOOL shouldResizeFromCenter;

/** Returns minimum size required. */
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

@end

NS_ASSUME_NONNULL_END
