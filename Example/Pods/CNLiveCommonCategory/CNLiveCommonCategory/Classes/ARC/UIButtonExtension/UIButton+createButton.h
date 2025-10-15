//
//  UIButton+createButton.h
//  WonderfulLive
//
//  Created by 张旭 on 2016/11/30.
//  Copyright © 2016年 CNLive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (createButton)

#pragma mark - public method

/**
 创建UIButton,文字及其颜色,字体字号
 
 @param title 文字
 @param titleColor 文字颜色
 @param labelFontSize 字体字号
 @return 自定义的UIButton
 */
+ (UIButton * _Nullable)buttonWithTitle:(NSString * _Nullable)title titleColor:(UIColor * _Nullable)titleColor labelFontSize:(CGFloat)labelFontSize;
/**
 设置热区
 */
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;

/**
 扩大点击范围

 @param top top
 @param right right
 @param bottom bottom
 @param left left
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

/**
 * 倒计时结束的回调
 */
@property (nonatomic, copy) void(^buttonTimeStoppedCallback)(void);

/**
 设置倒计时的间隔和倒计时文案
 
 @param duration 倒计时时间
 @param format 可选，传nil默认为 @"%zd秒"
 */
- (void)CountDownWithTimeInterval:(NSTimeInterval)duration
                  countDownFormat:(NSString *)format;

/**
 * invalidate timer
 */
- (void)cancelTimer;
/**开始菊花框*/
- (void)startButtonActivityIndicatorView:(UIActivityIndicatorViewStyle)style;

/**停止菊花框旋转,内容需要重新赋值*/
- (void)endButtonActivityIndicatorView;
@end

