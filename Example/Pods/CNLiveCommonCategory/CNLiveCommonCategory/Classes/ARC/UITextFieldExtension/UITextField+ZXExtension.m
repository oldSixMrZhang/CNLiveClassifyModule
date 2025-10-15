//
//  UITextField+ZXExtension.m
//  
//
//  Created by mac on 16/8/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UITextField+ZXExtension.h"
/** 占位文字颜色 */
static NSString * const ZXPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (ZXExtension)


-(void)setZx_placeholderColor:(UIColor *)zx_placeholderColor
{
    //提前创建placeholderLabel

    NSString *placeholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = placeholder;
    //恢复默认占位颜色
    if (zx_placeholderColor) {
        zx_placeholderColor = zx_placeholderColor;//[UIColor whiteColor];//[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    } else {
        zx_placeholderColor = [UIColor whiteColor];
    }
    
    [self setValue:zx_placeholderColor forKeyPath:ZXPlaceholderColorKey ];
}

- (UIColor *)zx_placeholderColor
{
    return [self valueForKeyPath:ZXPlaceholderColorKey];
}
@end
