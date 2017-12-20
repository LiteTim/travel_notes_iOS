//
//  NotesBaseViewController.h
//  TravelNotes
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonDefine.h"
#import "CommonMethod.h"
#import "UIButton+Addittions.h"
#import "KBNSDictionaryAddtions.h"
#import "KBUIImageAdditions.h"
#import "KBArrayAddtions.h"
#import "KBUIViewAdditions.h"
#import "KBNSObjectAdditions.h"

@interface NotesBaseViewController : UIViewController
/**
 *  修改statusBar的样式
 *  plist View controller-based status bar appearance NO 的情况下有效
 */
@property (nonatomic, assign) UIStatusBarStyle                  statusBarStyle;
/**
 *  navigationBar的颜色
 */
@property (nonatomic, strong) UIColor*                          barTintColor;

/**
 *  将navigationBar的颜色 设置为 透明 ,优先级比 barTintColor 高
 */
@property (nonatomic, assign) BOOL                              isBarTintClearColor;

/**
 *  navigationBar title的颜色
 */
@property (nonatomic, strong) UIColor*                          titleColor;
/**
 *  是否显示自定义的返回按钮 < 返回
 */
@property (nonatomic, assign) BOOL                              showCustomLeftBarButton;
/**
 *  去掉statusBar的y值
 */
@property (nonatomic, assign) CGFloat                           originY;

@property (nonatomic,strong)  NSArray *                         leftBarButtons;

/**
 *  返回按钮事件，默认pop
 */
- (void)leftBarButtonAction;

@end
