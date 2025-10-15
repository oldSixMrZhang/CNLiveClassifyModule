//
//  CNFontAndRatioTool.h
//  CNLiveNetAdd
//
//  Created by open on 2018/9/1.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNFontAndRatioTool : NSObject
//设置字体大小系数，1到6  2为默认标准
+(void)setFontSizeCoefficient:(NSInteger )coefficient;

//读取字体大小系数，1到6  2为默认标准
+(NSInteger )getFontSizeCoefficient;

//读取比例系数 (0.925~1.30)
+(float )getScaleCoefficient;
@end
