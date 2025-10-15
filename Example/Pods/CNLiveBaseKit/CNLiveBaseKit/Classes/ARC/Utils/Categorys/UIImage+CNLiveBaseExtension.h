//
//  UIImage+CNLiveBaseExtension.h
//  CNLiveBaseKit
//
//  Created by 张旭 on 2018/12/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CNLiveBaseExtension)

- (void)saveToCacheWithKey:(NSString *)key;

+ (UIImage *)loadFromCacheWithKey:(NSString *)key;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)randomColorImageWith:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
