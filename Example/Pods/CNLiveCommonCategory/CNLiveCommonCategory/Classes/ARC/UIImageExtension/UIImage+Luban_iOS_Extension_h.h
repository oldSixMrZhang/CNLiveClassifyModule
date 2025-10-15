//
//  UIImage+Luban_iOS_Extension_h.h
//  Luban-iOS
//
//  Created by guo on 2017/7/20.
//  Copyright © 2017年 guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Luban_iOS_Extension_h)

+ (NSData *)lubanCompressImage:(UIImage *)image;//压缩图片
+ (NSData *)lubanCompressImage:(UIImage *)image withMask:(NSString *)maskName;//水印
+ (NSData *)lubanCompressImage:(UIImage *)image withCustomImage:(NSString *)imageName;//自定义名字压缩

@end
