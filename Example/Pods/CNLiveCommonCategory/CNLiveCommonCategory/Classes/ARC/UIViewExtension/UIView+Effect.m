//
//  UIView+Effect.m
//  CommonLibrary
//
//  Created by AlexiChen on 15/12/24.
//  Copyright © 2015年 AlexiChen. All rights reserved.
//
#import "UIView+Effect.h"
#import "UIImage+ImageEffect.h"

#import "UIImage+Common.h"

@implementation UIView (Effect)

- (void)blurWithColor:(UIColor *)color
{
    UIImage *image = [UIImage imageWithColor:color size:CGSizeMake(32, 32)];
    [self blurWithImage:image];
}

// 底层自动blur image
- (void)blurWithImage:(UIImage *)image
{
    UIImage *blurimg = [image applyLightEffect];
    
    UIImageView *effectView = [[UIImageView alloc] init];
    effectView.image = blurimg;
    effectView.autoresizesSubviews = YES;
    effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self insertSubview:effectView atIndex:0];
}

@end
