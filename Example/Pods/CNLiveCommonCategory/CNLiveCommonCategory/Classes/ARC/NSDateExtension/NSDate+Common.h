//
//  NSDate+Common.h
//  TIMChat
//
//  Created by AlexiChen on 16/3/16.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Common)

- (BOOL)isToday;

- (BOOL)isYesterday;

- (NSString *)shortTimeTextOfDate;

- (NSString *)shortTimeForLiveTextOfDate;

- (NSString *)timeTextOfDate;


+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)string;
+ (NSTimeInterval)pleaseInsertStarTime:(NSString *)starTime andInsertEndTime:(NSString *)endTime;

/** 取得月-日 时:分 */
+ (NSString *)dateStrFromInt:(NSInteger)count;

+ (double)getDateTimeSeconds:(NSDate *)date;
/*** 毫秒 ***/
+ (double)getDateTimeSecondsMS:(NSDate *)date;


@end
