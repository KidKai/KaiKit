//
//  LCAnimatedPageControl.m
//  LCAnimatedPageControl
//
//  Created by beike on 6/17/15.
//  Copyright (c) 2015 beike. All rights reserved.
//

#import "LCAnimatedPageControl.h"
#import "IndicatorView.h"

static CGFloat kLCDoubleNumber = 2.f;
static CGFloat kLCHalfNumber = 0.5f;
static CGFloat kLCMultiple = 1.4f;

@interface LCAnimatedPageControl () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *indicatorViews;
@property (nonatomic, strong) NSMutableArray *indicatorCons;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL isDefaultSet;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) NSLayoutConstraint *contentWidthCon;
@property (nonatomic, strong) NSLayoutConstraint *squirmCenterCon;
@property (nonatomic, strong) NSLayoutConstraint *squirmWidthCon;
@property (nonatomic, strong) UIView *squirmView;

@end

@implementation LCAnimatedPageControl

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
    _contentView = [[UIView alloc] init];
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_contentView];
    [self addConstraints:
     @[[NSLayoutConstraint constraintWithItem:_contentView
                                    attribute:NSLayoutAttributeCenterX
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeCenterX
                                   multiplier:1.f constant:0.f],
       [NSLayoutConstraint constraintWithItem:_contentView
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeCenterY
                                   multiplier:1.f constant:0.f]
       ]];
    _indicatorViews = [NSMutableArray array];
    _indicatorCons = [NSMutableArray array];
    _numberOfPages = 0;
    _currentPage = 0;
    _pageIndicatorColor = [UIColor orangeColor];
    _currentPageIndicatorColor = [UIColor blackColor];
    _indicatorMultiple = kLCMultiple;
    _indicatorDiameter = self.frame.size.height / _indicatorMultiple;
    _indicatorMargin = 0.f;
    _radius = _indicatorDiameter * kLCHalfNumber;
}

- (void)prepareShow
{
    [self addIndicatorsWithIndex:0];
    [self.sourceScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    CGFloat viewWidth = (_indicatorDiameter * _indicatorMultiple) * _numberOfPages + (_numberOfPages - 1) * _indicatorMargin;
    self.contentWidthCon = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.f constant:viewWidth];
    [self.contentView addConstraint:_contentWidthCon];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.f constant:_indicatorDiameter * _indicatorMultiple]];
    
    switch (_pageStyle) {
        case LCPageStyleSquirm: {
            self.squirmView = [[UIView alloc] init];
            self.squirmView.translatesAutoresizingMaskIntoConstraints = NO;
            self.squirmView.clipsToBounds = YES;
            self.squirmView.layer.cornerRadius = _radius;
            self.squirmView.backgroundColor = _currentPageIndicatorColor;
            [self.contentView addSubview:_squirmView];
            
            [self layoutSquirmView];
        } break;
            
        case LCPageStyleScaleColor:
        case LCPageStyleFillColor:
            [self configDefaultIndicator];
            break;
            
        case LCPageStyleDepthColor: {
            [self configDefaultIndicator];
            [self.indicatorViews.firstObject setBackgroundColor:_currentPageIndicatorColor];
            [self.contentView bringSubviewToFront:_indicatorViews.firstObject];
        } break;
    }
}

- (void)setPageStyle:(PageStyle)pageStyle
{
    _pageStyle = pageStyle;
    if (pageStyle == LCPageStyleSquirm) {
        self.indicatorMultiple = 1.f;
    }
}

- (void)clearIndicators
{
    for (UIView *view in _indicatorViews) {
        if (view.layer.timeOffset < 1.f) {
            view.layer.timeOffset = 0.f;
        }
    }
}

- (void)setIndicatorDiameter:(CGFloat)indicatorDiameter
{
    _indicatorDiameter = indicatorDiameter;
    _radius = _indicatorDiameter * kLCHalfNumber;
}

- (void)addIndicatorsWithIndex:(NSInteger)index
{
    for (NSInteger number = index; number < _numberOfPages; number++) {
        UIView *indicator = nil;
        if (_pageStyle == LCPageStyleFillColor) {
            indicator = [[IndicatorView alloc] init];
            [(IndicatorView *)indicator backView].backgroundColor = _currentPageIndicatorColor;
            [(IndicatorView *)indicator frontView].backgroundColor = _pageIndicatorColor;
            [(IndicatorView *)indicator backView].layer.cornerRadius = _radius;
            [(IndicatorView *)indicator frontView].layer.cornerRadius = _radius;
            [self configZeroScaleAnimation:[(IndicatorView *)indicator backView]];
            [self configZeroScaleAnimation:[(IndicatorView *)indicator frontView]];
        } else {
            indicator = [[UIView alloc] init];
            indicator.backgroundColor = _pageIndicatorColor;
        }
        indicator.clipsToBounds = YES;
        indicator.layer.cornerRadius = _radius;
        
        [self.contentView addSubview:indicator];
        [self.indicatorViews addObject:indicator];
        if (_pageStyle == LCPageStyleScaleColor) {
            [self configCSAnimation:indicator];
        }
        else if (_pageStyle == LCPageStyleDepthColor) {
            if (number == 0) {
                [self configScaleAnimation:indicator];
            } else {
                [self configSmallScaleAnimation:indicator];
            }
        }
    }
    [self layoutContentView];
}

