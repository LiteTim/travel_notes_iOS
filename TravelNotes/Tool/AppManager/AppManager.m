//
//  AppManager.m
//  BuglyDemo
//
//  Created by xunmei on 2017/12/26.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import "AppManager.h"
#import <Bugly/Bugly.h>

@implementation AppManager

+ (void)startWithBuglyAppId:(NSString *)appId
{
    if (appId && [appId isKindOfClass:[NSString class]]) {
        [Bugly startWithAppId:appId];
    }
}

+ (void)startWithBuglyAppId:(NSString *)appId
                     config:(BuglyManagerConfig *)config
{
    if (appId && [appId isKindOfClass:[NSString class]]){
        if (config && [config isKindOfClass:[BuglyManagerConfig class]]) {
            BuglyConfig *byConfig = [[BuglyConfig alloc] init];
            byConfig.debugMode = config.debugMode;
            byConfig.channel = config.channel;
            byConfig.version = config.version;
            byConfig.deviceIdentifier = config.deviceIdentifier;
            byConfig.blockMonitorEnable = config.blockMonitorEnable;
            byConfig.blockMonitorTimeout = config.blockMonitorTimeout;
            byConfig.applicationGroupIdentifier = config.applicationGroupIdentifier;
            byConfig.symbolicateInProcessEnable = config.symbolicateInProcessEnable;
            byConfig.unexpectedTerminatingDetectionEnable = config.unexpectedTerminatingDetectionEnable;
            byConfig.viewControllerTrackingEnable = config.viewControllerTrackingEnable;
            byConfig.excludeModuleFilter = config.excludeModuleFilter;
            byConfig.consolelogEnable = config.consolelogEnable;
            byConfig.crashAbortTimeout = config.crashAbortTimeout;
            
            [Bugly startWithAppId:appId config:byConfig];
            
        }else
        {
            [Bugly startWithAppId:appId];
        }
    }
}

+ (void)startWithBuglyAppId:(NSString *)appId
          developmentDevice:(BOOL)development
                     config:(BuglyManagerConfig *)config
{
    if (appId && [appId isKindOfClass:[NSString class]]){
        if (config && [config isKindOfClass:[BuglyManagerConfig class]]) {
            BuglyConfig *byConfig = [[BuglyConfig alloc] init];
            byConfig.debugMode = config.debugMode;
            byConfig.channel = config.channel;
            byConfig.version = config.version;
            byConfig.deviceIdentifier = config.deviceIdentifier;
            byConfig.blockMonitorEnable = config.blockMonitorEnable;
            byConfig.blockMonitorTimeout = config.blockMonitorTimeout;
            byConfig.applicationGroupIdentifier = config.applicationGroupIdentifier;
            byConfig.symbolicateInProcessEnable = config.symbolicateInProcessEnable;
            byConfig.unexpectedTerminatingDetectionEnable = config.unexpectedTerminatingDetectionEnable;
            byConfig.viewControllerTrackingEnable = config.viewControllerTrackingEnable;
            byConfig.excludeModuleFilter = config.excludeModuleFilter;
            byConfig.consolelogEnable = config.consolelogEnable;
            byConfig.crashAbortTimeout = config.crashAbortTimeout;
            
            [Bugly startWithAppId:appId developmentDevice:development config:byConfig];
            
        }else
        {
            [Bugly startWithAppId:appId];
        }
    }
}

+ (void)setUserIdentifierWithBugly:(NSString *)userId
{
    [Bugly setUserIdentifier:userId];
}

+ (void)updateAppVersionWithBugly:(NSString *)version
{
    [Bugly updateAppVersion:version];
}

+ (void)setBuglyUserValue:(NSString *)value
                   forKey:(NSString *)key
{
    [Bugly setUserValue:value forKey:key];
}

+ (NSDictionary *)allBuglyUserValues
{
    return [Bugly allUserValues];
}

+ (void)setBuglyTag:(NSUInteger)tag
{
    [Bugly setTag:tag];
}

+ (NSUInteger)currentBuglyTag
{
    return [Bugly currentTag];
}

+ (NSString *)getBuglyDeviceId
{
    return [Bugly buglyDeviceId];
}

+ (void)reportBuglyException:(NSException *)exception
{
    [Bugly reportException:exception];
}

+ (void)reportBuglyError:(NSError *)error
{
    [Bugly reportError:error];
}

+ (void)reportBuglyExceptionWithCategory:(NSUInteger)category
                                    name:(NSString *)aName
                                  reason:(NSString *)aReason
                               callStack:(NSArray *)aStackArray
                               extraInfo:(NSDictionary *)info
                            terminateApp:(BOOL)terminate
{
    [Bugly reportExceptionWithCategory:category name:aName reason:aReason callStack:aStackArray extraInfo:info terminateApp:terminate];
}

+ (NSString *)checkBuglySDKVersion
{
    return [Bugly sdkVersion];
}

+ (BOOL)isBuglyAppCrashedOnStartUpExceedTheLimit
{
    return [Bugly isAppCrashedOnStartUpExceedTheLimit];
}

@end
