//
//  UIImageView+ZXExtension.h
//
//
//  Created by mac on 16/8/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (ZXExtension)
- (void)zx_setHeader:(NSString *)url;

- (void)zx_setRectHeader:(NSString *)url;

//获取图片某一点的颜色 ,设置完图片后获取
- (UIColor *)colorAtPixel:(CGPoint)point;

- (UIColor *)getPixelColorAtLocation:(CGPoint)point;
@end
