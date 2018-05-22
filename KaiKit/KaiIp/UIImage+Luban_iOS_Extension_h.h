//
//  UIImage+Luban_iOS_Extension_h.h
//  Luban-iOS
//
//  Created by guo on 2017/7/20.
//  Copyright © 2017年 guo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Luban_iOS_Extension_h)

+ (NSData *)lubanCompressImage:(UIImage *)image;
+ (NSData *)lubanCompressImage:(UIImage *)image
                 watermarkName:(nullable NSString *)markName;
+ (NSData *)lubanCompressImage:(UIImage *)image
                watermarkImage:(nullable NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
