//
//  UIImage+zipData.m
//  Luban-iOS
//
//  Created by 梁星国 on 2018/8/24.
//  Copyright © 2018年 guo. All rights reserved.
//

#import "UIImage+zipData.h"

@implementation UIImage (zipData)


/**
 以1280作参照图像尺寸压缩

 @param sourceImage 图片
 @return 压缩图片
 */
+(UIImage *)zipScaleWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280||height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280||height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280||height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
        //不缩放尺寸
    }
    //进行尺寸重绘
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 以1080作参照图像尺寸压缩
 
 @param sourceImage 图片
 @return 压缩图片
 */
+(UIImage *)zipScale_1080_WithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1080(宽高比不按照2来算，按照1来算)
    if (width>1080||height>1080) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1080;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1080;
            width = height*scale;
        }
        //2.宽大于1080高小于1080
    }else if(width>1080||height<1280){
        CGFloat scale = height/width;
        width = 1080;
        height = width*scale;
        //3.宽小于1080高大于1080
    }else if(width<1080||height>1080){
        CGFloat scale = width/height;
        height = 1080;
        width = height*scale;
        //4.宽高都小于1080
    }else{
        //不缩放尺寸
    }
    //进行尺寸重绘
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 自定义参照尺寸压缩

 @param sourceImage 图片
 @param accordingSize 参照尺寸
 @return 压缩图片
 */
+(UIImage *)zipScaleWithImage:(UIImage *)sourceImage accordingSize:(NSInteger )accordingSize{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于accordingSize(宽高比不按照2来算，按照1来算)
    if (width>accordingSize||height>accordingSize) {
        if (width>height) {
            CGFloat scale = height/width;
            width = accordingSize;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = accordingSize;
            width = height*scale;
        }
        //2.宽大于accordingSize高小于accordingSize
    }else if(width>accordingSize||height<accordingSize){
        CGFloat scale = height/width;
        width = accordingSize;
        height = width*scale;
        //3.宽小于accordingSize高大于accordingSize
    }else if(width<accordingSize||height>accordingSize){
        CGFloat scale = width/height;
        height = accordingSize;
        width = height*scale;
        //4.宽高都小于accordingSize
    }else{
        //不缩放尺寸
    }
    //进行尺寸重绘
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 普通图限制20M,极限设置19M,小于100KB不压缩
 @param sourceImage 图片
 @return 返回压缩图片
 */
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
   return [UIImage zipNSDataWithImage:sourceImage isOriginal:NO];
}


/**
 原图限制20M,极限设置19M,小于19M不压缩
 普通图限制20M,极限设置19M,小于100KB不压缩
 @param sourceImage 图片
 @param isOriginal 是否原图
 @return 返回压缩图片
 */
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage isOriginal:(BOOL)isOriginal{
    NSLog(@"输出发送图片原始大小 == %f Kb",UIImageJPEGRepresentation(sourceImage, 1.0).length/1024.0);
    //进行图像的画面质量压缩
    NSData *data = UIImageJPEGRepresentation(sourceImage, 1.0);
    if (isOriginal) {//原图
        if (data.length > 19*1024*1024) {//19M以上
            NSNumber * dataLength = [NSNumber numberWithInteger:data.length];
            NSNumber * limitLength = [NSNumber numberWithInteger:19*1024*1024];
            CGFloat scale =  [limitLength floatValue]/ [dataLength floatValue];
            scale = scale > 0.5 ? 0.5 : scale;
            data = UIImageJPEGRepresentation(sourceImage, scale);
        }else{
            //不压缩
        }
    }else{
        if (data.length > 19*1024*1024) {//19M以上
            NSNumber * dataLength = [NSNumber numberWithInteger:data.length];
            NSNumber * limitLength = [NSNumber numberWithInteger:19*1024*1024];
            CGFloat scale =  [limitLength floatValue]/ [dataLength floatValue];
            scale = scale > 0.3 ? 0.3 : scale;
            data = UIImageJPEGRepresentation(sourceImage, scale);
        }else if (data.length > 10*1024*1024){//10M<x<=19M
            data = UIImageJPEGRepresentation(sourceImage, 0.3);
        }else if (data.length > 1*1024*1024){//1M<x<=10M
            data = UIImageJPEGRepresentation(sourceImage, 0.7);
        }else if (data.length > 512*1024) {//0.5M<x<1M
            data = UIImageJPEGRepresentation(sourceImage, 0.8);
        }else if (data.length > 102*1024) {//0.1M-0.5M
            data = UIImageJPEGRepresentation(sourceImage, 0.9);
        }else{
            //不压缩
        }
    }
    
    NSLog(@"/***原图限制20M,极限设置19M,小于100KB不压缩输出图片大小 == %f Kb",data.length/1024.0);
    return data;
}

