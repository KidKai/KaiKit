//
//  UIImage+Luban_iOS_Extension_h.m
//  Luban-iOS
//
//  Created by guo on 2017/7/20.
//  Copyright © 2017年 guo. All rights reserved.
//

#import "UIImage+Luban_iOS_Extension_h.h"
#import "KaiIpGlobals.h"
#import <objc/runtime.h>

@implementation UIImage (Luban_iOS_Extension_h)

static char isCustomImage;
static char customImageName;

+ (NSData *)lubanCompressImage:(UIImage *)image {
    return [self lubanCompressImage:image watermarkName:nil];
}

+ (NSData *)lubanCompressImage:(UIImage *)image watermarkName:(NSString *)markName {
    
    double size;
    NSData *imageData = UIImageJPEGRepresentation(image, 1.f);
    
    NSLog(@"Luban-iOS image data size before compressed == %f KB",
          (double)imageData.length / 1024.f);
    
    int fixelW = (int)image.size.width;
    int fixelH = (int)image.size.height;
    int thumbW = fixelW % 2 == 1 ? fixelW + 1 : fixelW;
    int thumbH = fixelH % 2 == 1 ? fixelH + 1 : fixelH;
    
    double scale = (double)fixelW / (double)fixelH;
    
    if (scale <= 1.f && scale > 0.5625f) {
        
        if (fixelH < 1664) {
            if ((double)imageData.length / 1024.f < 150.f) return imageData;
            size = (fixelW * fixelH) / pow(1664.f, 2.f) * 150.f;
            size = size < 60.f ? 60.f : size;
        }
        else if (fixelH >= 1664 && fixelH < 4990) {
            thumbW = fixelW / 2;
            thumbH = fixelH / 2;
            size = (thumbW * thumbH) / pow(2495.f, 2.f) * 300.f;
            size = size < 60.f ? 60.f : size;
        }
        else if (fixelH >= 4990 && fixelH < 10240) {
            thumbW = fixelW / 4;
            thumbH = fixelH / 4;
            size = (thumbW * thumbH) / pow(2560.f, 2.f) * 300.f;
            size = size < 100.f ? 100.f : size;
        }
        else {
            int multiple = fixelH / 1280 == 0 ? 1 : fixelH / 1280;
            thumbW = fixelW / multiple;
            thumbH = fixelH / multiple;
            size = (thumbW * thumbH) / pow(2560.f, 2.f) * 300.f;
            size = size < 100.f ? 100.f : size;
        }
    }
    else if (scale <= 0.5625f && scale > 0.5f) {
        
        if (fixelH < 1280 && (double)imageData.length / 1024.f < 200.f) return imageData;
        int multiple = fixelH / 1280 == 0 ? 1 : fixelH / 1280;
        thumbW = fixelW / multiple;
        thumbH = fixelH / multiple;
        size = (thumbW * thumbH) / (1440.f * 2560.f) * 400.f;
        size = size < 100.f ? 100.f : size;
    }
    else {
        int multiple = (int)ceil((double)fixelH / (1280.f / scale));
        thumbW = fixelW / multiple;
        thumbH = fixelH / multiple;
        size = ((thumbW * thumbH) / (1280.f * (1280.f / scale))) * 500.f;
        size = size < 100.f ? 100.f : size;
    }
    
    return [self compressWithImage:image thumbW:thumbW thumbH:thumbH
                              size:size watermarkName:markName];
}

