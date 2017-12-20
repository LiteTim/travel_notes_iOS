//
//  UIBarButtonItem+Extension.m
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "KBUIViewAdditions.h"
#import "KBNSStringAdditions.h"

@implementation UIBarButtonItem (Extension)
/**
 *  返回一个barBtn
 *
 *  @param imageName          normal图片
 *  @param highlightImageName 高亮图片
 *  @param taget              taget
 *  @param action             SEL
 *
 *  @return barBtn
 */
+ (instancetype)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName taget:(id)taget action:(SEL)action
{
    //  设置背景图片
    UIButton *barButtonItem = [[UIButton alloc] init];
    [barButtonItem setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [barButtonItem setBackgroundImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    //  设置大小
    barButtonItem.size = barButtonItem.currentBackgroundImage.size;
    
    //  按钮点击高光
    barButtonItem.showsTouchWhenHighlighted = YES;
    
    //  监听点击事件
    [barButtonItem addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    
    //  返回自定义UIBarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:barButtonItem];
}

/**
 *  返回一个barBtn
 */
+ (instancetype)itemWithTitleStr:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    //  设置背景图片
    UIButton *barButtonItem = [[UIButton alloc] init];
    [barButtonItem setTitle:title forState:UIControlStateNormal];
    [barButtonItem setTitleColor:titleColor forState:UIControlStateNormal];
    //  设置大小
    CGSize titleSize = [title getTextSize:[UIFont systemFontOfSize:18.0] maxWidth:100];
    barButtonItem.size = CGSizeMake(titleSize.width, 44);
    //  按钮点击高光
    barButtonItem.showsTouchWhenHighlighted = YES;
    
    //  监听点击事件
    [barButtonItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //  返回自定义UIBarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:barButtonItem];
}
@end
