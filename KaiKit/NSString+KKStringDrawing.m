//
//  NSString+KKStringDrawing.m
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

#import "NSString+KKStringDrawing.h"

@implementation NSString (KKStringDrawing)

#if TARGET_OS_OSX
- (NSUInteger)numberOfLines:(CGFloat)bounded font:(NSFont *)font
#else
- (NSUInteger)numberOfLines:(CGFloat)bounded font:(UIFont *)font
#endif
{
    double every = (double)[@"USA" upright:bounded font:font];
    double whole = (double)[self upright:bounded font:font];
    return (NSUInteger)(ceil(whole / every));
}

#if TARGET_OS_OSX
- (CGFloat)aclinic:(CGFloat)boundedUpright font:(NSFont *)font
#else
- (CGFloat)aclinic:(CGFloat)boundedUpright font:(UIFont *)font
#endif
{
    return [self cgfloat:boundedUpright font:font isBoundedVertical:YES];
}

#if TARGET_OS_OSX
- (CGFloat)upright:(CGFloat)boundedAclinic font:(NSFont *)font
#else
- (CGFloat)upright:(CGFloat)boundedAclinic font:(UIFont *)font
#endif
{
    return [self cgfloat:boundedAclinic font:font isBoundedVertical:NO];
}

#if TARGET_OS_OSX
- (CGFloat)cgfloat:(CGFloat)cgfloat font:(NSFont *)font isBoundedVertical:(BOOL)vertical
#else
- (CGFloat)cgfloat:(CGFloat)cgfloat font:(UIFont *)font isBoundedVertical:(BOOL)vertical
#endif
{
    CGFloat height = vertical ? cgfloat : CGFLOAT_MAX;
    CGFloat width = !vertical ? cgfloat : CGFLOAT_MAX;
#if TARGET_OS_OSX
    NSRect frame =
    [self boundingRectWithSize:NSMakeSize(width, height)
                       options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{NSFontAttributeName:font}
                       context:nil];
    return vertical ? NSWidth(frame) : NSHeight(frame);
#else
    CGRect frame =
    [self boundingRectWithSize:CGSizeMake(width, height)
                       options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{NSFontAttributeName:font}
                       context:nil];
    return vertical ? CGRectGetWidth(frame) : CGRectGetHeight(frame);
#endif
}

@end
