//
//  UIButton+createButton.m
//  WonderfulLive
//
//  Created by 张旭 on 2016/11/30.
//  Copyright © 2016年 CNLive. All rights reserved.
//

#import "UIButton+createButton.h"
#import <objc/runtime.h>
#define DefaultSystemFontSize 15.f
#define DefaultTextAlignment NSTextAlignmentCenter
#define DefaultBackgroundColor [UIColor clearColor]
#define DefaultBackgroundImageNormal nil
#define DefaultBackgroundImageSelected nil
#define DefaultBackgroundImageHighlight nil
#define DefaultCornerRadius 0
#define DefaultBorderWidth 0
#define DefaultBorderColor nil
static NSUInteger const indicatorViewTag  = 9999;
static NSString * const ktimer = @"timer";
static NSString * const kleaveTime = @"leaveTime";
static NSString * const kcountDownFormat = @"countDownFormat";
static NSString * const kButtonTimeStoppedCallback = @"buttonTimeStoppedCallback";
static NSString * const knormalTitle = @"normalTitle";

@interface UIButton ()
@property (nonatomic, assign) NSTimeInterval leaveTime;
@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *countDownFormat;
@property (nonatomic, strong) dispatch_source_t timer;
@end


@implementation UIButton (createButton)

static char  topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;
#pragma mark - public method

/**
 创建UIButton,文字及其颜色,字体字号
 
 @param title 文字
 @param titleColor 文字颜色
 @param labelFontSize 字体字号
 @return 自定义的UIButton
 */
+ (UIButton * _Nullable)buttonWithTitle:(NSString * _Nullable)title titleColor:(UIColor * _Nullable)titleColor labelFontSize:(CGFloat)labelFontSize
{
    return [self createButtonWithTitle:title titleColor:titleColor labelFontSize:labelFontSize labelTextAlginment:DefaultTextAlignment cornerRadius:DefaultCornerRadius borderWidth:DefaultBorderWidth borderColor:DefaultBorderColor backgroundColor:DefaultBackgroundColor backgroundImageNormal:DefaultBackgroundImageNormal backgroundImageSelected:DefaultBackgroundImageSelected backgroundImageHighlight: DefaultBackgroundImageHighlight];
}

/**
 创建一个自定义属性的UIButton
 
 @param title 文字
 @param titleColor 文字颜色
 @param labelFontSize 文字字号
 @param labelTextAlginment 文字对齐方式
 @param cornerRadius 圆角半径
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param backgroundColor 背景颜色
 @param backgroundImageNormal 正常状态下的背景图片
 @param backgroundImageSelected 选择状态下的背景图片
 @param backgroundImageHighlight 高亮状态下的背景图片
 @return 自定义的UIButton对象
 */
+ (UIButton * _Nullable)createButtonWithTitle:(NSString * _Nullable)title titleColor:(UIColor * _Nullable)titleColor labelFontSize:(CGFloat)labelFontSize labelTextAlginment:(NSTextAlignment)labelTextAlginment cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor * _Nullable)borderColor backgroundColor:(UIColor * _Nullable)backgroundColor backgroundImageNormal:(UIImage * _Nullable)backgroundImageNormal backgroundImageSelected:(UIImage * _Nullable)backgroundImageSelected backgroundImageHighlight:(UIImage * _Nullable)backgroundImageHighlight
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.layer.cornerRadius = cornerRadius;
    button.clipsToBounds = YES;
    button.titleLabel.font = [UIFont systemFontOfSize:labelFontSize];
    button.titleLabel.textAlignment = labelTextAlginment;
    button.layer.borderWidth = borderWidth;
    button.layer.borderColor = borderColor.CGColor;
    [button setBackgroundImage:backgroundImageNormal forState:UIControlStateNormal];
    [button setBackgroundImage:backgroundImageHighlight forState:UIControlStateHighlighted];
    [button setBackgroundImage:backgroundImageSelected forState:UIControlStateSelected];
    button.backgroundColor = backgroundColor;
    return button;
}
#pragma mark -设置热区
- (UIEdgeInsets)touchAreaInsets
{
    return [objc_getAssociatedObject(self, @selector(touchAreaInsets)) UIEdgeInsetsValue];
}