/**
 以1280作参照图像尺寸压缩,质量压缩

 @param sourceImage 图片
 @return 返回压缩结果
 */
+(NSData *)zipNSDataAndScaleWithImage:(UIImage *)sourceImage{
     NSLog(@"输出发送图片原始大小 == %f Kb",UIImageJPEGRepresentation(sourceImage, 1.0).length/1024.0);
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280||height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280||height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280||height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length > 19*1024*1024) {//19M以上
            NSNumber * dataLength = [NSNumber numberWithInteger:data.length];
            NSNumber * limitLength = [NSNumber numberWithInteger:19*1024*1024];
            CGFloat scale =  [limitLength floatValue]/ [dataLength floatValue];
            scale = scale > 0.3 ? 0.3 : scale;
            data = UIImageJPEGRepresentation(sourceImage, scale);
        }else if (data.length > 10*1024*1024){//10M<x<=19M
            data = UIImageJPEGRepresentation(sourceImage, 0.3);
        }else if (data.length > 1*1024*1024){//1M<x<=10M
            data = UIImageJPEGRepresentation(sourceImage, 0.7);
        }else if (data.length > 512*1024) {//0.5M<x<1M
            data = UIImageJPEGRepresentation(sourceImage, 0.8);
        }else if (data.length > 102*1024) {//0.1M-0.5M
            data = UIImageJPEGRepresentation(sourceImage, 0.9);
        }else{
            //不压缩
        }
    }
    NSLog(@"/***以1280作参照图像尺寸压缩,质量压缩输出图片大小 == %f Kb",data.length/1024.0);
    return data;
}


/**
 以1080作参照图像尺寸压缩,质量压缩
 
 @param sourceImage 图片
 @return 返回压缩结果
 */
+(NSData *)zip_1080_NSDataAndScaleWithImage:(UIImage *)sourceImage{
    NSLog(@"输出发送图片原始大小 == %f Kb",UIImageJPEGRepresentation(sourceImage, 1.0).length/1024.0);
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1080(宽高比不按照2来算，按照1来算)
    if (width>1080||height>1080) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1080;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1080;
            width = height*scale;
        }
        //2.宽大于1080高小于1080
    }else if(width>1080||height<1080){
        CGFloat scale = height/width;
        width = 1080;
        height = width*scale;
        //3.宽小于1080高大于1080
    }else if(width<1080||height>1080){
        CGFloat scale = width/height;
        height = 1080;
        width = height*scale;
        //4.宽高都小于1080
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length > 19*1024*1024) {//19M以上
            NSNumber * dataLength = [NSNumber numberWithInteger:data.length];
            NSNumber * limitLength = [NSNumber numberWithInteger:19*1024*1024];
            CGFloat scale =  [limitLength floatValue]/ [dataLength floatValue];
            scale = scale > 0.3 ? 0.3 : scale;
            data = UIImageJPEGRepresentation(sourceImage, scale);
        }else if (data.length > 10*1024*1024){//10M<x<=19M
            data = UIImageJPEGRepresentation(sourceImage, 0.3);
        }else if (data.length > 1*1024*1024){//1M<x<=10M
            data = UIImageJPEGRepresentation(sourceImage, 0.7);
        }else if (data.length > 512*1024) {//0.5M<x<1M
            data = UIImageJPEGRepresentation(sourceImage, 0.8);
        }else if (data.length > 102*1024) {//0.1M-0.5M
            data = UIImageJPEGRepresentation(sourceImage, 0.9);
        }else{
            //不压缩
        }
    }
    NSLog(@"/***以1280作参照图像尺寸压缩,质量压缩输出图片大小 == %f Kb",data.length/1024.0);
    return data;
}



@end
