//
//  CPSquirmPageControl.h
//  zent
//
//  Created by Morplcp on 2018/4/27.
//  Copyright (c) 2018 morplcp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPSquirmPageControl : UIControl

@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, assign) CGFloat indicatorMargin;
@property (nonatomic, assign) CGFloat indicatorDiameter;

@property (nonatomic, assign) BOOL isRadiusZero;

/** Returns minimum size required. */
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;

@end

NS_ASSUME_NONNULL_END
