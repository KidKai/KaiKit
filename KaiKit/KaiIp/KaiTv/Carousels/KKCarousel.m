//
//  KKCarousel.m
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

#import "KKCarousel.h"
#import "TAPageControl.h"
#import "CPSquirmPageControl.h"
#import "UIColor+KKAdditions.h"
#import "LCAnimatedPageControl.h"
#import "UIView+KKViewGeometry.h"

@interface iCarousel ()
- (void)didScroll;
@end


@interface KKCarousel ()
- (BOOL)isLCAnimatedPageControl;
@end


@implementation NSObject (KKCarousel)

#pragma mark - iCarouselDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"

- (void)carouselWillBeginDragging:(__unused iCarousel *)carousel
{
    if ([carousel isMemberOfClass:[KKCarousel class]]) {
        [carousel performSelector:@selector(invalidateTimerNil)];
    }
}

- (void)carouselDidEndDragging:(__unused iCarousel *)carousel
                willDecelerate:(__unused BOOL)decelerate
{
    if ([carousel isMemberOfClass:[KKCarousel class]]) {
        [carousel performSelector:@selector(scheduledAutoTimer)];
    }
}

#pragma clang diagnostic pop

- (CGFloat)carousel:(__unused iCarousel *)carousel
     valueForOption:(__unused iCarouselOption)option
        withDefault:(CGFloat)value
{
    if ([carousel isMemberOfClass:[KKCarousel class]]) {
        if (option == iCarouselOptionWrap) {
            KKCarousel *carl = (KKCarousel *)carousel;
            return !carl.isLCAnimatedPageControl;
        }
    }
    return value;
}

@end


@implementation KKCarousel
{
    NSTimer *_autoTimer;
    UIControl *_pageControl;
}

#pragma mark - Lifecycle

- (void)initialization
{
    super.pagingEnabled = YES;
    _pageIndicatorTintColor = [UIColor colorWithHexUInt:0x9FFFFFFF];
    _currentPageIndicatorTintColor = [UIColor whiteColor];
    _indicatorMultiple = 1.4f;
    _indicatorMargin = 10.f;
    _indicatorDiameter = 8.f;
    _autoscrollTimeInterval = 0.f;
    _autoscrollRateInterval = 3.f;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)layoutSubviews
{
    CGSize tack = CGSizeMake(0.f, 0.f);
    CGSize size = CGSizeMake(36.f, 36.f);
    switch (_pageStyle) {
        case PageStyleNone: {
            [self removePageControl];
            [super layoutSubviews];
        } return;
            
        case PageStyleSystem: {
            UIPageControl *pageControl = (UIPageControl *)_pageControl;
            tack = [pageControl sizeForNumberOfPages:self.numberOfItems];
        } break;
            
        case PageStyleSquirmCP: {
            CPSquirmPageControl *pageControl = (CPSquirmPageControl *)_pageControl;
            tack = [pageControl sizeForNumberOfPages:self.numberOfItems];
        } break;
            
        case PageStyleAnimatedTA: {
            TAPageControl *pageControl = (TAPageControl *)_pageControl;
            tack = [pageControl sizeForNumberOfPages:self.numberOfItems];
        } break;
            
        case PageStyleSquirmLC:
        case PageStyleDanceColor:
        case PageStyleStuffColor:
        case PageStyleScaleColor: {
            LCAnimatedPageControl *pageControl = (LCAnimatedPageControl *)_pageControl;
            tack = [pageControl sizeForNumberOfPages:self.numberOfItems];
        } break;
    }
    _pageControl.width = size.width + tack.width;
    _pageControl.height = MAX(size.height, tack.height);
    
    if (_pageAlignment == KKPageControlAlignmentCentre) {
        _pageControl.minX = (self.width - _pageControl.width) / 2.f;
    } else {
        _pageControl.minX = (self.width - _pageControl.width) - _indicatorRightOffset;
    }
    _pageControl.minY = self.height - _pageControl.height - _indicatorBottomOffset;
    
    if (_pageStyle == PageStyleAnimatedTA) [_pageControl sizeToFit];
    
    [super layoutSubviews];
    [self bringSubviewToFront:_pageControl];
}

- (void)dealloc
{
    [self invalidateTimerNil];
}

#pragma mark - Loadings

