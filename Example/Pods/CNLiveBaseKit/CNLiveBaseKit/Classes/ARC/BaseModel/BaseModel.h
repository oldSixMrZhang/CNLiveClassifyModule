//
//  BaseModel.h
//  ZXBaseProject
//
//  Created by 张旭 on 2017/1/10.
//  Copyright © 2017年 cnlive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

/** 字典初始化模型 dic -> model */
+ (id _Nullable)modelWithDic:(NSDictionary <NSString * , id>*_Nullable)dic;

/**
 子类重写
 */
- (void)loadModel; // init时调用
@end
