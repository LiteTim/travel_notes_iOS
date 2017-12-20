//
//  UIButton+Addittions.m
//  TravelNotes
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import "UIButton+Addittions.h"
#import <objc/runtime.h>
#import "CommonDefine.h"
#import "KBUIViewAdditions.h"

static char *overViewKey;

@implementation UIButton (Addittions)
- (void)kbHandleClickEvent:(UIControlEvents)aEvent
                  callBack:(ButtonClickCallback)callBack;
{
    objc_setAssociatedObject(self, &overViewKey, callBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(buttonClick) forControlEvents:aEvent];
}

- (void)buttonClick {
    ButtonClickCallback callBack = objc_getAssociatedObject(self, &overViewKey);
    if (callBack!= nil)
    {
        callBack(self);
    }
}


/**
 *  设置纯色的背景图
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIButton imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}


/**
 *  返回一个btn
 *
 *  @return btn
 */
+ (instancetype)btnWithTitle:(NSString *)title rect:(CGRect)rect bgColor:(UIColor *)bgColor taget:(id)taget action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.backgroundColor = CommonColor_SkyBlue;
    btn.titleLabel.font = CommonFontAutoFix_(18);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8.f;
    btn.clipsToBounds = YES;
    [btn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    //    //  按钮点击高光
    //    btn.showsTouchWhenHighlighted = YES;
    //  事件响应
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    //  设置点击间隔
    //btn.acceptEventInterval = .5f;

    return btn;
}

/**
 *  返回一个btn - 图片
 *
 *  @return btn
 */
+ (instancetype)btnWithImageName:(NSString *)iconName position:(CGPoint)position taget:(id)taget action:(SEL)action
{
    //  图片
    UIImage *btnIcon = [UIImage imageNamed:iconName];
    //  默认按钮
    if (!btnIcon) {
        btnIcon = [UIImage imageNamed:@"btn_navi_close_selected"];
    }
    //  按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setBackgroundImage:btnIcon forState:UIControlStateNormal];
    [btn setBackgroundImage:btnIcon forState:UIControlStateHighlighted];

    //  设置大小
    btn.size = btn.currentBackgroundImage.size;
    btn.frame = CGRectMake(position.x, position.y, btn.size.width, btn.size.height);

    //  按钮点击高光
    btn.showsTouchWhenHighlighted = YES;

    //  事件响应
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];

    //  设置点击间隔
    //btn.acceptEventInterval = .5f;

    return btn;
}
@end
