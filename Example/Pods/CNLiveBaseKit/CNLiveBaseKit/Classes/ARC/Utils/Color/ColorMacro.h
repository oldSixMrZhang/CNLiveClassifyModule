//
//  ColorMarcro.h
//  CommonLibrary
//
//  Created by Alexi on 13-10-23.
//  Copyright (c) 2013年 ywchen. All rights reserved.
//

#ifndef CommonLibrary_ColorMarcro_h
#define CommonLibrary_ColorMarcro_h

#import "UIColor+MLPFlatColors.h"


#pragma mark -- 取色值相关的方法 透明度1
#ifndef RGB
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
                                            green:(g)/255.f \
                                             blue:(b)/255.f \
                                            alpha:1.f]
#endif
#pragma mark -- 取色值相关的方法 透明度自定义
#ifndef RGBA
#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.f \
                                            green:(g)/255.f \
                                             blue:(b)/255.f \
                                            alpha:(a)]
#endif

#pragma mark -- 十六进制
#define RGBOF(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                            green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                             blue:((float)(rgbValue & 0xFF))/255.0 \
                                            alpha:1.0]

#define RGBA_OF(rgbValue)   [UIColor colorWithRed:((float)(((rgbValue) & 0xFF000000) >> 24))/255.0 \
                                             green:((float)(((rgbValue) & 0x00FF0000) >> 16))/255.0 \
                                              blue:((float)(rgbValue & 0x0000FF00) >> 8)/255.0 \
                                             alpha:((float)(rgbValue & 0x000000FF))/255.0]

#define RGBAOF(v, a)        [UIColor colorWithRed:((float)(((v) & 0xFF0000) >> 16))/255.0 \
                                            green:((float)(((v) & 0x00FF00) >> 8))/255.0 \
                                             blue:((float)(v & 0x0000FF))/255.0 \
                                            alpha:a]


// 定义通用颜色
#define kBlackColor         [UIColor blackColor]
#define kDarkGrayColor      [UIColor darkGrayColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kWhiteColor         [UIColor whiteColor]
#define kGrayColor          [UIColor grayColor]
#define kRedColor           [UIColor redColor]
#define kGreenColor         [UIColor greenColor]
#define kBlueColor          [UIColor blueColor]
#define kCyanColor          [UIColor cyanColor]
#define kYellowColor        [UIColor yellowColor]
#define kMagentaColor       [UIColor magentaColor]
#define kOrangeColor        [UIColor orangeColor]
#define kPurpleColor        [UIColor purpleColor]
#define kClearColor         [UIColor clearColor]

#define kWeChatBgColor      RGB(242,242,242)
#define kTempBlueColor      RGB(85,198,242)

#define kRandomFlatColor    [UIColor randomFlatColor]

//文字颜色
#define KTextBlackColor     RGB(40, 40, 40)
#define KBlack51Color       RGB(51, 51, 51)
#define KYellowColor        RGB(255, 163, 0)
#define KYellowHightColor   RGB(179, 105, 27)
#define KUserInfoGrayColor  RGB(101, 101, 101)
#define KGrayBgColor        RGB(242, 242, 242)
#define KGray246BgColor     RGB(246, 246, 246)
#define KSubTitleGrayColor  RGB(152, 152, 152)
#define KGray195Color       RGB(195, 195, 195)
#define KYellow153Color     RGB(255, 153, 0)
#define KGray235Color       RGB(235, 235, 235)
#define KGray102Color       RGB(102, 102, 102)
#define KGray101Color       RGB(101, 101, 101)
#define KGray153Color       RGB(153, 153, 153)
#define KGray187Color       RGB(187, 187, 187)
#define KGray173Color       RGB(173, 173, 173)
#define KGrayLineColor      RGB(243, 244, 245)
#define KOrderButtonGrayColor    RGB(88, 92, 94)
#define KOrderRedColor      RGB(255, 51, 85)
#define KGray227Color       RGB(227, 227, 227)
#define KGray242Color       RGB(242, 242, 242)
#define KGreen194Color       RGB(0, 194, 0)
#define KOrange163Color       RGB(255, 163, 0)

#define KCommonLineColor    RGB(238, 238, 238)
#define KCopyLabelBgColor   RGBOF(0x4bd647)//RGB(216, 136, 0)
#define KGreenColor         @"00c200"//绿色
#define KGrayColor          @"626775"

#endif