-(void)setTouchAreaInsets:(UIEdgeInsets)touchAreaInsets
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
    objc_setAssociatedObject(self, @selector(touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    UIEdgeInsets touchAreaInsets = self.touchAreaInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}
- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}


#pragma mark -倒计时相关方法
- (void)setTimer:(dispatch_source_t)timer {
    [self willChangeValueForKey:ktimer];
    objc_setAssociatedObject(self, &ktimer,
                             timer,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:ktimer];
}

- (dispatch_source_t)timer {
    return objc_getAssociatedObject(self, &ktimer);
}

- (void)setLeaveTime:(NSTimeInterval)leaveTime {
    [self willChangeValueForKey:kleaveTime];
    objc_setAssociatedObject(self, &kleaveTime,
                             @(leaveTime),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kleaveTime];
}

- (NSTimeInterval)leaveTime {
    return [objc_getAssociatedObject(self, &kleaveTime) doubleValue];
}

- (void)setCountDownFormat:(NSString *)countDownFormat {
    [self willChangeValueForKey:kcountDownFormat];
    objc_setAssociatedObject(self, &kcountDownFormat,
                             countDownFormat,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kcountDownFormat];
}

- (NSString *)countDownFormat {
    return objc_getAssociatedObject(self, &kcountDownFormat);
}

- (void)setButtonTimeStoppedCallback:(void (^)(void))buttonTimeStoppedCallback {
    [self willChangeValueForKey:kButtonTimeStoppedCallback];
    objc_setAssociatedObject(self, &kButtonTimeStoppedCallback,
                             buttonTimeStoppedCallback,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kButtonTimeStoppedCallback];
}

- (void (^)(void))buttonTimeStoppedCallback {
    return objc_getAssociatedObject(self, &kButtonTimeStoppedCallback);
}

- (void)setNormalTitle:(NSString *)normalTitle {
    [self willChangeValueForKey:knormalTitle];
    objc_setAssociatedObject(self, &knormalTitle,
                             normalTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:knormalTitle];
}

- (NSString *)normalTitle {
    return objc_getAssociatedObject(self, &knormalTitle);
}

#pragma mark - 设置函数

- (void)CountDownWithTimeInterval:(NSTimeInterval)duration countDownFormat:(NSString *)format{
    if (!format){
        self.countDownFormat = @"%zd秒";
    } else {
        self.countDownFormat = format;
    }
    self.normalTitle = self.titleLabel.text;
    __block NSInteger timeOut = duration; //倒计时时间
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(self.timer, ^{
        if (timeOut <= 0) { // 倒计时结束，关闭
            [weakSelf cancelTimer];
        } else {
            NSString *title = [NSString stringWithFormat:weakSelf.countDownFormat,timeOut];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:title forState:UIControlStateNormal];
            });
            timeOut--;
        }
    });
    dispatch_resume(self.timer);
}

- (void)cancelTimer {
    if (self.timer == nil) return;
    dispatch_source_cancel(self.timer);
    self.timer = nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        // 设置界面的按钮显示 根据自己需求设置
        [self setTitle:self.normalTitle forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        if (self.buttonTimeStoppedCallback) { self.buttonTimeStoppedCallback(); }
    });
}
- (void)startButtonActivityIndicatorView:(UIActivityIndicatorViewStyle)style
{
    self.enabled = NO;
    [self setTitle:@"" forState:UIControlStateNormal];
    [self setTitle:@"" forState:UIControlStateHighlighted];
    [self setImage:nil forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateHighlighted];
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    
    indicatorView.frame = CGRectMake((self.bounds.size.width - 20)/2, self.bounds.size.height/2 - 10, 20, 20);
    indicatorView.tag = indicatorViewTag;
    indicatorView.hidesWhenStopped = YES;
    [self addSubview:indicatorView];
    [indicatorView startAnimating];
}

- (void)endButtonActivityIndicatorView
{
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self viewWithTag:indicatorViewTag];
    [indicatorView removeFromSuperview];
    self.enabled = YES;
    self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0.4*(5/2)];
}

@end
