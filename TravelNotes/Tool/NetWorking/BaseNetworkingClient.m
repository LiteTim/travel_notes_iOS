//
//  BaseNetworkingClient.m
//  HX_GJS
//
//  Created by litao on 16/1/18.
//  Copyright © 2016年 GjFax. All rights reserved.
//

#import "BaseNetworkingClient.h"
#import "CGIDefine.h"

static CGFloat const kCommonNetworkingTimeout = 15.0f;

@implementation BaseNetworkingClient

+ (instancetype)sharedClient
{
    static BaseNetworkingClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[BaseNetworkingClient alloc] initWithBaseURL:[NSURL URLWithString:MainURL]];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain",@"text/jhtml", nil];
        //  设置请求格式
        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
//        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedClient.requestSerializer.timeoutInterval = kCommonNetworkingTimeout;
//        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end
