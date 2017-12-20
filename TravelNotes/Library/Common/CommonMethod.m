//
//  CommonMethod.m
//  ShiTou_App
//
//  Created by gjfax on 16/4/13.
//  Copyright © 2016年 ShiTou. All rights reserved.
//

#import "CommonMethod.h"
#import <sys/sysctl.h>
#import <Security/Security.h>
#import <sys/utsname.h>

@implementation CommonMethod


UIWindow *kbMainWindow() {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    }
    else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                return window;
            }
        }
    }
    return nil;
}

UIViewController *kbTopMostViewController() {
    UIViewController *topViewController = kbMainWindow().rootViewController;
    UIViewController *temp = nil;
    while (YES) {
        temp = nil;
        if ([topViewController isKindOfClass:[UINavigationController class]]) {
            temp = ((UINavigationController *)topViewController).visibleViewController;
            
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            temp = ((UITabBarController *)topViewController).selectedViewController;
        }
        else if (topViewController.presentedViewController != nil) {
            temp = topViewController.presentedViewController;
        }
        
        if (temp != nil) {
            topViewController = temp;
        } else {
            break;
        }
    }
    return topViewController;
}

void kbSwapMethods(Class class, SEL originalSelector, SEL swizzledSelector) {
    if (!class || !originalSelector || !swizzledSelector) {
        return;
    }
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void kbPushViewController (UIViewController *vc,BOOL animated) {
    if (!vc || ![vc isKindOfClass:[UIViewController class]]) return;
    vc.hidesBottomBarWhenPushed = YES;
    [kbTopMostViewController().navigationController pushViewController:vc animated:animated];
}

void kbPushWithVCClass (Class vcClass,NSDictionary *properties) {
    id obj = [vcClass new];
    if (!obj) return;
    if(kbToDictionary(properties)) [obj kbAutoSetPropertySafety:properties];
    kbPushViewController(obj, YES);
}

void kbPushWithVCClassName (NSString *className,NSDictionary *properties) {
    id obj = [NSClassFromString(className) new];
    if (!obj) return;
    if(kbToDictionary(properties)) [obj kbAutoSetPropertySafety:properties];
    kbPushViewController(obj, YES);
}

//present，同上
void kbPresentViewController (UIViewController *vc,BOOL animated) {
    if (!vc) return;
    vc.hidesBottomBarWhenPushed = YES;
    [kbTopMostViewController().navigationController presentViewController:vc animated:animated completion:^{
        
    }];
}

+ (NSString*)uuid
{
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    return result;
}

#pragma mark - appVersion

+ (NSString *)appVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    return appVersion;
}

#pragma mark - 手机型号

+ (NSString *)deviceType
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
    
}

#pragma mark -- 返回特定页面处理
/*
 *  返回特定的页面 【倒数】
 *  count     返回的倒数第几个VC, eg：当前页面为0，前一个页面为1
 *  fail      返回失败，返回页面处理
 */
+ (void)backToSpecificVC:(UINavigationController *)navi SpecificCount:(NSInteger)count fail:(void (^)(void))fail
{
    count++;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSInteger MaxCount = navi.viewControllers.count;
        if (MaxCount >= count && count > 0) {
            [navi popToViewController:navi.viewControllers[MaxCount - count]
                             animated:YES];
        }else {
            if (fail) {
                fail();
            }
        }
    }];
}

/*
 *  返回特定的页面 顺数
 *  count     返回的顺数第几个VC, eg：从第0页为第一页
 *  fail      返回失败，返回页面处理
 */
+ (void)backToSpecificVCWithOrder:(UINavigationController *)navi SpecificCount:(NSInteger)count fail:(void (^)(void))fail
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSInteger MaxCount = navi.viewControllers.count;
        if (MaxCount > count && count >= 0) {
            [navi popToViewController:navi.viewControllers[count]
                             animated:NO];
        }else {
            if (fail) {
                fail();
            }
        }
    }];
}


/**
 *  返回指定的页面
 *
 *  @param navi 当前navigationController
 *  @param name 返回的控制器类名
 *  @param fail 返回失败，返回页面处理
 */
+ (void)backToSpecificVCWithOrder:(UINavigationController *)navi SpecificName:(NSString *)name fail:(void (^)(void))fail
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSInteger index = 0;
        for (UIViewController *controller in navi.viewControllers) {
            if ([controller isKindOfClass:[NSClassFromString(name) class]]) {
                [navi popToViewController:controller animated:YES];
                break;
            }
            if (index == navi.viewControllers.count - 1) {
                
                if (fail) {
                    fail();
                }
            }
            index++;
        }
    }];
}

@end
