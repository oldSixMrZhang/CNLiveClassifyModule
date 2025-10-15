//
//  UIFont+CNLiveExtension.m
//  CNLiveCommonCategory
//
//  Created by 张旭 on 2018/9/25.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import "UIFont+CNLiveExtension.h"
#import "CNFontAndRatioTool.h"

@implementation UIFont (CNLiveExtension)
+ (UIFont *)CNFontOfSize:(CGFloat)fontSize{
    NSInteger coefficient = [CNFontAndRatioTool getFontSizeCoefficient];
    switch (coefficient) {
        case 1:
            fontSize = fontSize*14/15;
            break;
        case 2:
            fontSize = fontSize*15/15;
            break;
        case 3:
            fontSize = fontSize*17/15;
            break;
        case 4:
            fontSize = fontSize*18/15;
            break;
        case 5:
            fontSize = fontSize*21/15;
            break;
        default:
            break;
    }
    //    float x = (coefficient-2)*2; //改变x 为(-2) -- (8)
    //    float x = 0.075*(coefficient-2)+1;
    return  [UIFont systemFontOfSize:fontSize];
    
    //    BOOL isLight = 1;
    //    BOOL isBold = 0;
    //    NSString *name = IOS_VERSION < 9.0 ? @"HelveticaNeue" : @".SFUIText";
    //    NSString *fontSuffix = [NSString stringWithFormat:@"%@%@", isLight ? @"Light" : (isBold ? @"Bold" : @""), italic ? @"Italic" : @""];
    //    NSString *fontName = [NSString stringWithFormat:@"%@%@%@", name, fontSuffix.length > 0 ? @"-" : @"", fontSuffix];
    //
    //
    //   return [UIFont fontWithName:fontName size:fontSize*x];
}
+ (UIFont *)CNBoldFontOfSize:(CGFloat)fontSize{
    NSInteger coefficient = [CNFontAndRatioTool getFontSizeCoefficient];
    switch (coefficient) {
        case 1:
            fontSize = fontSize*14/15;
            break;
        case 2:
            fontSize = fontSize*15/15;
            break;
        case 3:
            fontSize = fontSize*17/15;
            break;
        case 4:
            fontSize = fontSize*18/15;
            break;
        case 5:
            fontSize = fontSize*21/15;
            break;
        default:
            break;
    }
    //    float x = (coefficient-2)*2; //改变x 为(-2) -- (8)
    //    float x = 0.075*(coefficient-2)+1;
    return  [UIFont boldSystemFontOfSize:fontSize];
}
@end
