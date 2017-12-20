//
//  KBNSDictionaryAddtions.h
//  MuTouApp
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSDictionaryAddtions)

/**
 *  安全的数组
 */
- (id)objectForKeyForSafetyArray:(id)aKey;

/**
 *  安全的字典
 */
- (id)objectForKeyForSafetyDictionary:(id)aKey;

/**
 *  安全的值
 */
- (id)objectForKeyForSafetyValue:(id)aKey;

@end


#pragma mark - 扩展setObject:  forKey:
@interface NSMutableDictionary (Extension)
/**
 *  校验设置object是否object为nil
 */
- (void)setObjectJudgeNil:(id)anObject forKey:(id)aKey;
@end
