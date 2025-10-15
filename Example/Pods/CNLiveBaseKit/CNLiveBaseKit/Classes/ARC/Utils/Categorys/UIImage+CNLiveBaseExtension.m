//
//  UIImage+CNLiveBaseExtension.m
//  CNLiveBaseKit
//
//  Created by 张旭 on 2018/12/13.
//

#import "UIImage+CNLiveBaseExtension.h"
#import "PathHeaders.h"
#import "UIColor+MLPFlatColors.h"
#import "CNLiveBaseKit.h"

@implementation UIImage (CNLiveBaseExtension)

- (void)saveToCacheWithKey:(NSString *)key
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *tmpPath = [PathUtility imageCachePath];
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@", tmpPath, [key md5]];

        NSData *data = nil;
        if (UIImagePNGRepresentation(self) == nil)
        {
            data = UIImageJPEGRepresentation(self, 1);
        }
        else
        {
            data = UIImagePNGRepresentation(self);
        }
        [data writeToFile:imagePath atomically:YES];
    });
}

+ (UIImage *)loadFromCacheWithKey:(NSString *)key
{
    NSString *tmpPath = [PathUtility imageCachePath];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", tmpPath, [key md5]];
    return [UIImage imageWithContentsOfFile:imagePath];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (color == nil) {
        return nil;
    }
    
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)randomColorImageWith:(CGSize)size
{
    UIColor *randomColor = [UIColor randomFlatColor];
    return [UIImage imageWithColor:randomColor size:size];
}

@end
