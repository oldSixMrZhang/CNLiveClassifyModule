//
//  UIFont+CNLiveExtension.h
//  CNLiveCommonCategory
//
//  Created by 张旭 on 2018/9/25.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (CNLiveExtension)

/**
 *  返回APP设置字体的大小
 *
 *  @param fontSize 字体大小
 *
 *  @return 改变的字体的 UIFont 对象
 */
+ (UIFont *)CNFontOfSize:(CGFloat)fontSize;

/**
 *  返回APP设置粗体字体的大小
 *
 *  @param fontSize 字体大小
 *
 *  @return 改变的粗体字体的 UIFont 对象
 */
+ (UIFont *)CNBoldFontOfSize:(CGFloat)fontSize;

@end
