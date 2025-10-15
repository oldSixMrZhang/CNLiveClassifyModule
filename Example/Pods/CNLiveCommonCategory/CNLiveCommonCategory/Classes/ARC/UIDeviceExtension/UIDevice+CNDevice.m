//
//  UIDevice+CNDevice.m
//  CNLiveNetAdd
//
//  Created by 流诗语 on 2018/4/23.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import "UIDevice+CNDevice.h"

@implementation UIDevice (CNDevice)

+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];
    
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
}
@end
