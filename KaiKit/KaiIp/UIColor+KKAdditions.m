//
//  UIColor+KKAdditions.m
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

#import "UIColor+KKAdditions.h"
#import "UIImage+KKAdditions.h"

@implementation UIColor (KKAdditions)

+ (UIColor *)colorWithInt:(UInt8)red green:(UInt8)green blue:(UInt8)blue
{
    return [[UIColor alloc] initWithInt:red green:green blue:blue];
}

+ (UIColor *)colorWithInt:(UInt8)red green:(UInt8)green blue:(UInt8)blue alpha:(CGFloat)alpha
{
    return [[UIColor alloc] initWithInt:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithHexUInt:(UInt32)hexUInt
{
    return [[UIColor alloc] initWithHexUInt:hexUInt];
}

+ (UIColor *)colorWithHexUStr:(NSString *)hexUStr
{
    return [[UIColor alloc] initWithHexUStr:hexUStr];
}

- (UIColor *)initWithInt:(UInt8)red green:(UInt8)green blue:(UInt8)blue
{
    return [self initWithInt:red green:green blue:blue alpha:1.f];
}

- (UIColor *)initWithInt:(UInt8)red green:(UInt8)green blue:(UInt8)blue alpha:(CGFloat)alpha
{
    return [self initWithRed:(CGFloat)red / 255.f
                       green:(CGFloat)green / 255.f
                        blue:(CGFloat)blue / 255.f
                       alpha:alpha];
}

- (UIColor *)initWithHexUInt:(UInt32)hexUInt
{
    if (hexUInt <= 0xFFFFFF) {
        return [self initWithInt:(hexUInt >> 16) & 0xFF
                           green:(hexUInt >> 8) & 0xFF
                            blue:(hexUInt >> 0) & 0xFF];
    }
    
    UInt8 alpha = (hexUInt >> 24) & 0xFF;
    return [self initWithInt:(hexUInt >> 16) & 0xFF
                       green:(hexUInt >> 8) & 0xFF
                        blue:(hexUInt >> 0) & 0xFF
                       alpha:(CGFloat)alpha / 255.f];
}

- (UIColor *)initWithHexUStr:(NSString *)hexUStr
{
    if ([hexUStr hasPrefix:@"#"]) {
        hexUStr = [hexUStr substringFromIndex:1];
    }
    unsigned hexUInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexUStr];
    [scanner scanHexInt:&hexUInt];
    return [self initWithHexUInt:hexUInt];
}

- (UIImage *)image {
    return [UIImage imageWithColor:self];
}

@end
