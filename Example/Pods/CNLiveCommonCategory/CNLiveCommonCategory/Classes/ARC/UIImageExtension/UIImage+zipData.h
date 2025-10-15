//
//  UIImage+zipData.h
//  Luban-iOS
//
//  Created by 梁星国 on 2018/8/24.
//  Copyright © 2018年 guo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AppPhototLimitType) {
    AppPhototLimitTypeFriendsCircle = 0,//朋友圈图片限制20M
    AppPhototLimitTypeTarentoComment = 1,//达人评论图片限制10M
    AppPhototLimitTypeSweepCode = 2,//扫码图片限制10M
    AppPhototLimitTypeChat = 3,//聊天图片限制20M
};

@interface UIImage (zipData)


/**
 以1280作参照图像尺寸压缩
 
 @param sourceImage 图片
 @return 压缩图片
 */
+(UIImage *)zipScaleWithImage:(UIImage *)sourceImage;

/**
 以1080作参照图像尺寸压缩
 
 @param sourceImage 图片
 @return 压缩图片
 */
+(UIImage *)zipScale_1080_WithImage:(UIImage *)sourceImage;

/**
 自定义参照尺寸压缩
 
 @param sourceImage 图片
 @param accordingSize 参照尺寸
 @return 压缩图片
 */
+(UIImage *)zipScaleWithImage:(UIImage *)sourceImage accordingSize:(NSInteger )accordingSize;

/**
 普通图限制20M,极限设置19M,小于100KB不压缩
 @param sourceImage 图片
 @return 返回压缩图片
 */
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage;

/**
 原图限制20M,极限设置19M,小于19M不压缩
 普通图限制20M,极限设置19M,小于100KB不压缩
 @param sourceImage 图片
 @param isOriginal 是否原图
 @return 返回压缩图片
 */
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage isOriginal:(BOOL)isOriginal;

/**
 以1280作参照图像尺寸压缩,质量压缩
 
 @param sourceImage 图片
 @return 返回压缩结果
 */
+(NSData *)zipNSDataAndScaleWithImage:(UIImage *)sourceImage;

/**
 以1080作参照图像尺寸压缩,质量压缩
 
 @param sourceImage 图片
 @return 返回压缩结果
 */
+(NSData *)zip_1080_NSDataAndScaleWithImage:(UIImage *)sourceImage;



@end
