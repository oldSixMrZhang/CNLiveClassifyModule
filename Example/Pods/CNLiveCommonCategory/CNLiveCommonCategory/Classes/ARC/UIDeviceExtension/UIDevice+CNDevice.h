//
//  UIDevice+CNDevice.h
//  CNLiveNetAdd
//
//  Created by 流诗语 on 2018/4/23.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (CNDevice)
/**
 * @interfaceOrientation 输入要强制转屏的方向
 */
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
