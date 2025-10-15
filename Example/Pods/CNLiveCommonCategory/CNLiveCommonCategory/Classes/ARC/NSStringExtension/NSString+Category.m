//
//  NSString+Category.m
//  CNLiveCommonCategory
//
//  Created by 张旭 on 2018/12/7.
//

#import "NSString+Category.h"

@implementation NSString (Category)

//获取字符串首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)getFirstLetterFromString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *strPinYin = [str capitalizedString];
    
    //获取并返回首字母
    NSString *retStr = [strPinYin substringToIndex:1];
    
    if ([retStr characterAtIndex:0] >= 'A' && [retStr characterAtIndex:0] <= 'Z') {
        return retStr;
    } else {
        return @"#";
    }
}

//正则表达式验证手机号
- (BOOL)isMobileNumber
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (id)readLocalFile {
    NSString *path = [[NSBundle mainBundle] pathForResource:self ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (data == nil)return nil;
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (NSString *)transformToPinyin {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    int count = 0;
    for (int  i = 0; i < pinyinArray.count; i++)
    {
        for(int i = 0; i < pinyinArray.count;i++)
        {
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
        }
        [allString appendString:@","];
        count ++;
    }
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    for (NSString *s in pinyinArray)
    {
        if (s.length > 0)
        {
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",self];
    return allString;
}

//获取文件大大小
- (float)fileSizeAtPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExists = [fileManager fileExistsAtPath:self];
    if (!isExists) {
        return  0.0;
    }
    NSDictionary *attributesDic = [fileManager attributesOfItemAtPath:self error:nil];
    if (attributesDic) {
        return [attributesDic[NSFileSize] floatValue];
    }else {
        return 0.0;
    }
}

/** 判断是否为纯数字 */
+ (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

#pragma mark 获取特殊空白字符
+ (NSString *)getSpecialSpaceCharactCerS{
    int asciiCode = 8197;
    NSString *string1 = [NSString stringWithFormat:@"%C", (unichar)asciiCode];
    return string1;
}

#pragma mark - 获取 bundle version短版本号
+ (NSString*)getLocalAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark -获取 build version长版本号
+ (NSString*)getLocalAppBuildVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];//@"1.3.5.18.07.25.30";//
}
@end