- (void)removeIndicatorsWithNumber:(NSInteger)number
{
    NSRange range = NSMakeRange(0, ABS(number));
    NSArray *array = [self.indicatorViews subarrayWithRange:range];
    [array makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:range];
    [self.indicatorViews removeObjectsAtIndexes:indexes];
    [self layoutContentView];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [self setCurrentPage:currentPage sendEvent:NO];
}

- (void)setCurrentPage:(NSInteger)currentPage sendEvent:(BOOL)sendEvent
{
    _currentPage = MIN(currentPage, _numberOfPages - 1);
    if (sendEvent) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    numberOfPages = MAX(0, numberOfPages);
    NSInteger difference = numberOfPages - _numberOfPages;
    NSInteger lastNumberPages = _numberOfPages;
    _numberOfPages = numberOfPages;
    if (difference && self.superview) {
        [self.contentView removeConstraints:_contentView.constraints];
        // remove
        if (difference < 0) {
            if (_currentPage != lastNumberPages - 1) {
                [self configCurrentIndicator];
            }
            if (_currentPage > _numberOfPages - 1) {
                _currentPage = _numberOfPages - 1;
            }
            [self removeIndicatorsWithNumber:difference];
        }
        // add
        else {
            [self addIndicatorsWithIndex:lastNumberPages];
        }
        [self resetContentLayout];
        if (_pageStyle == LCPageStyleDepthColor) {
            [self configDepthView];
        }
        else if (_pageStyle == LCPageStyleSquirm) {
            [self layoutSquirmView];
        }
    }
}

- (void)configCurrentIndicator
{
    UIView *view = self.indicatorViews[_currentPage];
    if ([view isKindOfClass:[IndicatorView class]]) {
        [(IndicatorView *)view frontView].layer.timeOffset = 1.f;
    } else {
        view.layer.timeOffset = 0.f;
    }
}

- (void)resetContentLayout
{
    if (_numberOfPages) {
        CGFloat viewWidth = (_indicatorDiameter * _indicatorMultiple) * _numberOfPages + (_numberOfPages - 1) * _indicatorMargin;
        self.contentWidthCon = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.f constant:viewWidth];
        [self.contentView addConstraint:_contentWidthCon];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.f constant:_indicatorDiameter * _indicatorMultiple]];
    }
}

- (void)configDepthView
{
    UIView *depthView = self.indicatorViews.firstObject;
    [depthView.layer removeAllAnimations];
    depthView.backgroundColor = _currentPageIndicatorColor;
    [self.contentView bringSubviewToFront:depthView];
    [self configScaleAnimation:depthView];
    
    for (NSInteger index = 1; index <= _currentPage; index++) {
        NSLayoutConstraint *con = self.indicatorCons[index];
        con.constant = (_indicatorDiameter * _indicatorMultiple * kLCHalfNumber) + (index - 1) * (_indicatorDiameter * _indicatorMultiple + _indicatorMargin);
    }
}

