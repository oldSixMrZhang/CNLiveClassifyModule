//
//  UITableView+Hit.m
//  CNLiveNetAdd
//
//  Created by iOS on 2018/1/22.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import "UITableView+Hit.h"

@implementation UITableView (Hit)

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    id view = [super hitTest:point withEvent:event];
    if ([view isKindOfClass:[UITextField class]] || [[view superview] isKindOfClass:[UITextField class]]) {
        return view;
    }
    else if (![view isKindOfClass:[UITableView class]]) {
        if ([view isKindOfClass:[UITextView class]]) {
            return view;
        }
        else if ([NSStringFromClass([view class]) isEqualToString:@"UITextRangeView"])
        {
            //YYTextContainerView
            return view;
        }
        else
        {
            [self endEditing:YES];
            return view;
        }
        
    }
    else {
        [self endEditing:YES];
        return self;
    }
}

@end
