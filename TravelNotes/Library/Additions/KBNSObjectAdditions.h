//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/**
 *  数据校验
 */
NSString* kbToString(id obj);

NSArray* kbToArray(id obj);

NSDictionary* kbToDictionary(id obj);

NSMutableArray* kbToMutableArray(id obj);

NSMutableDictionary* kbToMutableDictionary(id obj);

@interface NSObject (KBNSObjectAdditions)

#pragma mark - 空对象判断
/**
 *  适用于判断对象的 Value值，对象都是nil的话，不会进入该方法
 *
 *  @return BOOL
 */
- (BOOL)isNilObj;

/**
 *  通过NSDictionary初始化property
 *  为什么要增加这个，目的是避免服务器数据类型错误的问题
 *  @param item item
 */
- (void)kbAutoSetPropertySafety:(NSDictionary *)item;

/**
 *  重置所有property
 */
- (void)kbResetAllProperty;

/**
 *  获取当前class的property和value
 */
- (NSDictionary*)kbAllPropertiestAndValues;


- (void)kbSetPropery:(NSString*)attriString
               value:(id)value
        propertyName:(NSString*)propertyName;


- (NSString*)kbJsonEncode;

- (id)kbObjectFortKeySafe:(NSString*)key;

- (id)kbObjectIndexSafe:(NSUInteger)index;

@end
