//
//  NSDictionary+Safety.h
//  CNLive
//
//  Created by 雷浩杰 on 15/9/1.
//  Copyright (c) 2015年 雷浩杰. All rights reserved.
//

#import <Foundation/Foundation.h>
//字典转json格式字符串
#ifndef CNLiveNSDictionaryDicToJson
#define CNLiveNSDictionaryDicToJson(dic) [NSDictionary dictionaryToJson:dic]
#endif
@interface NSDictionary (Safety)

- (NSDictionary *)validatedDictionary;

//字典转json格式字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

@end
