//
//  UIImage+Bundle.h
//  Test
//
//  Created by CNLive-zxw on 2019/4/23.
//  Copyright © 2019 CNLive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Bundle)
/*
 * 使用: 在组件中使用显示图片
 * _imgView.image = [UIImage xw_imgWithName:@"图片名字" bundle:@"图片所在的bundle名字" targetClass:[self class]];
 */
/**
 *  创建图片
 *
 *  @param name 图片名字
 *  @param bundleName 图片所在的bundle名字
 *  @param targetClass 类和bundle的同级目录
 *  @return 返回UIImage
 */
+ (instancetype)cnLive__imgWithName:(NSString *)name bundle:(NSString *)bundleName targetClass:(Class)targetClass;

/**
 *  创建图片
 *
 *  @param imageName 图片名字
 *  @param bundlePath 图片所在的bundle路径
 *  @param targetClass 类和bundle的同级目录
 *  @return 返回UIImage
 */
+ (instancetype)cnLive__getImageName:(NSString *)imageName bundle:(NSString *)bundlePath targetClass:(Class)targetClass;

@end

NS_ASSUME_NONNULL_END
