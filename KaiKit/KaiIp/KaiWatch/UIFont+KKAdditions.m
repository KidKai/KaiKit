//
//  UIFont+KKAdditions.m
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

#import "UIFont+KKAdditions.h"

@implementation UIFont (KKAdditions)

+ (UIFont *)largeTitleFont API_AVAILABLE(ios(11.0), watchos(5.0)) API_UNAVAILABLE(tvos)
{
    return [self preferredFontForTextStyle:UIFontTextStyleLargeTitle];
}

+ (UIFont *)title1Font NS_AVAILABLE_IOS(9_0)
{
    return [self preferredFontForTextStyle:UIFontTextStyleTitle1];
}

+ (UIFont *)title2Font NS_AVAILABLE_IOS(9_0)
{
    return [self preferredFontForTextStyle:UIFontTextStyleTitle2];
}

+ (UIFont *)title3Font NS_AVAILABLE_IOS(9_0)
{
    return [self preferredFontForTextStyle:UIFontTextStyleTitle3];
}

+ (UIFont *)headlineFont NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontForTextStyle:UIFontTextStyleHeadline];
}

+ (UIFont *)subheadlineFont NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontForTextStyle:UIFontTextStyleSubheadline];
}

+ (UIFont *)bodyFont NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontForTextStyle:UIFontTextStyleBody];
}

+ (UIFont *)calloutFont NS_AVAILABLE_IOS(9_0)
{
    return [self preferredFontForTextStyle:UIFontTextStyleCallout];
}

+ (UIFont *)footnoteFont NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontForTextStyle:UIFontTextStyleFootnote];
}

+ (UIFont *)caption1Font NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontForTextStyle:UIFontTextStyleCaption1];
}

+ (UIFont *)caption2Font NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontForTextStyle:UIFontTextStyleCaption2];
}

@end
