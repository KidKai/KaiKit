//
//  KaiKitGlobals.m
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

#import "KaiKitGlobals.h"

#if TARGET_OS_OSX

CGColorRef CGColorGetBlack(void)
{
    return NSColor.blackColor.CGColor;
}

CGColorRef CGColorGetDarkGray(void)
{
    return NSColor.darkGrayColor.CGColor;
}

CGColorRef CGColorGetLightGray(void)
{
    return NSColor.lightGrayColor.CGColor;
}

CGColorRef CGColorGetWhite(void)
{
    return NSColor.whiteColor.CGColor;
}

CGColorRef CGColorGetGray(void)
{
    return NSColor.grayColor.CGColor;
}

CGColorRef CGColorGetRed(void)
{
    return NSColor.redColor.CGColor;
}

CGColorRef CGColorGetGreen(void)
{
    return NSColor.greenColor.CGColor;
}

CGColorRef CGColorGetBlue(void)
{
    return NSColor.blueColor.CGColor;
}

CGColorRef CGColorGetCyan(void)
{
    return NSColor.cyanColor.CGColor;
}

CGColorRef CGColorGetYellow(void)
{
    return NSColor.yellowColor.CGColor;
}

CGColorRef CGColorGetMagenta(void)
{
    return NSColor.magentaColor.CGColor;
}

CGColorRef CGColorGetOrange(void)
{
    return NSColor.orangeColor.CGColor;
}

CGColorRef CGColorGetPurple(void)
{
    return NSColor.purpleColor.CGColor;
}

CGColorRef CGColorGetBrown(void)
{
    return NSColor.brownColor.CGColor;
}

CGColorRef CGColorGetClear(void)
{
    return NSColor.clearColor.CGColor;
}

#else

CGColorRef CGColorGetBlack(void)
{
    return UIColor.blackColor.CGColor;
}

CGColorRef CGColorGetDarkGray(void)
{
    return UIColor.darkGrayColor.CGColor;
}

CGColorRef CGColorGetLightGray(void)
{
    return UIColor.lightGrayColor.CGColor;
}

CGColorRef CGColorGetWhite(void)
{
    return UIColor.whiteColor.CGColor;
}

CGColorRef CGColorGetGray(void)
{
    return UIColor.grayColor.CGColor;
}

CGColorRef CGColorGetRed(void)
{
    return UIColor.redColor.CGColor;
}

CGColorRef CGColorGetGreen(void)
{
    return UIColor.greenColor.CGColor;
}

CGColorRef CGColorGetBlue(void)
{
    return UIColor.blueColor.CGColor;
}

CGColorRef CGColorGetCyan(void)
{
    return UIColor.cyanColor.CGColor;
}

CGColorRef CGColorGetYellow(void)
{
    return UIColor.yellowColor.CGColor;
}

CGColorRef CGColorGetMagenta(void)
{
    return UIColor.magentaColor.CGColor;
}

CGColorRef CGColorGetOrange(void)
{
    return UIColor.orangeColor.CGColor;
}

CGColorRef CGColorGetPurple(void)
{
    return UIColor.purpleColor.CGColor;
}

CGColorRef CGColorGetBrown(void)
{
    return UIColor.brownColor.CGColor;
}

CGColorRef CGColorGetClear(void)
{
    return UIColor.clearColor.CGColor;
}

#endif
