//
//  UIBarButtonItem+Extension.h
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

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
+ (instancetype)itemWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName taget:(id)taget action:(SEL)action;

/**
 *  返回一个barBtn
 */
+ (instancetype)itemWithTitleStr:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;
@end
