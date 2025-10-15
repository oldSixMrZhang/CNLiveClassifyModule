//
//  UIColor+CNLiveExtension.h
//  CNLiveCommonCategory
//
//  Created by 张旭 on 2018/9/27.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>
//十六进制颜色
#ifndef CNLiveColorWithHexString
#define CNLiveColorWithHexString(string) [UIColor cnlive_colorWithHexString:string]
#endif

//十六进制颜色及alpha
#ifndef CNLiveColorWithHexStringAlpha
#define CNLiveColorWithHexStringAlpha(string,alpha) [UIColor cnlive_colorWithHexString:string andAlpha:alpha]
#endif
@interface UIColor (CNLiveExtension)

- (CGFloat)cnlive_alpha;

//十六进制颜色
+ (UIColor *)cnlive_colorWithHexString:(NSString *)color;

//十六进制颜色,alpha
+ (UIColor *)cnlive_colorWithHexString:(NSString *)color andAlpha:(CGFloat )alpha;
@end
