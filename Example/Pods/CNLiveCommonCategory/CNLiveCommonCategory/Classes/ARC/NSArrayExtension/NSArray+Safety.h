//
//  NSArray+Safety.h
//  CNLive
//
//  Created by 雷浩杰 on 15/9/1.
//  Copyright (c) 2015年 雷浩杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Safety)

- (nullable id)safetyObjectAtIndex:(NSUInteger)index;

- (nullable id)randomObject;

+ (BOOL)isArray:(NSArray *)array;

@end
