//
//  KBNSDictionaryAddtions.m
//  MuTouApp
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//


#import "KBNSDictionaryAddtions.h"
#import <objc/runtime.h>
#import "CommonDefine.h"
#import "KBNSObjectAdditions.h"

@implementation NSDictionary (NSDictionaryAddtions)
/**
 *  安全的数组
 */
- (id)objectForKeyForSafetyArray:(id)aKey
{
    if ([self isNilObj] || self.count <= 0) {
        return [NSArray array];
    }
    
    //  校验是否为空
    if ([self isKeyOrValueNil:aKey]) {
        return [NSArray array];
    }
    
    return [self objectForKey:aKey];
}

/**
 *  安全的字典
 */
- (id)objectForKeyForSafetyDictionary:(id)aKey
{
    if ([self isNilObj] || self.count <= 0) {
        return [NSDictionary dictionary];
    }
    //  校验是否为空
    if ([self isKeyOrValueNil:aKey]) {
        return [NSDictionary dictionary];
    }
    
    return [self objectForKey:aKey];
}

/**
 *  安全的值
 */
- (id)objectForKeyForSafetyValue:(id)aKey
{
    if ([self isNilObj] || self.count <= 0) {
        return @"";
    }
    
    //  校验是否为空
    if ([self isKeyOrValueNil:aKey]) {
        return @"";
    }
    
    return [self objectForKey:aKey];
}

/**
 *  判断key 或 value 是否为nil
 */
- (BOOL)isKeyOrValueNil:(id)aKey
{
    //  判断key是否为空
    if (![self objectForKey:aKey]) {
        return YES;
    }
    //  得到key对应object
    id obj = [self objectForKey:aKey];
    
    return [obj isNilObj];
}

@end

@implementation NSMutableDictionary (Extension)
/**
 *  校验设置object是否object为nil
 */
- (void)setObjectJudgeNil:(id)anObject forKey:(id)aKey
{
    id aObject = anObject;
    
    if ([anObject isNilObj]) {
        aObject = [NSNull null];
    }
    
    [self setObject:aObject forKey:aKey];
}
@end
