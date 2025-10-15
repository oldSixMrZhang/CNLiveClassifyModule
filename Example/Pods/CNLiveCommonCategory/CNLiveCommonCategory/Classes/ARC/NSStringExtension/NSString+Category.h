//
//  NSString+Category.h
//  CNLiveCommonCategory
//
//  Created by 张旭 on 2018/12/7.
//

#import <Foundation/Foundation.h>
//获取字符串首字母(传入汉字字符串, 返回大写拼音首字母)
#ifndef CNLiveStringGetFirstLetter
#define CNLiveStringGetFirstLetter(string) [string getFirstLetterFromString]
#endif

//正则表达式验证手机号
#ifndef CNLiveStringIsMobileNumber
#define CNLiveStringIsMobileNumber(string) [string isMobileNumber]
#endif

//读取本地JSON文件
#ifndef CNLiveStringReadLocalJSONFile
#define CNLiveStringReadLocalJSONFile(string) [string readLocalFile]
#endif

//获取汉字转成拼音字符串 通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字
#ifndef CNLiveStringTransformToPinyin
#define CNLiveStringTransformToPinyin(string) [string transformToPinyin]
#endif

//判断是否为纯数字
#ifndef CNLiveStringIsNumber
#define CNLiveStringIsNumber(string) [NSString isNum:string]
#endif

#ifndef CNLiveStringSpecialSpaceCharactCers
#define CNLiveStringSpecialSpaceCharactCers [NSString getSpecialSpaceCharactCerS]
#endif

#ifndef CNLiveStringgetLocalAppVersion
#define CNLiveStringgetLocalAppVersion [NSString getLocalAppVersion]
#endif
#ifndef CNLiveStringgetLocalAppBuildVersion
#define CNLiveStringgetLocalAppBuildVersion [NSString getLocalAppBuildVersion]
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Category)

//获取字符串首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)getFirstLetterFromString;

//正则表达式验证手机号
- (BOOL)isMobileNumber;

//读取本地JSON文件
- (id)readLocalFile;

//获取汉字转成拼音字符串 通讯录模糊搜索 支持拼音检索 首字母 全拼 汉字
- (NSString *)transformToPinyin;

//获取文件大大小
- (float)fileSizeAtPath;

/** 判断是否为纯数字 */
+ (BOOL)isNum:(NSString *)checkedNumString;

// 获取特殊空白字符
+ (NSString *)getSpecialSpaceCharactCerS;
//获取 bundle version短版本号
+ (NSString*)getLocalAppVersion;
// 获取 build version长版本号
+ (NSString*)getLocalAppBuildVersion;
@end

NS_ASSUME_NONNULL_END
