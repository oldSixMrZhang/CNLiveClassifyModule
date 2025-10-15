//
//  UIButton+CNCreateButton.h
//  CNLiveNetAdd
//
//  Created by cnliveJunBo on 2018/5/30.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CNCreateButton)

+ (instancetype)jb_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;

@end