+ (NSData *)lubanCompressImage:(UIImage *)image watermarkImage:(NSString *)imageName {
    
    if (imageName) {
        objc_setAssociatedObject(self, &isCustomImage, @(YES), OBJC_ASSOCIATION_COPY_NONATOMIC);
        objc_setAssociatedObject(self, &customImageName, imageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [self lubanCompressImage:image watermarkName:nil];
}

+ (NSData *)compressWithImage:(UIImage *)image thumbW:(int)width thumbH:(int)height
                         size:(double)size watermarkName:(NSString *)markName {
    
    UIImage *thumbImage = [image fixOrientation];
    thumbImage = [thumbImage resizeImage:image thumbW:width thumbH:height watermarkName:markName];
    
    CGFloat qualityCompress = 1.f;
    
    NSData *imageData = UIImageJPEGRepresentation(thumbImage, qualityCompress);
    
    while ((double)imageData.length / 1024.f > size && qualityCompress > 0.06f) {
        
        qualityCompress -= 0.06f;
        imageData  = UIImageJPEGRepresentation(thumbImage, qualityCompress);
        thumbImage = [UIImage imageWithData:imageData];
    }
    NSLog(@"Luban-iOS image data size after compressed == %f KB",
          (double)imageData.length / 1024.f);
    return imageData;
}

- (UIImage *)resizeImage:(UIImage *)image thumbW:(int)width thumbH:(int)height
           watermarkName:(NSString *)markName {
    
    int outW = (int)image.size.width;
    int outH = (int)image.size.height;
    
    int inSampleSize = 1;
    
    if (outW > width || outH > height) {
        int halfW = outW / 2;
        int halfH = outH / 2;
        
        while ((halfH / inSampleSize) > height && (halfW / inSampleSize) > width) {
            inSampleSize *= 2;
        }
    }
    int heightRatio = (int)ceil((double)outH / (double)height);
    int widthRatio  = (int)ceil((double)outW / (double)width);
    
    if (heightRatio > 1 || widthRatio > 1) {
        
        inSampleSize = heightRatio > widthRatio ? heightRatio : widthRatio;
    }
    CGSize thumbSize = CGSizeMake((CGFloat)((NSUInteger)((double)outW / (double)widthRatio)),
                                  (CGFloat)((NSUInteger)((double)outH / (double)heightRatio)));
    
    UIGraphicsBeginImageContext(thumbSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [image drawInRect:CGRectMake(0.f, 0.f, thumbSize.width, thumbSize.height)];
    if (markName) {
        
        CGContextTranslateCTM(context, thumbSize.width / 2.f, thumbSize.height / 2.f);
        CGContextScaleCTM(context, 1.f, -1.f);
        
        [self drawMaskWithString:markName context:context radius:0.f angle:0.f
                          colour:[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.5f]
                            font:[UIFont systemFontOfSize:38.f]
                      slantAngle:(CGFloat)(M_PI / 6.f)
                            size:thumbSize];
    }
    else if ([objc_getAssociatedObject(self, &isCustomImage) boolValue]) {
        NSString *imageName = objc_getAssociatedObject(self, &customImageName);
        UIImage *imageMask = [UIImage imageNamed:imageName];
        if (imageMask) {
            [imageMask drawInRect:CGRectMake(0.f, 0.f, thumbSize.width, thumbSize.height)];
        }
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    objc_setAssociatedObject(self, &isCustomImage, @(NO), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return resultImage;
}

- (UIImage *)fixOrientation {
    
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0.f);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0.f, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0.f);
            transform = CGAffineTransformScale(transform, -1.f, 1.f);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0.f);
            transform = CGAffineTransformScale(transform, -1.f, 1.f);
            break;
            
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0.f, 0.f, self.size.height, self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0.f, 0.f, self.size.width, self.size.height), self.CGImage);
            break;
    }
    
    CGImageRef CGImage = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:CGImage];
    CGContextRelease(ctx);
    CGImageRelease(CGImage);
    return image;
}

- (void)drawMaskWithString:(NSString *)str
                   context:(CGContextRef)context
                    radius:(CGFloat)radius
                     angle:(CGFloat)angle
                    colour:(UIColor *)colour
                      font:(UIFont *)font
                slantAngle:(CGFloat)slantAngle
                      size:(CGSize)size {
    // *******************************************************
    // This draws the String str centered at the position
    // specified by the polar coordinates (r, theta)
    // i.e. the x= r * cos(theta) y= r * sin(theta)
    // and rotated by the angle slantAngle
    // *******************************************************
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:colour,
                                            NSFontAttributeName:font};
    CGContextSaveGState(context);
    // Undo the inversion of the Y-axis (or the text goes backward!)
    CGContextScaleCTM(context, 1.f, -1.f);
    // Move the origin to the center of the text (negating the y-axis manually)
    CGContextTranslateCTM(context, radius * cos(angle), -(radius * sin(angle)));
    // Rotate the coordinate system.
    CGContextRotateCTM(context, -slantAngle);
    // Calculate the width of the text.
    CGSize offset = [str sizeWithAttributes:attributes];
    // Move the origin to the center of the text (negating the y-axis manually)
    CGContextTranslateCTM(context, -offset.width / 2.f, -offset.height / 2.f);
    
    NSInteger width  = (NSInteger)ceil(cos(slantAngle) * (double)offset.width);
    NSInteger height = (NSInteger)ceil(sin(slantAngle) * (double)offset.width);
    
    NSInteger row    = (NSInteger)(size.height / ((CGFloat)height + 100.f));
    NSInteger column = (NSInteger)(size.width / ((CGFloat)width + 100.f) > 6.f ? : 6.f);
    
    CGFloat xPoint = 0.f, yPoint = 0.f;
    
    for (NSInteger index = 0; index < row * column; index++) {
        
        xPoint = (CGFloat)(index % column) * ((CGFloat)width + 100.f) - screenWidth();
        yPoint = (CGFloat)(index / column) * ((CGFloat)height + 100.f);
        [str drawAtPoint:CGPointMake(xPoint, yPoint) withAttributes:attributes];
        xPoint += -screenWidth();
        yPoint += -screenHeight();
        [str drawAtPoint:CGPointMake(xPoint, yPoint) withAttributes:attributes];
    }
    
    CGContextRestoreGState(context);
}

@end
