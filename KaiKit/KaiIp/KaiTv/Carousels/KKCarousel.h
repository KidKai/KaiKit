//
//  KKCarousel.h
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

#import "iCarousel.h"
#import "LCAnimatedPageControl.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, KKPageControlAlignment) {
    KKPageControlAlignmentCentre,
    KKPageControlAlignmentRight,
};

@interface KKCarousel : iCarousel

@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
@property (nonatomic, assign) CGFloat indicatorBottomOffset;
@property (nonatomic, assign) CGFloat indicatorRightOffset;

/** PageStyle .danceColor, .stuffColor, .scaleColor */
@property (nonatomic, assign) CGFloat indicatorMultiple;
@property (nonatomic, assign) CGFloat indicatorMargin;
@property (nonatomic, assign) CGFloat indicatorDiameter;

@property (nonatomic, assign) KKPageControlAlignment pageAlignment;
@property (nonatomic, assign) PageStyle pageStyle;

/** CGFLOAT_MAX means infinite scrolling. Default to 0. */
@property (nonatomic, assign) CGFloat autoscrollTimeInterval;

/** Unlimited scroll frequency interval. Default to 3. */
@property (nonatomic, assign) CGFloat autoscrollRateInterval;

/** PageStyle .squirmCP `CPSquirmPageControl */
@property (nonatomic, assign) BOOL isRadiusZero;

/** PageStyle .animatedTA `TAPageControl */
@property (nonatomic, strong, nullable) UIImage *pageIndicatorImage;
@property (nonatomic, strong, nullable) UIImage *currentPageIndicatorImage;

@end

NS_ASSUME_NONNULL_END
