//
//  HUDLoading.h
//  ShiTou_App
//
//  Created by gjfax on 16/4/13.
//  Copyright © 2016年 ShiTou. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString * const kDefaultHudLabelText = @"努力加载中..";

@interface HUDLoading : NSObject


#pragma mark - 通用loading
/**
 *  显示一个菊花loading ， 需要hideLoadingHUD消失
 */
+ (void)showHUD;

/**
 *  带默认文字的 菊花loadin， 需要hideLoadingHUD消失
 */
+ (void)showDefaultHUD;

/**
 *  隐藏loading
 */
+ (void)hideLoadingHUD;

/**
 *  更新loading里面的内容
 *
 *  @param aString 内容
 */
+ (void)updateLoadingHUD:(NSString*)aString;

/**
 *  显示一个有菊花，有文字的框，需要调用hideLoadingHUD消失
 *
 *  @param aString 内容
 */
+ (void)showLoadingHUD:(NSString *)aString;

/**
 *  显示一个有菊花，有文字，自动消失的框
 *
 *  @param aString  文字内容，如果是nil，则只有文字，
 *  @param duration 显示时间
 */
+ (void)showLoadingHUD:(NSString *)aString duration:(CGFloat)duration;

#pragma mark - 自动消失的框
/**
 *  显示一个只有文字的框
 *
 *  @param aString  内容
 *  @param duration 显示时间
 */
+ (void)showMsgHUD:(NSString *)aString duration:(CGFloat)duration;
/**
 *  显示一个只有文字的框
 *
 *  @param aString  内容
 *  @param duration 显示时间
 *  @param close    是否支持点击关闭
 */
+ (void)showMsgHUD:(NSString *)aString duration:(CGFloat)duration touchClose:(BOOL)close;


@end
