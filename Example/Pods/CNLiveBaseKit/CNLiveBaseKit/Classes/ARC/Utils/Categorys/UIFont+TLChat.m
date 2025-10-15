//
//  UIFont+TLChat.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "UIFont+TLChat.h"
#import "CNLiveBaseKit.h"

@implementation UIFont (TLChat)

+ (UIFont *) fontNavBarTitle
{
    return [UIFont boldSystemFontOfSize:17.5f];
}

+ (UIFont *) fontConversationUsername
{
    return UIFontCNMake(17.0f);
}

+ (UIFont *) fontConversationDetail
{
    return UIFontCNMake(14.0f);
}

+ (UIFont *) fontConversationTime
{
    return UIFontCNMake(12.5f);
}

+ (UIFont *) fontFriendsUsername
{
    return UIFontCNMake(17.0f);
}

+ (UIFont *) fontMineNikename
{
    return UIFontCNMake(17.0f);
}

+ (UIFont *) fontMineUsername
{
    return UIFontCNMake(14.0f);
}

+ (UIFont *) fontSettingHeaderAndFooterTitle
{
    return UIFontCNMake(14.0f);
}

+ (UIFont *)fontTextMessageText
{
    CGFloat size = [[NSUserDefaults standardUserDefaults] doubleForKey:@"CHAT_FONT_SIZE"];
    if (size == 0) {
        size = 16.0f;
    }
    return UIFontCNMake(size);
}

@end
