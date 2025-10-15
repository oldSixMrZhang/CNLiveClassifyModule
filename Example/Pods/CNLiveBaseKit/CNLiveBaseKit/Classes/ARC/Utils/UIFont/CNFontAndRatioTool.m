//
//  CNFontAndRatioTool.m
//  CNLiveNetAdd
//
//  Created by open on 2018/9/1.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import "CNFontAndRatioTool.h"

#define USERDEFAULT [NSUserDefaults standardUserDefaults]
#define FONT_COEFFICIENT @"CNSizeFontCoefficient"

@implementation CNFontAndRatioTool

+(void)setFontSizeCoefficient:(NSInteger )coefficient{
    [USERDEFAULT setInteger:coefficient forKey:FONT_COEFFICIENT];
}

+(NSInteger)getFontSizeCoefficient{
    NSInteger coefficient = [USERDEFAULT integerForKey:FONT_COEFFICIENT];
    if (coefficient==0) {//返回默认2
        return 2;
    }
    return  coefficient;
}

+(float )getScaleCoefficient{
    
    NSInteger coefficient =[CNFontAndRatioTool getFontSizeCoefficient];
    switch (coefficient) {
        case 1:
        {
            return 14.0/15.0;
        }
            break;
        case 2:
            return 15.0/15.0;
            break;
        case 3:
            return 17.0/15.0;
            break;
        case 4:
            return 18.0/15.0;
            break;
        case 5:
            return 21.0/15.0;
            break;
        default:
            return 15/15;
            break;
    }
}


@end
