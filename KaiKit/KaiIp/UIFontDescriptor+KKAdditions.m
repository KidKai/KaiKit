//
//  UIFontDescriptor+KKAdditions.m
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

#import "UIFontDescriptor+KKAdditions.h"

@implementation UIFontDescriptor (KKAdditions)

+ (UIFontDescriptor *)largeTitleFont API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(watchos, tvos)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleLargeTitle];
}

+ (UIFontDescriptor *)title1Font NS_AVAILABLE_IOS(9_0)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleTitle1];
}

+ (UIFontDescriptor *)title2Font NS_AVAILABLE_IOS(9_0)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleTitle2];
}

+ (UIFontDescriptor *)title3Font NS_AVAILABLE_IOS(9_0)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleTitle3];
}

+ (UIFontDescriptor *)headlineFont NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleHeadline];
}

+ (UIFontDescriptor *)subheadlineFont NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleSubheadline];
}

+ (UIFontDescriptor *)bodyFont NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
}

+ (UIFontDescriptor *)calloutFont NS_AVAILABLE_IOS(9_0)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleCallout];
}

+ (UIFontDescriptor *)footnoteFont NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleFootnote];
}

+ (UIFontDescriptor *)caption1Font NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleCaption1];
}

+ (UIFontDescriptor *)caption2Font NS_AVAILABLE_IOS(7_0)
{
    return [self preferredFontDescriptorWithTextStyle:UIFontTextStyleCaption2];
}

@end
