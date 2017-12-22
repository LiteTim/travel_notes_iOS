//
//  HttpTool.m
//  ShiTou_App
//
//  Created by gjfax on 16/4/13.
//  Copyright © 2016年 ShiTou. All rights reserved.
//

#import "HttpTool.h"
#import "Reachability.h"
#import "CommonDefine.h"
#import "CGIDefine.h"
#import "HUDLoading.h"

#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation HttpTool

#pragma mark - 判断是否有网络
/**
 *  这个函数是判断网络是否可用的 (wifi或者蜂窝数据可用,都返回YES)
 *
 *  @return Yes or No
 */
+ (BOOL)isNetworkOpen
{
    if(([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) &&
       ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable))
    {
        return YES;
    } else {
        
        Show_iToast(@"网络不可用,请检查网络");
        return NO;
    }
}

+ (void)postUrl:(NSString *)strUrl
         params:(NSDictionary *)dicParams
        success:(void (^)(id response))success
        failure:(void (^)(NSError *error))failure
{
    if ([self isNetworkOpen]) {
        
        AFHTTPSessionManager *manager = [BaseNetworkingClient sharedClient];
        
        //        //  每个请求之前清空Cookie
        //        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        //        if ([cookieJar cookies].count > 0) {
        //            for (NSHTTPCookie *cookie in [cookieJar cookies]) {
        //                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        //            }
        //        }
        
//        //  签名放cookie中
//        NSDictionary *cookiePropertiesDic = @{@"sessionid": @"123456789"};
//        [cookiePropertiesDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//            //  设定 cookie
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 [manager.baseURL host], NSHTTPCookieDomain,
//                                 [manager.baseURL path], NSHTTPCookiePath,
//                                 key, NSHTTPCookieName,
//                                 obj, NSHTTPCookieValue,
//                                 nil];
//            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:dic];
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//            
//        }];
        
        //  请求
        NSURLSessionDataTask *task = [manager POST:strUrl parameters:dicParams progress:^(NSProgress * _Nonnull uploadProgress) {
            //  progress
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (responseObject) {
                if (success) {
                    success(responseObject);
                }
                
            } else {
                if (failure) {
                    failure(nil);
                }
                
                NSLog(@"%@ -> 返回数据格式错误", strUrl);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //  failure
            if (failure) {
                failure(error);
            }
        }];
        
        DLog(@"%@",task);
    } else {
        //  无网络提示
        if (failure) {
            failure(nil);
        }
    }
    
}

+ (void)getUrl:(NSString *)strUrl
         params:(NSDictionary *)dicParams
        success:(void (^)(id response))success
        failure:(void (^)(NSError *error))failure
{
    if ([self isNetworkOpen]) {
        
        AFHTTPSessionManager *manager = [BaseNetworkingClient sharedClient];
        
//        //  每个请求之前清空Cookie
//        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//        if ([cookieJar cookies].count > 0) {
//            for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
//            }
//        }
//
//        //  签名放cookie中
//        NSDictionary *cookiePropertiesDic = @{@"sessionid": @"123456789"};
//        [cookiePropertiesDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//            //  设定 cookie
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 [manager.baseURL host], NSHTTPCookieDomain,
//                                 [manager.baseURL path], NSHTTPCookiePath,
//                                 key, NSHTTPCookieName,
//                                 obj, NSHTTPCookieValue,
//                                 nil];
//            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:dic];
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//            
//        }];
        
        //  请求
        NSURLSessionDataTask *task = [manager GET:strUrl parameters:dicParams progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                if (success) {
                    success(responseObject);
                }
                
            } else {
                if (failure) {
                    failure(nil);
                }
                
                NSLog(@"%@ -> 返回数据格式错误", strUrl);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) {
                failure(error);
            }
        }];
        
        DLog(@"%@",task);
    }
}
@end
