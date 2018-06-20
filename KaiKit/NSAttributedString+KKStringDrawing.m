//
//  NSAttributedString+KKStringDrawing.m
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

#import "NSAttributedString+KKStringDrawing.h"

@implementation NSAttributedString (KKStringDrawing)

- (NSUInteger)numberOfLines:(CGFloat)bounded
{
    id string = [[NSAttributedString alloc] initWithString:@"USA"];
    double every = (double)[string upright:bounded];
    double whole = (double)[self upright:bounded];
    return (NSUInteger)(ceil(whole / every));
}

- (CGFloat)aclinic:(CGFloat)boundedUpright
{
    return [self cgfloat:boundedUpright isBoundedVertical:YES];
}

- (CGFloat)upright:(CGFloat)boundedAclinic
{
    return [self cgfloat:boundedAclinic isBoundedVertical:NO];
}

- (CGFloat)cgfloat:(CGFloat)cgfloat isBoundedVertical:(BOOL)vertical
{
    CGFloat height = vertical ? cgfloat : CGFLOAT_MAX;
    CGFloat width = !vertical ? cgfloat : CGFLOAT_MAX;
#if TARGET_OS_OSX
    NSRect frame =
    [self boundingRectWithSize:NSMakeSize(width, height)
                       options:NSStringDrawingUsesLineFragmentOrigin
                       context:nil];
    return vertical ? NSWidth(frame) : NSHeight(frame);
#else
    CGRect frame =
    [self boundingRectWithSize:CGSizeMake(width, height)
                       options:NSStringDrawingUsesLineFragmentOrigin
                       context:nil];
    return vertical ? CGRectGetWidth(frame) : CGRectGetHeight(frame);
#endif
}

@end
