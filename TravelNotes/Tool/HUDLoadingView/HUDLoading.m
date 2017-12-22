//
//  HUDLoading.m
//  ShiTou_App
//
//  Created by gjfax on 16/4/13.
//  Copyright © 2016年 ShiTou. All rights reserved.
//

#import "HUDLoading.h"
#import "MBProgressHUD.h"
#import "KBUIViewAdditions.h"
#import "KBNSStringAdditions.h"
#import "CommonMethod.h"
#import "CommonDefine.h"

static MBProgressHUD  *s_progressHUD = nil;

@implementation HUDLoading

/**
 *  显示一个菊花loading ， 需要hideLoadingHUD消失
 */
+ (void)showHUD
{
    [self showLoadingHUD:nil];
}

/**
 *  带默认文字的 菊花loadin， 需要hideLoadingHUD消失
 */
+ (void)showDefaultHUD
{
    [self showLoadingHUD:kDefaultHudLabelText];
}


/**
 *  显示一个有菊花，有文字的框，需要调用hideLoadingHUD消失
 *
 *  @param aString 内容
 */
+ (void)showLoadingHUD:(NSString *)aString {
    if (!s_progressHUD) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            s_progressHUD = [[MBProgressHUD alloc] initWithView:kbMainWindow()];
        });
    }else{
        [s_progressHUD hideAnimated:NO];
//        [s_progressHUD hide:NO];
    }
    [kbMainWindow() addSubview:s_progressHUD];
    s_progressHUD.removeFromSuperViewOnHide = YES;
    s_progressHUD.animationType = MBProgressHUDAnimationZoom;
    if ([aString length]>0) {
        s_progressHUD.detailsLabel.text = aString;
//        s_progressHUD.detailsLabelText = aString;
    }else{
        s_progressHUD.detailsLabel.text = @" ";
//        s_progressHUD.detailsLabelText = nil;
    }
    
    
//    s_progressHUD.opacity = 0.7;
    s_progressHUD.bezelView.color = RGBColorAlpha(222, 222, 222, 0.7);
    [s_progressHUD showAnimated:YES];
//    [s_progressHUD show:YES];
    
}

/**
 *  显示一个只有文字的框
 *
 *  @param aString  内容
 *  @param duration 显示时间
 *  @param close    是否支持点击关闭
 */
+ (void)showMsgHUD:(NSString *)aString duration:(CGFloat)duration touchClose:(BOOL)close
{
    [self hideLoadingHUD];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:kbMainWindow()];
    [kbMainWindow() addSubview:progressHUD];
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    progressHUD.detailsLabel.font = [UIFont systemFontOfSize:15.f];
    progressHUD.detailsLabel.text = kbToString(aString);
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.bezelView.color = RGBColorAlpha(222, 222, 222, 0.7);
    progressHUD.mode = MBProgressHUDModeText;
    [progressHUD showAnimated:NO];
    [progressHUD hideAnimated:YES afterDelay:duration];

    if (close) {
        [progressHUD kbHandleClick:^(UIView *view) {
            [(MBProgressHUD*)view hideAnimated:YES];
        }];
    }
}

+ (void)showMsgHUD:(NSString *)aString duration:(CGFloat)duration {
    [self hideLoadingHUD];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:kbMainWindow()];
    [kbMainWindow() addSubview:progressHUD];
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    progressHUD.detailsLabel.text = kbToString(aString);
//    progressHUD.detailsLabelText = kbToString(aString);
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.bezelView.color = RGBColorAlpha(222, 222, 222, 0.7);
//    progressHUD.opacity = 0.7;
    progressHUD.mode = MBProgressHUDModeText;
    [progressHUD showAnimated:NO];
//    [progressHUD show:NO];
    [progressHUD hideAnimated:YES afterDelay:duration];
//    [progressHUD hide:YES afterDelay:duration];
}

+ (void)hideLoadingHUD {
    if (s_progressHUD) {
        [s_progressHUD hideAnimated:YES];
//        [s_progressHUD hide:YES];
    }
}

+ (void)updateLoadingHUD:(NSString*)progress {
    if (s_progressHUD) {
        s_progressHUD.detailsLabel.text = progress;
//        s_progressHUD.detailsLabelText = progress;
    }
}

+ (void)showLoadingHUD:(NSString *)aString duration:(CGFloat)duration {
    [self hideLoadingHUD];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:kbMainWindow()];
    [kbMainWindow() addSubview:progressHUD];
    progressHUD.animationType = MBProgressHUDAnimationZoom;
    progressHUD.detailsLabel.text = aString;
//    progressHUD.detailsLabelText = aString;
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.bezelView.color = RGBColorAlpha(222, 222, 222, 0.7);
//    progressHUD.opacity = 0.7;
    [progressHUD showAnimated:NO];
//    [progressHUD show:NO];
    [progressHUD hideAnimated:YES afterDelay:duration];
//    [progressHUD hide:YES afterDelay:duration];
}

@end
