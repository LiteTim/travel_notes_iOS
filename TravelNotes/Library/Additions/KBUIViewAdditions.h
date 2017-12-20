//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIViewClickHandle)(UIView *view);

@interface UIView (KBUIViewAdditions)

/**
 *  orgin.x
 */
@property (nonatomic, assign) CGFloat left;
/**
 *  origin.y
 */
@property (nonatomic, assign) CGFloat top;
/**
 *  origin.x+width
 */
@property (nonatomic, assign) CGFloat right;
/**
 *  y+height
 */
@property (nonatomic, assign) CGFloat bottom;
/**
 *  view.frame.size.width 宽
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  view.frame.size.height 高
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  view.frame.origin
 */
@property (nonatomic, assign) CGPoint origin;
/**
 *  view.frame.size
 */
@property (nonatomic, assign) CGSize  size;
/**
 *  清空所有子view
 */
-(void)removeAllSubviews;
/**
 *  增加UIView的点击事件
 */
-(void)kbHandleClick:(UIViewClickHandle)handle;

//增加一根线
- (UIView*)addLineWithY:(CGFloat)originY;

//当前view截图
- (UIImage*)createImageWithScale:(CGFloat)scale;

/**
 *  自定义边框
 *
 *  @param cornerRadius 角落半径
 *  @param borderWidth  边框宽度
 *  @param color        边框颜色
 */
-(void)setBorderCornerRadius:(CGFloat)cornerRadius andBorderWidth:(CGFloat)borderWidth andBorderColor:(UIColor *)color;

@end
