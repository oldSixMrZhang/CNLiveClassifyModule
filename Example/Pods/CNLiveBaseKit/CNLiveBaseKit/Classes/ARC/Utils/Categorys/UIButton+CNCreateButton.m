//
//  UIButton+CNCreateButton.m
//  CNLiveNetAdd
//
//  Created by cnliveJunBo on 2018/5/30.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import "UIButton+CNCreateButton.h"
#import "UIFont+CNLiveExtension.h"
#import "CNLiveBaseKit.h"

@implementation UIButton (CNCreateButton)

+ (instancetype)jb_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    UIButton *button = [[self alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    button.titleLabel.font = UIFontCNMake(fontSize);
    [button sizeToFit];
    
    return button;
}

@end
