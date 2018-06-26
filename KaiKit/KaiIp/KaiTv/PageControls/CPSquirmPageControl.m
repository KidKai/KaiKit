//
//  CPSquirmPageControl.m
//  zent
//
//  Created by Morplcp on 2018/4/27.
//  Copyright (c) 2018 morplcp. All rights reserved.
//

#import "CPSquirmPageControl.h"
#import "UIView+KKViewGeometry.h"

static CGFloat kCPDoubleNumber = 2.f;
static CGFloat kCPHalfNumber = 0.5f;

@interface CPSquirmPageControl ()

@property (nonatomic, strong) NSMutableArray *indicatorViews;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL    isAnimating;
@property (nonatomic, assign) CGFloat radius;

@end

@implementation CPSquirmPageControl

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
    _contentView = [[UIView alloc] init];
    _numberOfPages = 0;
    _currentPage = 0;
    _pageIndicatorTintColor = [UIColor orangeColor];
    _currentPageIndicatorTintColor = [UIColor blackColor];
    _indicatorDiameter = 0.f;
    _indicatorMargin = 0.f;
    _radius = _indicatorDiameter * kCPHalfNumber;
    
    [self addSubview:_contentView];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentView.frame = self.bounds;
    if (_indicatorViews.count == 0) {
        if (_numberOfPages == 0) return;
        [self addIndicatorsWithIndex:0];
    }
    [_indicatorViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == self.currentPage) {
            obj.backgroundColor = self.currentPageIndicatorTintColor;
        } else {
            obj.backgroundColor = self.pageIndicatorTintColor;
        }
        obj.layer.cornerRadius = self.isRadiusZero ? 0.f : self.radius;
    }];
    [self layoutIndicatorsFrom:0 to:_indicatorViews.count currentPage:_currentPage];
}

#pragma mark - Loadings

- (void)addIndicatorsWithIndex:(NSInteger)index
{
    for (NSInteger number = index; number < _numberOfPages; number++) {
        UIView *indicator = [[UIView alloc] init];
        indicator.clipsToBounds = YES;
        indicator.layer.cornerRadius = _isRadiusZero ? 0.f : _radius;
        indicator.backgroundColor = _pageIndicatorTintColor;
        [_contentView addSubview:indicator];
        [_indicatorViews addObject:indicator];
    }
}

- (void)removeIndicatorsWithNumber:(NSInteger)number
{
    NSRange range = NSMakeRange(0, ABS(number));
    NSArray *array = [_indicatorViews subarrayWithRange:range];
    [array makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:range];
    [_indicatorViews removeObjectsAtIndexes:indexes];
}

- (void)layoutIndicatorsFrom:(NSUInteger)from to:(NSUInteger)to currentPage:(NSInteger)currentPage
{
    CGFloat pagesWidth = [self sizeForNumberOfPages:_numberOfPages].width;
    
    for (NSUInteger i = from; i < to; i++) {
        UIView *indicator = _indicatorViews[i];
        
        CGFloat extraWidth = currentPage < i ? _indicatorDiameter : 0.f;
        CGFloat minX = kCPHalfNumber * (self.width - pagesWidth);
        CGFloat minY = kCPHalfNumber * (self.height - _indicatorDiameter);
        CGFloat x = minX + (_indicatorDiameter + _indicatorMargin) * i + extraWidth;
        CGFloat width = _indicatorDiameter * (i == currentPage ? kCPDoubleNumber : 1.f);
        
        indicator.frame = CGRectMake(x, minY, width, _indicatorDiameter);
    }
}

#pragma mark - Setters

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    numberOfPages = MAX(0, numberOfPages);
    NSInteger difference = numberOfPages - _numberOfPages;
    NSInteger lastNumberPages = _numberOfPages;
    _numberOfPages = numberOfPages;
    if (difference && self.superview) {
        // remove
        if (difference < 0) {
            if (_currentPage > _numberOfPages - 1) {
                _currentPage = _numberOfPages - 1;
            }
            [self removeIndicatorsWithNumber:difference];
        }
        // add
        else {
            [self addIndicatorsWithIndex:lastNumberPages];
        }
    }
    if (_contentView.width > 0.f) [self setNeedsLayout];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    currentPage = MIN(currentPage, _numberOfPages - 1);
    
    if (_indicatorViews.count == 0) {
        _currentPage = currentPage;
        return;
    }
    if (_currentPage == currentPage) return;
    if (_isAnimating) return;
    
    [self animateToActiveStateAtCurrentPage:currentPage];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    if (_contentView.width > 0.f) [self setNeedsLayout];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    if (_contentView.width > 0.f) [self setNeedsLayout];
}

- (void)setIndicatorMargin:(CGFloat)indicatorMargin
{
    _indicatorMargin = indicatorMargin;
    if (_contentView.width > 0.f) [self setNeedsLayout];
}

- (void)setIndicatorDiameter:(CGFloat)indicatorDiameter
{
    _indicatorDiameter = indicatorDiameter;
    _radius = _indicatorDiameter * kCPHalfNumber;
    if (_contentView.width > 0.f) [self setNeedsLayout];
}

#pragma mark - Getters

- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    CGFloat viewWidth = (pageCount - 1) * _indicatorMargin + (pageCount + 1) * _indicatorDiameter;
    return pageCount == 0 ? CGSizeZero : CGSizeMake(viewWidth, _indicatorDiameter);
}

#pragma mark - Animation

- (void)animateToActiveStateAtCurrentPage:(NSInteger)currentPage
{
    _isAnimating = YES;
    BOOL biggerThanOrigin = currentPage > _currentPage;
    UIView *currentView = _indicatorViews[_currentPage];
    UIView *nextView = _indicatorViews[currentPage];
    [_contentView bringSubviewToFront:currentView];
    [UIView animateWithDuration:0.25f animations:^{
        CGRect newFrame = currentView.frame;
        NSInteger difference = ABS(currentPage - self.currentPage);
        newFrame.size = CGSizeMake((self.indicatorDiameter + self.indicatorMargin) * difference + self.indicatorDiameter * kCPDoubleNumber, currentView.height);
        if (!biggerThanOrigin) {
            newFrame.origin = CGPointMake(currentView.minX - (self.indicatorDiameter + self.indicatorMargin) * difference, currentView.minY);
        }
        currentView.frame = newFrame;
    } completion:^(BOOL finished) {
        [self.contentView bringSubviewToFront:nextView];
        currentView.backgroundColor = self.pageIndicatorTintColor;
        nextView.backgroundColor = self.currentPageIndicatorTintColor;
        nextView.frame = currentView.frame;
        NSUInteger from = biggerThanOrigin ? self.currentPage : (currentPage + 1);
        NSUInteger to = biggerThanOrigin ? currentPage : self.indicatorViews.count;
        [self layoutIndicatorsFrom:from to:to currentPage:currentPage];
        
        [UIView animateWithDuration:0.25f animations:^{
            CGRect newFrame = nextView.frame;
            newFrame.size = CGSizeMake(self.indicatorDiameter * kCPDoubleNumber, nextView.height);
            if (biggerThanOrigin) {
                newFrame.origin = CGPointMake(nextView.maxX - self.indicatorDiameter * kCPDoubleNumber, nextView.minY);
            }
            nextView.frame = newFrame;
        } completion:^(BOOL finished) {
            self->_currentPage = currentPage;
            self->_isAnimating = NO;
        }];
    }];
}

@end
