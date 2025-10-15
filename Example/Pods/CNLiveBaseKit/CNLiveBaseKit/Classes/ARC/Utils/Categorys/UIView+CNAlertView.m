//
//  UIView+CNAlertView.m
//  CNLiveNetAdd
//
//  Created by 流诗语 on 2018/3/20.
//  Copyright © 2018年 cnlive. All rights reserved.
//

#import "UIView+CNAlertView.h"
#import <objc/runtime.h>
#import "NSString+CNLiveExtension.h"
#import "CNLiveDefinesHeader.h"
#import "UIView+Extension.h"
#import "CNLiveBaseKit.h"

#define APPSIZE [[UIScreen mainScreen] bounds].size

@implementation UIView (CNAlertView)

UIView *backgroundV;
UIView *bottomView;
float height;

static NSString *keyOfMethod = @"keyOfMethod";
//方法实现
-(void)createAlertViewTitleArray:(NSArray* )array textColor:(id )color font:(UIFont*)font actionBlock:(CNAlertBlock)actionBlock
{
    if (backgroundV != nil && bottomView != nil) return;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    backgroundV = [[UIView alloc]initWithFrame:window.bounds];
    backgroundV.backgroundColor = RGBA(0, 0, 0, 0);
    backgroundV.exclusiveTouch = YES;
    [window addSubview:backgroundV];
    
    //点击手势
    UITapGestureRecognizer *touchDown = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didMiss)];
    touchDown.numberOfTapsRequired = 1;
    [backgroundV addGestureRecognizer:touchDown];
    
    height = array.count*50+array.count*0.5+57.5+kVerticalBottomSafeHeight;
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, APPSIZE.height, APPSIZE.width, height+50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [window addSubview:bottomView];
    
    NSArray *arrayColor;
    UIColor *colors;
    
    for (int i=0; i<array.count; i++) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, i*50+i*0.5, APPSIZE.width, 50)];
        
        [btn setTitle:array[i] forState:UIControlStateNormal];
        
