//
//  UIImage+CNLiveAdd.h
//  CNLiveCommonCategory
//
//  Created by 张旭 on 2018/10/12.
//  Copyright © 2018年 cnlive. All rights reserved.
//


#import <UIKit/UIKit.h>

//颜色转背景图片
#ifndef CNLiveUIImageWithColor
#define CNLiveUIImageWithColor(color) [UIImage imageWithColor:color]
#endif
NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CNLiveAdd)

/**
 重新设置size
 
 @param size 目标size
 @return 目标size的UIImage对象
 */
- (UIImage *)cnlive_imageByResizeToSize:(CGSize)size;

//颜色转背景图片
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
