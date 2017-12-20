//
//  UIButton+Addittions.h
//  TravelNotes
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickCallback)(UIButton* button);

@interface UIButton (Addittions)

- (void)kbHandleClickEvent:(UIControlEvents)aEvent
                  callBack:(ButtonClickCallback)callBack;


/**
 *  设置纯色的背景图
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


/**
 *  返回一个btn
 *
 *  @return btn
 */
+ (instancetype)btnWithTitle:(NSString *)title rect:(CGRect)rect bgColor:(UIColor *)bgColor taget:(id)taget action:(SEL)action;

/**
 *  返回一个btn - 图片
 *
 *  @return btn
 */
+ (instancetype)btnWithImageName:(NSString *)iconName position:(CGPoint)position taget:(id)taget action:(SEL)action;
@end