- (void)reloadData
{
    [super reloadData];
    
    if (self.numberOfItems == 0) {
        [self removePageControl];
        return;
    }
    
    switch (_pageStyle) {
        case PageStyleNone: {
            [self removePageControl];
        } break;
            
        case PageStyleSystem: {
            [self removePageControl];
            [self loadUIPageControl];
        } break;
            
        case PageStyleSquirmCP: {
            [self removePageControl];
            [self loadCPPageControl];
        } break;
            
        case PageStyleAnimatedTA: {
            [self removePageControl];
            [self loadTAPageControl];
        } break;
            
        case PageStyleSquirmLC:
        case PageStyleDanceColor:
        case PageStyleStuffColor:
        case PageStyleScaleColor: {
            [self removePageControl];
            [self loadLCPageControl];
            [self invalidateTimerNil];
        } break;
    }
}

- (void)removePageControl
{
    if (_pageControl) {
        [_pageControl removeFromSuperview];
    }
}

- (void)loadUIPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.numberOfItems;
    pageControl.hidesForSinglePage = YES;
    pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
    pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
    
    _pageControl = pageControl;
    [self addSubview:_pageControl];
}

- (void)loadCPPageControl
{
    CPSquirmPageControl *pageControl = [[CPSquirmPageControl alloc] init];
    pageControl.numberOfPages = self.numberOfItems;
    pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
    pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
    pageControl.indicatorMargin = _indicatorMargin;
    pageControl.indicatorDiameter = _indicatorDiameter;
    pageControl.isRadiusZero = _isRadiusZero;
    
    _pageControl = pageControl;
    [self addSubview:_pageControl];
}

- (void)loadTAPageControl
{
    TAPageControl *pageControl = [[TAPageControl alloc] init];
    pageControl.numberOfPages = self.numberOfItems;
    pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
    pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
    pageControl.indicatorMargin = _indicatorMargin;
    pageControl.indicatorDiameter = _indicatorDiameter;
    pageControl.pageIndicatorImage = _pageIndicatorImage;
    pageControl.currentPageIndicatorImage = _currentPageIndicatorImage;
    
    _pageControl = pageControl;
    [self addSubview:_pageControl];
}