- (void)configDefaultIndicator
{
    self.isDefaultSet = YES;
    if (self.indicatorViews.count) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            CGPoint offset = self.sourceScrollView.contentOffset;
            CGFloat rate = offset.x / self.sourceScrollView.bounds.size.width;
            NSInteger currentIndex = (NSInteger)ceilf(rate);
            if (currentIndex > self.numberOfPages - 1) currentIndex--;
            UIView *currentIndicator = self.indicatorViews[currentIndex];
            self.currentPage = currentIndex;
            switch (self.pageStyle) {
                case LCPageStyleSquirm: break;
                    
                case LCPageStyleScaleColor: {
                    currentIndicator.layer.timeOffset = 1.f;
                } break;
                    
                case LCPageStyleFillColor: {
                    [(IndicatorView *)currentIndicator frontView].layer.timeOffset = 1.f;
                } break;
                    
                case LCPageStyleDepthColor: {
                    currentIndicator.layer.timeOffset = 0.f;
                    if (currentIndex) {
                        NSLayoutConstraint *currentCon = self.indicatorCons[currentIndex];
                        NSLayoutConstraint *lastCon = self.indicatorCons.firstObject;
                        currentCon.constant = (self.indicatorDiameter * self.indicatorMultiple * kLCHalfNumber);
                        lastCon.constant = (self.indicatorDiameter * self.indicatorMultiple * kLCHalfNumber) + currentIndex * (self.indicatorDiameter * self.indicatorMultiple + self.indicatorMargin);
                    }
                } break;
            }
            self.isDefaultSet = NO;
        });
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSValue *oldOffsetValue = change[NSKeyValueChangeOldKey];
    CGPoint oldOffset = [oldOffsetValue CGPointValue];
    
    NSValue *newOffsetValue = change[NSKeyValueChangeNewKey];
    CGPoint newOffset = [newOffsetValue CGPointValue];
    
    CGFloat scrollViewWidth = [(UIScrollView *)object bounds].size.width;
    
    CGFloat rate = newOffset.x / scrollViewWidth;
    if (rate >= 0.f && rate <= _numberOfPages - 1) {
        
        NSInteger currentIndex = (NSInteger)ceilf(rate);
        NSInteger lastIndex = (NSInteger)floorf(rate);
        if (currentIndex == lastIndex && currentIndex >= 1) {
            lastIndex -= 1;
        }
        
        UIView *currentPointView = _indicatorViews[currentIndex];
        UIView *lastPointView = _indicatorViews[lastIndex];
        CGFloat timeOffset = rate - floorf(rate);
        if (timeOffset == 0.f && currentIndex) timeOffset = 1.f;
        
        BOOL isNoAnimationScroll = NO;
        if ((NSInteger)newOffset.x % (NSInteger)scrollViewWidth == 0 &&
            (NSInteger)oldOffset.x % (NSInteger)scrollViewWidth == 0 &&
            newOffset.x != oldOffset.x &&
            (NSInteger)ABS(newOffset.x - oldOffset.x)) {
            CGFloat oldRate = oldOffset.x / scrollViewWidth;
            lastIndex = (NSInteger)ceilf(oldRate);
            if (lastIndex <= _numberOfPages - 1) {
                lastPointView = _indicatorViews[lastIndex];
                isNoAnimationScroll = YES;
            }
        }
        
        if (!_sourceScrollView.decelerating && _isDefaultSet) return;
        
        switch (_pageStyle) {
            case LCPageStyleSquirm: {
                if (timeOffset - kLCHalfNumber <= 0.f) {
                    timeOffset = timeOffset * kLCDoubleNumber;
                } else {
                    timeOffset = (CGFloat)ABS(timeOffset - 1.f) * kLCDoubleNumber;
                }
                CGFloat number = (_indicatorMargin - _indicatorDiameter) * kLCHalfNumber;
                _squirmCenterCon.constant = rate * kLCDoubleNumber * (_indicatorMargin - number) + _indicatorDiameter * kLCHalfNumber;
                _squirmWidthCon.constant = timeOffset * (_indicatorDiameter + _indicatorMargin);
            } break;
                
            case LCPageStyleScaleColor: {
                if (isNoAnimationScroll) timeOffset = 1.f;
                currentPointView.layer.timeOffset = timeOffset;
                lastPointView.layer.timeOffset = 1.f - timeOffset;
            } break;
                
            case LCPageStyleFillColor: {
                if (isNoAnimationScroll) timeOffset = 1.f;
                [(IndicatorView *)currentPointView frontView].layer.timeOffset = timeOffset;
                [(IndicatorView *)lastPointView frontView].layer.timeOffset = 1.f - timeOffset;
            } break;
                
            case LCPageStyleDepthColor: {
                UIView *lastPointView = _indicatorViews.firstObject;
                lastIndex = 0;
                CGFloat halfTimeOffset = 0.f;
                if (timeOffset - kLCHalfNumber <= 0.f) {
                    halfTimeOffset = timeOffset * kLCDoubleNumber;
                } else {
                    halfTimeOffset = (CGFloat)ABS(timeOffset - 1.f) * kLCDoubleNumber;
                }
                
                currentPointView.layer.timeOffset = halfTimeOffset;
                lastPointView.layer.timeOffset = halfTimeOffset;
                NSLayoutConstraint *currentCon = _indicatorCons[currentIndex];
                NSLayoutConstraint *lastCon = _indicatorCons[lastIndex];
                if (isNoAnimationScroll) {
                    CGFloat oldRate = oldOffset.x / scrollViewWidth;
                    lastIndex = (NSInteger)ceilf(oldRate);
                    if (lastIndex > currentIndex) {
                        currentCon = _indicatorCons[currentIndex + 1];
                    }
                    currentCon.constant = (_indicatorDiameter * _indicatorMultiple * kLCHalfNumber) + (currentIndex - (lastIndex > currentIndex ? -1 : 1)) * (_indicatorDiameter * _indicatorMultiple + _indicatorMargin);
                } else {
                    currentCon.constant = (_indicatorDiameter * _indicatorMultiple * kLCHalfNumber) + (currentIndex - timeOffset) * (_indicatorDiameter * _indicatorMultiple + _indicatorMargin);
                }
                lastCon.constant = (_indicatorDiameter * _indicatorMultiple * kLCHalfNumber) + (timeOffset + (currentIndex ? : 1 ) - 1) * (_indicatorDiameter * _indicatorMultiple + _indicatorMargin);
            } break;
        }
        _currentPage = currentIndex;
    }
}

