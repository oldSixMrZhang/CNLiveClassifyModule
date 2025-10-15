//
//  UIImage+Bundle.m
//  Test
//
//  Created by CNLive-zxw on 2019/4/23.
//  Copyright © 2019 CNLive. All rights reserved.
//

#import "UIImage+Bundle.h"

@implementation UIImage (Bundle)
/**
 *  创建图片
 *
 *  @param name 图片名字
 *  @param bundleName 图片所在的bundle名字
 *  @param targetClass 类和bundle的同级目录
 *  @return 返回UIImage
 */
+ (instancetype)cnLive_imgWithName:(NSString *)name bundle:(NSString *)bundleName targetClass:(Class)targetClass{
    NSInteger scale = [[UIScreen mainScreen] scale];
    NSBundle *curB = [NSBundle bundleForClass:targetClass];
    NSString *imgName = [NSString stringWithFormat:@"%@@%zdx.png", name,scale];
    NSString *dir = [NSString stringWithFormat:@"%@.bundle",bundleName];
    NSString *path = [curB pathForResource:imgName ofType:nil inDirectory:dir];
    return path?[UIImage imageWithContentsOfFile:path]:nil;
}

/**
 *  创建图片
 *
 *  @param imageName 图片名字
 *  @param bundlePath 图片所在的bundle名字
 *  @param targetClass 类和bundle的同级目录
 *  @return 返回UIImage
 */
+ (instancetype)cnLive_getImageName:(NSString *)imageName bundle:(NSString *)bundlePath targetClass:(Class)targetClass{
    NSBundle *bundle = [NSBundle bundleForClass:targetClass];
    NSURL *url = [bundle URLForResource:bundlePath withExtension:@"bundle"];
    NSBundle *targetBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [UIImage imageNamed:imageName inBundle:targetBundle compatibleWithTraitCollection:nil];
    return image?image:[UIImage imageNamed:imageName inBundle:[NSBundle mainBundle] compatibleWithTraitCollection:nil];
    
}

@end