- (void)loadLCPageControl
{
    LCAnimatedPageControl *pageControl = [[LCAnimatedPageControl alloc] init];
    pageControl.sourceScrollView = [[UIScrollView alloc] init]; // useless
    pageControl.sourceScrollView.frame = self.frame;
    pageControl.sourceScrollView.contentOffset = CGPointZero;
    pageControl.numberOfPages = self.numberOfItems;
    pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
    pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
    pageControl.indicatorMultiple = _indicatorMultiple;
    pageControl.indicatorMargin = _indicatorMargin;
    pageControl.indicatorDiameter = _indicatorDiameter;
    pageControl.pageStyle = _pageStyle;
    
    [pageControl prepareShow];
    _pageControl = pageControl;
    [self addSubview:_pageControl];
    
    [_pageControl addTarget:self action:@selector(currentPageValueChanged:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - Setters

- (void)setAutoscroll:(CGFloat)autoscroll
{ }

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    if (_pageStyle != PageStyleNone) {
        [_pageControl setValue:pageIndicatorTintColor forKey:@"pageIndicatorTintColor"];
        if (_pageControl) [self reloadData];
    }
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    if (_pageStyle != PageStyleNone) {
        [_pageControl setValue:currentPageIndicatorTintColor forKey:@"currentPageIndicatorTintColor"];
        if (_pageControl) [self reloadData];
    }
}

- (void)setIndicatorBottomOffset:(CGFloat)indicatorBottomOffset
{
    _indicatorBottomOffset = indicatorBottomOffset;
    if ([self.subviews.lastObject isEqual:_pageControl]) {
        [self layoutSubviews];
    }
}

- (void)setIndicatorRightOffset:(CGFloat)indicatorRightOffset
{
    _indicatorRightOffset = indicatorRightOffset;
    if ([self.subviews.lastObject isEqual:_pageControl]) {
        [self layoutSubviews];
    }
}

- (void)setIndicatorMultiple:(CGFloat)indicatorMultiple
{
    _indicatorMultiple = indicatorMultiple;
    if (_pageControl) [self reloadData];
}

- (void)setIndicatorMargin:(CGFloat)indicatorMargin
{
    _indicatorMargin = indicatorMargin;
    if (_pageControl) [self reloadData];
}

- (void)setIndicatorDiameter:(CGFloat)indicatorDiameter
{
    _indicatorDiameter = indicatorDiameter;
    if (_pageControl) [self reloadData];
}

- (void)setPageAlignment:(KKPageControlAlignment)pageAlignment
{
    _pageAlignment = pageAlignment;
    if ([self.subviews.lastObject isEqual:_pageControl]) {
        [self layoutSubviews];
    }
}

- (void)setPageStyle:(PageStyle)pageStyle
{
    _pageStyle = pageStyle;
    if (_pageControl) [self reloadData];
}

- (void)setAutoscrollTimeInterval:(CGFloat)autoscrollTimeInterval
{
    CGFloat oldValue = _autoscrollTimeInterval;
    _autoscrollTimeInterval = autoscrollTimeInterval;
    if (oldValue != autoscrollTimeInterval) {
        [self invalidateTimerNil];
        [self scheduledAutoTimer];
    }
}

- (void)setAutoscrollRateInterval:(CGFloat)autoscrollRateInterval
{
    CGFloat oldValue = _autoscrollRateInterval;
    _autoscrollRateInterval = autoscrollRateInterval;
    if (oldValue != autoscrollRateInterval) {
        [self invalidateTimerNil];
        [self scheduledAutoTimer];
    }
}

- (void)setIsRadiusZero:(BOOL)isRadiusZero
{
    _isRadiusZero = isRadiusZero;
    if (_pageControl) [self reloadData];
}

- (void)setPageIndicatorImage:(UIImage *)pageIndicatorImage
{
    _pageIndicatorImage = pageIndicatorImage;
    if (_pageControl) [self reloadData];
}

- (void)setCurrentPageIndicatorImage:(UIImage *)currentPageIndicatorImage
{
    _currentPageIndicatorImage = currentPageIndicatorImage;
    if (_pageControl) [self reloadData];
}

#pragma mark - Getters

// iCarouselOptionWrap Off.
- (BOOL)isLCAnimatedPageControl
{
    return [_pageControl isMemberOfClass:[LCAnimatedPageControl class]];
}

- (void)currentPageValueChanged:(LCAnimatedPageControl *)sender
{
    self.currentItemIndex = sender.currentPage;
}

#pragma mark - Animation

- (void)scheduledAutoTimer
{
    if (_autoscrollTimeInterval <= 0.f) {
        _autoscrollTimeInterval = 0.f;
        [self invalidateTimerNil];
        return;
    }
    
    if (!_autoTimer && !self.isLCAnimatedPageControl) {
        _autoTimer = [NSTimer scheduledTimerWithTimeInterval:ABS(_autoscrollRateInterval) target:self selector:@selector(autoscrollStepByStep) userInfo:nil repeats:YES];
    }
}

- (void)invalidateTimerNil
{
    [_autoTimer invalidate];
    _autoTimer = nil;
}

- (void)autoscrollStepByStep
{
    if (_autoscrollTimeInterval <= 0.f) {
        _autoscrollTimeInterval = 0.f;
        [self invalidateTimerNil];
        return;
    }
    
    NSInteger add = _autoscrollRateInterval >= 0 ? 1 : -1;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToItemAtIndex:self.currentItemIndex + add animated:YES];
    });
    _autoscrollTimeInterval -= ABS(_autoscrollRateInterval);
}

- (void)didScroll
{
    [super didScroll];
    
    switch (_pageStyle) {
        case PageStyleNone: {
            [self removePageControl];
        } break;
            
        case PageStyleSystem: {
            if (((UIPageControl *)_pageControl).currentPage != self.currentItemIndex) {
                ((UIPageControl *)_pageControl).currentPage = self.currentItemIndex;
            }
        } break;
            
        case PageStyleSquirmCP: {
            if (((CPSquirmPageControl *)_pageControl).currentPage != self.currentItemIndex) {
                ((CPSquirmPageControl *)_pageControl).currentPage = self.currentItemIndex;
            }
        } break;
            
        case PageStyleAnimatedTA: {
            if (((TAPageControl *)_pageControl).currentPage != self.currentItemIndex) {
                ((TAPageControl *)_pageControl).currentPage = self.currentItemIndex;
            }
        } break;
            
        case PageStyleSquirmLC:
        case PageStyleDanceColor:
        case PageStyleStuffColor:
        case PageStyleScaleColor: {
            CGPoint point = CGPointMake(self.scrollOffset * self.width, CGPointZero.y);
            ((LCAnimatedPageControl *)_pageControl).sourceScrollView.contentOffset = point;
        } break;
    }
}

@end