//        if (arrayImage) {
//            if (i>=arrayImage.count) {
//                NSLog(@"数组越界-数组图片数量有误，请仔细检查");
//                return;
//            }
//            [btn setImage:[UIImage imageNamed:arrayImage[i]] forState:UIControlStateNormal];
//            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//            btn.imageEdgeInsets = UIEdgeInsetsMake(12, - 0.5 * spacing, 12, 0.5 * spacing);
//            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
//        }
        
        
        btn.tag = 10000+i;
        btn.titleLabel.font = font;
        [bottomView addSubview:btn];
        [btn addTarget:self action:@selector(didTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(didTitleBtnTouchDragInside:) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(didTitleBtnTouchDragOutsid:) forControlEvents:UIControlEventTouchDragOutside];
        
        
        //关联 block
        objc_setAssociatedObject (btn , &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (i!=array.count-1) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), APPSIZE.width, 0.5)];
            line.backgroundColor = RGBA(230, 230, 230, 1);
            [bottomView addSubview:line];
        }
        //如果是数组颜色
        if ([color isKindOfClass:[NSArray class]]) {
            arrayColor = [NSArray arrayWithArray:color];
            if (i>=arrayColor.count) {
                NSLog(@"数组越界-数组图片颜色数量有误，请仔细检查");
                return;
            }
            colors = arrayColor[i];
        }else{
            colors = (UIColor*)color;
        }
        [btn setTitleColor:colors forState:UIControlStateNormal];
        
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, array.count*50.5-0.5, APPSIZE.width, 8)];
    line.backgroundColor = RGBA(239, 239, 239, 1);
    [bottomView addSubview:line];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), APPSIZE.width, 50)];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = UIFontCNMake(16);
    [bottomView addSubview:btn];
    [btn addTarget:self action:@selector(didMiss) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.3 animations:^{
        bottomView.frame = CGRectMake(0, APPSIZE.height-height, APPSIZE.width, height);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundV.backgroundColor = RGBA(0, 0, 0, 0.3);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)createAlertViewTitleArray:(NSArray* )array textColorArray:(NSArray<UIColor*>*)colorArray font:(NSArray <UIFont *>*)fontArray actionBlock:(CNAlertBlock)actionBlock
{
    if (backgroundV != nil && bottomView != nil) return;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    backgroundV = [[UIView alloc]initWithFrame:window.bounds];
    backgroundV.backgroundColor = RGBA(0, 0, 0, 0);
    
    [window addSubview:backgroundV];
    
    //点击手势
    UITapGestureRecognizer *touchDown = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didMiss)];
    touchDown.numberOfTapsRequired = 1;
    [backgroundV addGestureRecognizer:touchDown];
    
    height = array.count*50+array.count*0.5+57.5+kVerticalBottomSafeHeight;
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, APPSIZE.height, APPSIZE.width, height+50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [window addSubview:bottomView];
    
    NSInteger numHeight = 0;
    for (int i=0; i<array.count; i++) {
        NSString *title = array[i];
        NSInteger h =[title boundingRectWithSize:CGSizeMake(KScreenWidth - 60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height + 35 + 0.5;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, numHeight, APPSIZE.width, h)];
        numHeight += h;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 30)];
        btn.titleLabel.numberOfLines = 2;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        
        //        if (arrayImage) {
        //            if (i>=arrayImage.count) {
        //                NSLog(@"数组越界-数组图片数量有误，请仔细检查");
        //                return;
        //            }
        //            [btn setImage:[UIImage imageNamed:arrayImage[i]] forState:UIControlStateNormal];
        //            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //            btn.imageEdgeInsets = UIEdgeInsetsMake(12, - 0.5 * spacing, 12, 0.5 * spacing);
        //            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0.5 * spacing, 0, - 0.5 * spacing);
        //        }
        
        
        btn.tag = 10000+i;
        
        [bottomView addSubview:btn];
        [btn addTarget:self action:@selector(didTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(didTitleBtnTouchDragInside:) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(didTitleBtnTouchDragOutsid:) forControlEvents:UIControlEventTouchDragOutside];
        
        
        //关联 block
        objc_setAssociatedObject (btn , &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (i!=array.count-1) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), APPSIZE.width, 0.5)];
            line.backgroundColor = RGBA(230, 230, 230, 1);
            [bottomView addSubview:line];
        }
        if (i>=fontArray.count) {
            NSLog(@"数组越界-数组字体大小 数量有误，请仔细检查");
            return;
        }
        btn.titleLabel.font = fontArray[i];
        if (i>=colorArray.count) {
            NSLog(@"数组越界-数组图片颜色数量有误，请仔细检查");
            return;
        }
       
        [btn setTitleColor:colorArray[i] forState:UIControlStateNormal];
        
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, numHeight -0.5, APPSIZE.width, 8)];
    line.backgroundColor = RGBA(239, 239, 239, 1);
    [bottomView addSubview:line];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), APPSIZE.width, 50 + kVerticalBottomSafeHeight)];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:btn];
    [btn addTarget:self action:@selector(didMiss:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject (btn , &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.cancelBtn = btn;
    numHeight += btn.frame.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        bottomView.frame = CGRectMake(0, APPSIZE.height-numHeight , APPSIZE.width, numHeight);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundV.backgroundColor = RGBA(0, 0, 0, 0.3);
    } completion:^(BOOL finished) {
        
    }];
}
- (void)createAlertViewTitleArray:(NSArray <NSString *>* )array subTitleArr:(NSArray <NSString *>*)subTitleArr textColor:(id)color subTitleColor:(id)subTitleColor font:(UIFont*)font subFont:(UIFont *)subFont actionBlock:(CNAlertBlock)actionBlock
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    backgroundV = [[UIView alloc]initWithFrame:window.bounds];
    backgroundV.backgroundColor = RGBA(0, 0, 0, 0);
    [window addSubview:backgroundV];
    
    //点击手势
    UITapGestureRecognizer *touchDown = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didMiss)];
    touchDown.numberOfTapsRequired = 1;
    [backgroundV addGestureRecognizer:touchDown];
    
    height = array.count*50+array.count*0.5+57.5+kVerticalBottomSafeHeight;
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, APPSIZE.height, APPSIZE.width, height+50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [window addSubview:bottomView];
    
    NSArray *arrayColor;
    UIColor *colors;
    
    NSArray *subArrayColor;
    UIColor *subColors;
    CGFloat totalHeight = 0;
    
    for (int i=0; i<array.count; i++) {
        UIButton *btn;
        NSString *subTitle = [subTitleArr objectAtIndex:i];
        if (CNLiveStringIsEmpty(subTitle)) {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, totalHeight+i*0.5, APPSIZE.width, 50)];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            //如果是数组颜色
            if ([color isKindOfClass:[NSArray class]]) {
                arrayColor = [NSArray arrayWithArray:color];
                if (i>=arrayColor.count) {
                    NSLog(@"数组越界-数组图片颜色数量有误，请仔细检查");
                    return;
                }
                colors = arrayColor[i];
            }else{
                colors = (UIColor*)color;
            }
            [btn setTitleColor:colors forState:UIControlStateNormal];
        }else{
            height += 17;
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, totalHeight+i*0.5, APPSIZE.width, 67)];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, btn.width, 15)];
            titleLabel.text = array[i];
            titleLabel.font = font;
            //如果是数组颜色
            if ([subTitleColor isKindOfClass:[NSArray class]]) {
                subArrayColor = [NSArray arrayWithArray:subTitleColor];
                if (i >= subArrayColor.count) {
                    NSLog(@"数组越界-数组图片颜色数量有误，请仔细检查");
                    return;
                }
                subColors = subArrayColor[i];
            }else{
                subColors = (UIColor*)subArrayColor;
            }
            titleLabel.textColor = subColors;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:titleLabel];
            
            UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom+5, btn.width, 12)];
            subTitleLabel.text = subTitle;
            subTitleLabel.font = subFont;
            subTitleLabel.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:subTitleLabel];
            //如果是数组颜色
            if ([subTitleColor isKindOfClass:[NSArray class]]) {
                subArrayColor = [NSArray arrayWithArray:subTitleColor];
                if (i>=subArrayColor.count) {
                    NSLog(@"数组越界-数组图片颜色数量有误，请仔细检查");
                    return;
                }
                subColors = subArrayColor[i];
            }else{
                subColors = (UIColor*)color;
            }
            [subTitleLabel setTextColor:subColors];
        }
        totalHeight += btn.height;
        
        btn.tag = 10000+i;
        btn.titleLabel.font = font;
        [bottomView addSubview:btn];
        [btn addTarget:self action:@selector(didTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(didTitleBtnTouchDragInside:) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(didTitleBtnTouchDragOutsid:) forControlEvents:UIControlEventTouchDragOutside];
        
        
        //关联 block
        objc_setAssociatedObject (btn , &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (i!=array.count-1) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), APPSIZE.width, 0.5)];
            line.backgroundColor = RGBA(230, 230, 230, 1);
            [bottomView addSubview:line];
        }
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, totalHeight-0.5, APPSIZE.width, 8)];
    line.backgroundColor = RGBA(239, 239, 239, 1);
    [bottomView addSubview:line];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), APPSIZE.width, 50)];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [bottomView addSubview:btn];
    [btn addTarget:self action:@selector(didMiss:) forControlEvents:UIControlEventTouchUpInside];
    [UIView animateWithDuration:0.3 animations:^{
        bottomView.frame = CGRectMake(0, APPSIZE.height-height, APPSIZE.width, height);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundV.backgroundColor = RGBA(0, 0, 0, 0.3);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)createAlertViewTitleArray:(NSArray <NSString *>* )array subTitleArr:(NSArray <NSString *>*)subTitleArr textColor:(id)color subTitleColor:(id)subTitleColor firstFont:(UIFont *)firstFont font:(UIFont*)font subFont:(UIFont *)subFont cancelTitle:(NSString *)cancelTitle cancelFont:(UIFont *)cancelFont cancelTitleColor:(UIColor *)cancelTitleColor actionBlock:(CNAlertBlock)actionBlock
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    backgroundV = [[UIView alloc]initWithFrame:window.bounds];
    backgroundV.backgroundColor = RGBA(0, 0, 0, 0);
    [window addSubview:backgroundV];
    
    //点击手势
    UITapGestureRecognizer *touchDown = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didMiss)];
    touchDown.numberOfTapsRequired = 1;
    [backgroundV addGestureRecognizer:touchDown];
    
