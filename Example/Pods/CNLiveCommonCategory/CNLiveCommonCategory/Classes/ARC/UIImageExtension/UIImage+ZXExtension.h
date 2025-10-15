//
//  UIImage+ZXExtension.h
//  
//
//  Created by mac on 16/8/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZXExtension)
@property (nonatomic, strong)NSData *imageData;
@property (nonatomic, copy)NSString *isGif;
/**
 * 返回一张圆形图片
 */
- (instancetype)zx_circleImage;

/**
 * 返回一张圆形图片
 */
+ (instancetype)zx_circleImageNamed:(NSString *)name;

/**
 生成指定颜色,大小,圆角的UIImage对象

 @param color 颜色
 @param size 大小
 @param cornerRadius 圆角
 @return 指定UIImage对象
 */
+ (UIImage *)cnlive_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
@end
