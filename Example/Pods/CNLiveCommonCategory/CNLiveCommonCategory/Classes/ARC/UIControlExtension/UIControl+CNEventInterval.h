//
//  UIControl+CNEventInterval.h
//  CNLiveNetAdd
//
//  Created by 流诗语 on 2018/4/18.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (CNEventInterval)
@property (nonatomic, assign) NSTimeInterval cs_acceptEventInterval; // 重复点击的间隔

@property (nonatomic, assign) NSTimeInterval cs_acceptEventTime;
@end
