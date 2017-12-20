//
//  CommonMethod.h
//  ShiTou_App
//
//  Created by gjfax on 16/4/13.
//  Copyright © 2016年 ShiTou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "KBNSObjectAdditions.h"

@interface CommonMethod : NSObject



//获取当前的window，不一定是keywindow
UIWindow *kbMainWindow(void);

//当前最高一级VC
UIViewController *kbTopMostViewController(void);

//可以任意地方调用这个push，不需要跑回基类VC调用self.navigationController这么麻烦
void kbPushViewController (UIViewController *vc,BOOL animated);

//通过class来push，properties是入参
void kbPushWithVCClass (Class vcClass,NSDictionary *properties);

//通过className的stringpush
void kbPushWithVCClassName (NSString *className,NSDictionary *properties);

//present，同上
void kbPresentViewController (UIViewController *vc,BOOL animated);

#pragma mark - UUID
/**
 *  生成UUID
 *
 *  @return uuid string
 */
+ (NSString*)uuid;

#pragma mark - appVersion
/**
 *  app版本号
 *
 *  @return CFBundleShortVersionString
 */
+ (NSString *)appVersion;

#pragma mark - 手机型号
/**
 *  设备类型
 *
 *  @return iPhone 6s / 6
 */
+ (NSString *)deviceType;

#pragma mark -- 返回特定页面处理
/*
 *  返回特定的页面 【倒数】
 *  count     返回的倒数第几个VC, eg：当前页面为0，前一个页面为1
 *  fail      返回失败，返回页面处理
 */
+ (void)backToSpecificVC:(UINavigationController *)navi
           SpecificCount:(NSInteger)count
                    fail:(void (^)(void))fail;


/*
 *  返回特定的页面 顺数
 *  count     返回的顺数第几个VC, eg：从第0页为第一页
 *  fail      返回失败，返回页面处理
 */
+ (void)backToSpecificVCWithOrder:(UINavigationController *)navi
                    SpecificCount:(NSInteger)count
                             fail:(void (^)(void))fail;


/**
 *  返回指定的页面
 *
 *  @param navi 当前navigationController
 *  @param name 返回的控制器类名
 *  @param fail 返回失败，返回页面处理
 */
+ (void)backToSpecificVCWithOrder:(UINavigationController *)navi
                     SpecificName:(NSString *)name
                             fail:(void (^)(void))fail;

@end
