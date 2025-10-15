//
//  NSArray+Safety.m
//  CNLive
//
//  Created by 雷浩杰 on 15/9/1.
//  Copyright (c) 2015年 雷浩杰. All rights reserved.
//

#import "NSArray+Safety.h"

@implementation NSArray (Safety)

- (nullable id)safetyObjectAtIndex:(NSUInteger)index
{
    if (!self || self.count == 0 || self.count <= index) {
        return nil;
    }
    
    return self[index];
}

- (nullable id)randomObject
{
    if (!self || ![self isKindOfClass:[NSArray class]] || self.count == 0) {
        return nil;
    }
    int i = arc4random()%self.count;
    return [self safetyObjectAtIndex:i];
}

+ (BOOL)isArray:(NSArray *)array
{
    if (array && [array isKindOfClass:[NSArray class]] && [array count]>0) {
        return YES;
    }
    
    return NO;
}

@end
