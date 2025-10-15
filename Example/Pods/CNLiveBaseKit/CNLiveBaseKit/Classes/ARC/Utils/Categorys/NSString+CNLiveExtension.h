//
//  NSString+CNLiveExtension.h
//  CNLiveCommonCategory
//
//  Created by 张旭 on 2018/9/26.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import <Foundation/Foundation.h>

///判断是否为空字符串
#ifndef CNLiveStringIsEmpty
#define CNLiveStringIsEmpty(string) [NSString isEmpty:string]
#endif

///判断是否为空字符串当去除换行和空格后
#ifndef CNLiveStringTrimedIsEmpty
#define CNLiveStringTrimedIsEmpty(string) [NSString isEmptyByTrimStr:string]
#endif

///把格式化的JSON格式的字符串转换成字典
#ifndef CNLiveStringJsonToDictionary
#define CNLiveStringJsonToDictionary(jsonStr) [NSString jsonToDictionaryWithJson:jsonStr]
#endif

@interface NSString (CNLiveExtension)

#pragma mark -- 去除空处理
///判断是否为空字符串
+ (BOOL)isEmpty:(NSString *)string;
///判断是否为空字符串当去除换行和空格后
+ (BOOL)isEmptyByTrimStr:(NSString *)string;

///把格式化的JSON格式的字符串转换成字典
+ (NSDictionary *)jsonToDictionaryWithJson:(NSString *)jsonStr;

/** 去除字符串前后的空白,不包含换行符 */
- (NSString *)trim;

/** 当前字符串是否只包含空白字符和换行符 */
- (BOOL)isWhitespaceAndNewlines;

/** 去除字符串中所有空白 */
- (NSString *)removeWhiteSpace;

/** 去除字符串中所有换行 */
- (NSString *)removeNewLine;
#pragma mark --

#pragma mark --字符串格式化
/** 将字符串以URL格式编码 */
- (NSString *)stringByUrlEncoding;

/*!
 @brief     大写第一个字符
 @return    格式化后的字符串
 */
- (NSString *)capitalize;
#pragma mark -- 字符串首字母
/** 字符串首字母 */
-(NSString*)firstPinYin;
#pragma mark --

#pragma mark -- 字符串截取
/** 以给定字符串开始,忽略大小写 */
- (BOOL)startsWith:(NSString *)str;

/** 以指定条件判断字符串是否以给定字符串开始 */
- (BOOL)startsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

/** 以给定字符串结束，忽略大小写 */
- (BOOL)endsWith:(NSString *)str;

/** 以指定条件判断字符串是否以给定字符串结尾 */
- (BOOL)endsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

/** 包含给定的字符串, 忽略大小写 */
- (BOOL)containsString:(NSString *)str;

/** 以指定条件判断是否包含给定的字符串 */
- (BOOL)containsString:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

/** 判断字符串是否相同，忽略大小写 */
- (BOOL)equalsString:(NSString *)str;
#pragma mark --

#pragma mark -- emoji
/** 对emoji encode处理 */
- (NSString *)emjoiText;

/** 是否包含Emoji表情 */
- (BOOL)isContainsEmoji;
+ (BOOL)hasEmoji:(NSString*)string;

/** 去除Emoji表情 */
+ (NSString *)disable_emoji:(NSString *)text;

#pragma mark -- 计算一段文字的高度
/** 计算一段文字的高度*/
- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)font;
- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)font breakMode:(NSLineBreakMode)breakMode;
- (CGSize)textSizeIn:(CGSize)size font:(UIFont *)font breakMode:(NSLineBreakMode)breakMode align:(NSTextAlignment)alignment;

#pragma mark -- 字符串utf8后长度
/** 字符串utf8后长度 */
- (NSUInteger)utf8Length;

/** 递归计算符合规定的文本长度 */
- (NSString *)cutBeyondTextInLength:(NSInteger)maxLenth;
#pragma mark -- 是不是 url
/** 是不是 url */
- (BOOL)isValidUrl;
#pragma mark -- 截取字符串
/** 截取字符串 */
- (NSString *)substringAtRange:(NSRange)rang;
#pragma mark -- 比较两个版本是否一样
/**
 compare two version 比较两个版本是否一样
 @param sourVersion *.*.*.*
 @param desVersion *.*.*.*
 @returns No,sourVersion is less than desVersion; YES, the statue is opposed
 */
+(BOOL)compareVerison:(NSString *)sourVersion withDes:(NSString *)desVersion;
#pragma mark -- 解析html标签对应的值
/** 解析html标签对应的值 */
- (NSString *)valueOfLabel:(NSString *)label;

//+ (BOOL)isMobileNumber:(NSString *)mobileNum;
////正则 手机号码
//+ (BOOL)validateCellPhoneNumber:(NSString *)cellNum;
/// 将str加密成本地保存的文件名
+ (NSString *)md5String:(NSString *)str;
- (NSString *)md5;
///是否包含特殊字符
+ (BOOL)judgeTheillegalCharacter:(NSString *)content;
///对字符串进行encode
+ (NSString *)encodeToPercentEscapeString:(NSString *)input;
///base64Encoding
- (NSString *)base64Encoding;
///字符串空处理
+(NSString*)convertNull:(id)object;
//过滤未知字符
+ (NSString *)filterUnknownChara:(NSString *)text;
/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
+ (BOOL)isNineKeyBoard:(NSString *)string;
/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+ (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

@end
