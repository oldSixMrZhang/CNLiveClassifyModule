//
//  UIImage+ZXExtension.m
//  
//
//  Created by mac on 16/8/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIImage+ZXExtension.h"
#import <objc/runtime.h>
#import "UIColor+CNLiveExtension.h"

@implementation UIImage (ZXExtension)
- (instancetype)zx_circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    
    // 往圆上面画一张图片
    [self drawInRect:rect];
    
    // 获得上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)zx_circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] zx_circleImage];
}

- (void)setIsGif:(NSString *)isGif
{
    SEL key = @selector(isGif);
    objc_setAssociatedObject(self, key, isGif, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}
- (NSString *)isGif
{
    return  objc_getAssociatedObject(self, _cmd);
}
- (void)setImageData:(NSData *)imageData
{
    SEL key = @selector(imageData);
    objc_setAssociatedObject(self, key, imageData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (NSData *)imageData
{
    return objc_getAssociatedObject(self, _cmd);
}

+ (UIImage *)cnlive_imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    //zx
    if (size.width < 0 || size.height < 0) {
        size = CGSizeMake(4, 4);
    }
    
    UIImage *resultImage = nil;
    color = color ? color : [UIColor clearColor];
    
    BOOL opaque = (cornerRadius == 0.0 && [color cnlive_alpha] == 1.0);
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    if (cornerRadius > 0) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
        [path addClip];
        [path fill];
    } else {
        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    }
    
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
@end
