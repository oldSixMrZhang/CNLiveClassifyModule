//
//  NSDictionary+Safety.m
//  CNLive
//
//  Created by 雷浩杰 on 15/9/1.
//  Copyright (c) 2015年 雷浩杰. All rights reserved.
//

#import "NSDictionary+Safety.h"

@implementation NSDictionary (Safety)

- (NSDictionary *)validatedDictionary {
    
    if (!self || ![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSDictionary *temp = (NSDictionary *)self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (temp) {
        id keys = [temp allKeys];
        
        for (id key in keys) {
            if (temp[key] || ![[temp objectForKey:key] isKindOfClass:[NSNull class]]) {
                
                if ([temp[key] isKindOfClass:[NSNumber class]]) {
                    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                    
                    NSString *str = [numberFormatter stringFromNumber:temp[key]];
                    [dic setObject:str forKey:key];
                }
                else {
                    [dic setObject:temp[key] forKey:key];
                }
            } else {
                [dic setObject:@"" forKey:key];
            }
        }
    }
    
    return dic;
}

//字典转json格式字符串：
+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
@end
