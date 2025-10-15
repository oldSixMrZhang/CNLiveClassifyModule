//
//  BaseModel.m
//  ZXBaseProject
//
//  Created by 张旭 on 2017/1/10.
//  Copyright © 2017年 cnlive. All rights reserved.
//

#import "BaseModel.h"
#import <MJExtension/NSObject+MJKeyValue.h>

@implementation BaseModel

/** 字典初始化模型 dic -> models */
+ (id _Nullable)modelWithDic:(NSDictionary <NSString * , id>*_Nullable)dic
{
    return [[[self alloc] init] mj_setKeyValues:dic];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self loadModel];
    }
    return  self;
}

- (void)loadModel {}

@end
