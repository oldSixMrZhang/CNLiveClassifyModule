//
//  UIView+CNAlertView.h
//  CNLiveNetAdd
//
//  Created by 流诗语 on 2018/3/20.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CNAlertBlock)(UIButton * button,NSInteger didRow);

@interface UIView (CNAlertView)
@property (nonatomic, weak)UIButton *cancelBtn;
/**
 文字弹出框

 @param array 文字数组
 @param color 文字颜色
 @param font 文字大小
 @param actionBlock 点击方法返回
 */
-(void)createAlertViewTitleArray:(NSArray* )array textColor:(id )color font:(UIFont*)font actionBlock:(CNAlertBlock)actionBlock;
/**
 文字弹出框，用于自定义文字颜色 和 大小
 @param array 文字数组
 @param colorArray 文字颜色数组
 @param fontArray 文字大小数组
 @param actionBlock 点击方法返回
 */
- (void)createAlertViewTitleArray:(NSArray* )array textColorArray:(NSArray<UIColor*>*)colorArray font:(NSArray <UIFont *>*)fontArray actionBlock:(CNAlertBlock)actionBlock ;
/**
 底部弹出框视图

 @param array 主标题arr
 @param subTitleArr 子标题arr
 @param color 主标题颜色
 @param subTitleColor 子标题颜色
 @param font 主标题字体
 @param subFont 子标题字体
 @param actionBlock 点击回调
 */
- (void)createAlertViewTitleArray:(NSArray <NSString *>* )array subTitleArr:(NSArray <NSString *>*)subTitleArr textColor:(id)color subTitleColor:(id)subTitleColor font:(UIFont*)font subFont:(UIFont *)subFont actionBlock:(CNAlertBlock)actionBlock;

- (void)createAlertViewTitleArray:(NSArray <NSString *>* )array subTitleArr:(NSArray <NSString *>*)subTitleArr textColor:(id)color subTitleColor:(id)subTitleColor firstFont:(UIFont *)firstFont font:(UIFont*)font subFont:(UIFont *)subFont cancelTitle:(NSString *)cancelTitle cancelFont:(UIFont *)cancelFont cancelTitleColor:(UIColor *)cancelTitleColor actionBlock:(CNAlertBlock)actionBlock;

/**
 隐藏界面展示
 */
-(void)didMiss;
@end
