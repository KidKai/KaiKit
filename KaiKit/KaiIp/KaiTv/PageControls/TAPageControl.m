//
//  TAPageControl.m
//  TAPageControl
//
//  Created by Tanguy Aladenise on 2015-01-21.
//  Copyright (c) 2015 Tanguy Aladenise. All rights reserved.
//

#import "TAPageControl.h"
#import "TAIndicatorView.h"
#import "UIView+KKViewGeometry.h"

@interface TAPageControl ()

@property (nonatomic, strong) NSMutableArray *indicatorViews;
@property (nonatomic, assign) CGSize indicatorSize;

@end

@implementation TAPageControl

#pragma mark - Lifecycle

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
    _indicatorViews = [NSMutableArray array];
    _indicatorClass = [TAAnimatedIView class];
    _numberOfPages = 0;
    _currentPage = 0;
    _pageIndicatorTintColor = [UIColor orangeColor];
    _currentPageIndicatorTintColor = [UIColor blackColor];
    _indicatorDiameter = 0.f;
    _indicatorMargin = 0.f;
    _hidesForSinglePage = YES;
    _shouldResizeFromCenter = YES;
}

#pragma mark - Layout

- (void)sizeToFit { [self updateFrame:YES]; }

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    return CGSizeMake((self.indicatorSize.width + _indicatorMargin) * pageCount - _indicatorMargin, self.indicatorSize.height);
}

- (void)updateIndicators
{
    if (_numberOfPages == 0) return;
    
    for (NSInteger i = 0; i < _numberOfPages; i++) {
        if (i < _indicatorViews.count) {
            [self updateIndicatorFrame:_indicatorViews[i] atIndex:i];
        } else {
            [self updateIndicatorFrame:[self generateIndicator] atIndex:i];
        }
    }
    
    [self hideForSinglePage];
}

- (void)updateFrame:(BOOL)overrideExistingFrame
{
    CGPoint center = self.center;
    CGSize minSize = [self sizeForNumberOfPages:_numberOfPages];
    
    // We apply minSize only if authorize to and necessary.
    if (overrideExistingFrame || self.width < minSize.width || self.height < minSize.height) {
        CGFloat width = MAX(self.width, minSize.width);
        CGFloat height = MAX(self.height, minSize.height);
        self.frame = CGRectMake(self.minX, self.minY, width, height);
        if (_shouldResizeFromCenter) self.center = center;
    }
    
    [self updateIndicators];
    [self changeActivity:YES atIndex:_currentPage];
}

- (void)updateIndicatorFrame:(UIView *)indicator atIndex:(NSInteger)index
{
    CGFloat w = self.width - [self sizeForNumberOfPages:_numberOfPages].width;
    CGFloat x = (self.indicatorSize.width + _indicatorMargin) * index + w / 2.f;
    CGFloat y = (self.height - self.indicatorSize.height) / 2.f;
    
    indicator.frame = CGRectMake(x, y, self.indicatorSize.width, self.indicatorSize.height);
}

#pragma mark - Utils

- (UIView *)generateIndicator
{
    UIView *indicator = nil;
    
    if (_indicatorClass) {
        indicator = [[_indicatorClass alloc] initWithFrame:CGRectZero];
        if (_currentPageIndicatorTintColor) {
            if ([indicator isMemberOfClass:[TAAnimatedIView class]]) {
                ((TAAnimatedIView *)indicator).tintColor = _currentPageIndicatorTintColor;
            }
            if ([indicator isMemberOfClass:[TAColoringIView class]]) {
                ((TAColoringIView *)indicator).tintColor = _currentPageIndicatorTintColor;
            }
        }
    } else {
        indicator = [[UIImageView alloc] initWithImage:_pageIndicatorImage];
    }
    
    if (indicator) {
        [self addSubview:indicator];
        [_indicatorViews addObject:indicator];
    }
    
    indicator.userInteractionEnabled = NO;
    return indicator;
}

- (void)changeActivity:(BOOL)active atIndex:(NSInteger)index
{
    if (_indicatorClass) {
        TAIndicatorView *indicator = (TAIndicatorView *)_indicatorViews[index];
        if (indicator.width == 0.f || indicator.height == 0.f) return;
        
        if ([indicator respondsToSelector:@selector(changeActivityState:)]) {
            [indicator changeActivityState:active];
        } else {
            NSLog(@"Custom view: %@ must implement a 'changeActivityState:' method or you can subclass %@ to help you.", _indicatorClass, [TAIndicatorView class]);
        }
    } else if (_pageIndicatorImage && _currentPageIndicatorImage) {
        UIImageView *indicator = (UIImageView *)_indicatorViews[index];
        indicator.image = active ? _currentPageIndicatorImage : _pageIndicatorImage;
    }
}

- (void)resetIndicators
{
    SEL sel = @selector(removeFromSuperview);
    [_indicatorViews makeObjectsPerformSelector:sel];
    [_indicatorViews removeAllObjects];
    [self updateIndicators];
}

- (void)hideForSinglePage
{
    self.hidden = _indicatorViews.count == 1 && _hidesForSinglePage;
}

#pragma mark - Setters

- (void)setIndicatorClass:(Class)indicatorClass
{
    _indicatorClass = indicatorClass;
    _indicatorSize = CGSizeZero;
    [self resetIndicators];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    [self resetIndicators];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    if (_numberOfPages == 0 || currentPage == _currentPage) {
        _currentPage = currentPage;
        return;
    }
    
    [self changeActivity:NO atIndex:_currentPage];
    _currentPage = currentPage;
    [self changeActivity:YES atIndex:_currentPage];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    if (_indicatorClass) [self resetIndicators];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    if (_indicatorClass) [self resetIndicators];
}

- (void)setIndicatorMargin:(CGFloat)indicatorMargin
{
    _indicatorMargin = indicatorMargin;
    if (self.width > 0.f && self.height > 0.f) {
        [self updateIndicators];
    }
}

- (void)setIndicatorDiameter:(CGFloat)indicatorDiameter
{
    _indicatorDiameter = indicatorDiameter;
    if (self.width > 0.f && self.height > 0.f) {
        [self updateIndicators];
    }
}

- (void)setPageIndicatorImage:(UIImage *)pageIndicatorImage
{
    _pageIndicatorImage = pageIndicatorImage;
    if (pageIndicatorImage) {
        _indicatorClass = nil;
        [self resetIndicators];
    }
}

- (void)setCurrentPageIndicatorImage:(UIImage *)currentPageIndicatorImage
{
    _currentPageIndicatorImage = currentPageIndicatorImage;
    if (currentPageIndicatorImage) {
        _indicatorClass = nil;
        [self resetIndicators];
    }
}

#pragma mark - Getters

- (CGSize)indicatorSize
{
    if (CGSizeEqualToSize(_indicatorSize, CGSizeZero)) {
        if (_pageIndicatorImage) {
            _indicatorSize = _pageIndicatorImage.size;
        } else if (_indicatorClass) {
            _indicatorSize.width = _indicatorDiameter;
            _indicatorSize.height = _indicatorDiameter;
        }
    }
    
    return _indicatorSize;
}

@end