- (void)layoutSquirmView
{
    [self.contentView bringSubviewToFront:_squirmView];
    self.squirmView.hidden = !_numberOfPages;
    self.squirmCenterCon = [NSLayoutConstraint constraintWithItem:_squirmView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeading multiplier:1.f constant:-_indicatorDiameter * kLCHalfNumber];
    [self.contentView addConstraints:
     @[_squirmCenterCon,
       [NSLayoutConstraint constraintWithItem:_squirmView
                                    attribute:NSLayoutAttributeCenterY
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:_contentView
                                    attribute:NSLayoutAttributeCenterY
                                   multiplier:1.f constant:0.f]
       ]];
    if (!_squirmWidthCon) {
        [self.squirmView addConstraint:[NSLayoutConstraint constraintWithItem:_squirmView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.f constant:_indicatorDiameter]];
        
        self.squirmWidthCon = [NSLayoutConstraint constraintWithItem:_squirmView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_squirmView attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f];
        [self.squirmView addConstraint:_squirmWidthCon];
    }
}

- (void)layoutContentView
{
    [self.indicatorCons removeAllObjects];
    [self.indicatorViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
        // size
        [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.f constant:self.indicatorDiameter]];
        [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.f constant:0.f]];
        // position
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f]];
        NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.f constant:(self.indicatorDiameter * self.indicatorMultiple * kLCHalfNumber) + idx * (self.indicatorDiameter * self.indicatorMultiple + self.indicatorMargin)];
        [self.indicatorCons addObject:con];
        [self.contentView addConstraint:con];
    }];
}

- (void)configCSAnimation:(UIView *)view
{
    [self configColorAnimation:view];
    [self configScaleAnimation:view];
}

- (void)configColorAnimation:(UIView *)view
{
    CABasicAnimation *changeColor = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    changeColor.fromValue = (id)[self.pageIndicatorColor CGColor];
    changeColor.toValue = (id)[self.currentPageIndicatorColor CGColor];
    changeColor.duration  = 1.f;
    changeColor.removedOnCompletion = NO;
    [view.layer addAnimation:changeColor forKey:@"Change color"];
    view.layer.speed = 0.f;
}

- (void)configScaleAnimation:(UIView *)view
{
    CABasicAnimation *changeScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    changeScale.fromValue = @1.f;
    changeScale.toValue = @(_indicatorMultiple);
    changeScale.duration  = 1.f;
    changeScale.removedOnCompletion = NO;
    [view.layer addAnimation:changeScale forKey:@"Change scale"];
    view.layer.speed = 0.f;
}

- (void)configSmallScaleAnimation:(UIView *)view
{
    CABasicAnimation *changeScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    changeScale.fromValue = @1.f;
    changeScale.toValue = @(1/_indicatorMultiple);
    changeScale.duration  = 1.f;
    changeScale.removedOnCompletion = NO;
    [view.layer addAnimation:changeScale forKey:@"Change scale small"];
    view.layer.speed = 0.f;
}

- (void)configZeroScaleAnimation:(UIView *)view
{
    CABasicAnimation *changeScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    changeScale.fromValue = @1.f;
    changeScale.toValue = @0.f;
    changeScale.duration  = 1.f;
    changeScale.removedOnCompletion = NO;
    [view.layer addAnimation:changeScale forKey:@"Change scale zero"];
    view.layer.speed = 0.f;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_contentView];
    CGFloat currentX = (_indicatorMultiple * _indicatorDiameter + _indicatorMargin) * _currentPage + _indicatorMultiple * _indicatorDiameter * kLCHalfNumber;
    if (point.x > currentX) {
        self.currentPage++;
    } else if (_currentPage) {
        self.currentPage--;
    }
    [self setCurrentPage:_currentPage sendEvent:YES];
}

- (void)dealloc
{
    [self.sourceScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
