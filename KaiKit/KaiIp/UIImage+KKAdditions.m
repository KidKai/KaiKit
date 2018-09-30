//
//  UIImage+KKAdditions.m
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

#import "UIImage+KKAdditions.h"
#import "UIView+KKViewGeometry.h"

@implementation UIImage (KKAdditions)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.f, 0.f, 1.f, 1.f);
    if (@available(iOS 10.0, *)) {
        id renderer = [[UIGraphicsImageRenderer alloc] initWithSize:rect.size];
        return [renderer imageWithActions:^(id  _Nonnull rendererContext) {
            [color setFill];
            UIRectFill(rect);
        }];
    } else {
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}

- (UIImage *)resizableImageWithScale:(CGFloat)scale
{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self];
    CGFloat width = self.size.width * scale;
    CGFloat height = self.size.height * scale;
    imageView.frame = CGRectMake(0.f, 0.f, width, height);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIGraphicsBeginImageContextWithOptions(imageView.size, NO, scale);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

- (UIImage *)resizableImageWithWidth:(CGFloat)width
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self];
    CGFloat origin = self.size.width / self.size.height;
    imageView.frame = CGRectMake(0.f, 0.f, width, ceil(width / origin));
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIGraphicsBeginImageContextWithOptions(imageView.size, NO, self.scale);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

@end