//    height = array.count*50+array.count*0.5+57.5;
    height = array.count*50+array.count*0.5+57.5+kVerticalBottomSafeHeight;
    
    bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, APPSIZE.height, APPSIZE.width, height+50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [window addSubview:bottomView];
    
    NSArray *arrayColor;
    UIColor *colors;
    
    NSArray *subArrayColor;
    UIColor *subColors;
    CGFloat totalHeight = 0;
    
    for (int i=0; i<array.count; i++) {
        UIButton *btn;
        NSString *subTitle = [subTitleArr objectAtIndex:i];
        if (CNLiveStringIsEmpty(subTitle)) {
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, totalHeight+i*0.5, APPSIZE.width, 50)];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            //如果是数组颜色
            if ([color isKindOfClass:[NSArray class]]) {
                arrayColor = [NSArray arrayWithArray:color];
                if (i>=arrayColor.count) {
                    NSLog(@"数组越界-数组图片颜色数量有误，请仔细检查");
                    return;
                }
                colors = arrayColor[i];
            }else{
                colors = (UIColor*)color;
            }
            [btn setTitleColor:colors forState:UIControlStateNormal];
            if (i == 0) {
                [btn.titleLabel setFont:firstFont];
            }else
            {
                [btn.titleLabel setFont:font];
            }
        }else{
            height += 17;
            btn = [[UIButton alloc]initWithFrame:CGRectMake(0, totalHeight+i*0.5, APPSIZE.width, 67)];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, btn.width, 15)];
            titleLabel.text = array[i];
            titleLabel.font = font;
            if (i == 0) {
                titleLabel.font = firstFont;
            }
            //如果是数组颜色
            if ([subTitleColor isKindOfClass:[NSArray class]]) {
                subArrayColor = [NSArray arrayWithArray:subTitleColor];
                if (i >= subArrayColor.count) {
                    NSLog(@"数组越界-数组图片颜色数量有误，请仔细检查");
                    return;
                }
                subColors = subArrayColor[i];
            }else{
                subColors = (UIColor*)subArrayColor;
            }
            titleLabel.textColor = subColors;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:titleLabel];
            
            UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom+5, btn.width, 12)];
            subTitleLabel.text = subTitle;
            subTitleLabel.font = subFont;
            subTitleLabel.textAlignment = NSTextAlignmentCenter;
            [btn addSubview:subTitleLabel];
            //如果是数组颜色
            if ([subTitleColor isKindOfClass:[NSArray class]]) {
                subArrayColor = [NSArray arrayWithArray:subTitleColor];
                if (i>=subArrayColor.count) {
                    NSLog(@"数组越界-数组图片颜色数量有误，请仔细检查");
                    return;
                }
                subColors = subArrayColor[i];
            }else{
                subColors = (UIColor*)color;
            }
            [subTitleLabel setTextColor:subColors];
        }
        totalHeight += btn.height;
        
        btn.tag = 10000+i;
        [bottomView addSubview:btn];
        [btn addTarget:self action:@selector(didTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn addTarget:self action:@selector(didTitleBtnTouchDragInside:) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(didTitleBtnTouchDragOutsid:) forControlEvents:UIControlEventTouchDragOutside];
        
        
        //关联 block
        objc_setAssociatedObject (btn , &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        if (i!=array.count-1) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame), APPSIZE.width, 0.5)];
            line.backgroundColor = RGBA(230, 230, 230, 1);
            [bottomView addSubview:line];
        }
    }
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, totalHeight-0.5, APPSIZE.width, 8)];
    line.backgroundColor = RGBA(239, 239, 239, 1);
    [bottomView addSubview:line];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), APPSIZE.width, 50)];
    [btn setTitle:cancelTitle forState:UIControlStateNormal];
    [btn setTitleColor:cancelTitleColor forState:UIControlStateNormal];
    btn.titleLabel.font = cancelFont;
    [bottomView addSubview:btn];
    [btn addTarget:self action:@selector(didMiss:) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject (btn , &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [UIView animateWithDuration:0.3 animations:^{
        bottomView.frame = CGRectMake(0, APPSIZE.height-height, APPSIZE.width, height);
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        backgroundV.backgroundColor = RGBA(0, 0, 0, 0.3);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)didTitleBtnTouchDragOutsid:(UIButton*)btn{
    
    btn.backgroundColor = [UIColor clearColor];
}
-(void)didTitleBtnTouchDragInside:(UIButton*)btn{
    btn.backgroundColor = RGBA(245, 245, 245, 1);
}

-(void)didTitleBtn:(UIButton*)btn{
    
    btn.backgroundColor = [UIColor clearColor];
    //获取关联
    CNAlertBlock block1 = (CNAlertBlock)objc_getAssociatedObject(btn, &keyOfMethod);
    if(block1){
        block1(btn,btn.tag-10000);
        [UIView animateWithDuration:0.3 animations:^{
            backgroundV.backgroundColor = RGBA(0, 0, 0, 0);
            bottomView.frame = CGRectMake(0, APPSIZE.height, APPSIZE.width, height+50);
        } completion:^(BOOL finished) {
            [backgroundV removeFromSuperview];
            [bottomView removeFromSuperview];
            backgroundV = nil;
            bottomView = nil;
        }];
    }
}

-(void)didMiss:(UIButton*)btn{
    [self didMiss];
   
}

-(void)didMiss{

    [UIView animateWithDuration:0.3 animations:^{
        backgroundV.backgroundColor = RGBA(0, 0, 0, 0);
        bottomView.frame = CGRectMake(0, APPSIZE.height, APPSIZE.width, height+50);
    } completion:^(BOOL finished) {
        if (backgroundV != nil && bottomView != nil) {
            CNAlertBlock block1 = (CNAlertBlock)objc_getAssociatedObject(self.cancelBtn, &keyOfMethod);
            if(block1) block1(self.cancelBtn,1000);
        }
        [backgroundV removeFromSuperview];
        [bottomView removeFromSuperview];
        backgroundV = nil;
        bottomView = nil;
    }];
}
- (void)setCancelBtn:(UIButton *)cancelBtn
{
    objc_setAssociatedObject(self,@"cancelBtn",cancelBtn,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIButton *)cancelBtn
{
   UIButton *btn = objc_getAssociatedObject(self, @"cancelBtn");

    return btn;
}
@end
