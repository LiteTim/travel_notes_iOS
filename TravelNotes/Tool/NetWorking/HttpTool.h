//
//  HttpTool.h
//  ShiTou_App
//
//  Created by gjfax on 16/4/13.
//  Copyright © 2016年 ShiTou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetworkingClient.h"


@interface HttpTool : NSObject


#pragma mark - 常规请求

+ (void)postUrl:(NSString *)strUrl
         params:(NSDictionary *)dicParams
        success:(void (^)(id response))success
        failure:(void (^)(NSError *error))failure;

+ (void)getUrl:(NSString *)strUrl
        params:(NSDictionary *)dicParams
       success:(void (^)(id response))success
       failure:(void (^)(NSError *error))failure;
@end
