//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import "KBNSObjectAdditions.h"
#import "CommonDefine.h"

@implementation NSObject (KBNSObjectAdditions)

#pragma mark - 空对象判断

/**
 *  适用于判断对象的 Value值，对象都是nil的话，不会进入该方法
 *
 *  @return BOOL
 */
- (BOOL)isNilObj
{
    //  判断value是否为空
    //  1.空对象指针nil
    //  2.空类指针Nil
    //  3.空对象[NSNull null]<非nil> - 不会造成容器崩溃
    //  4.空基本数据类型NULL
    //  5.空类[NSNull class]
    if ([self isEqual:[NSNull null]] || nil == self || Nil == self || NULL == self) {
        return YES;
    } else if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([self isKindOfClass:[NSString class]] && FMT_STR(@"%@", self).length <= 0) {
        return YES;
    } else if ([FMT_STR(@"%@", self) isEqualToString:@"(null)"] || [FMT_STR(@"%@", self) isEqualToString:@"<null>"]) {
        return YES;
    }
    
    return NO;
}

- (void)kbAutoSetPropertySafety:(NSDictionary *)item
{
    if (!item||![item isKindOfClass:[NSDictionary class]]) {
        return;
    }
    //获取所有property
    [self setClassProperty:[self class] withPropertyDic:item];
    if (self.superclass) {
        [self setClassProperty:self.superclass withPropertyDic:item];
    }
}

- (void)setClassProperty:(Class)class withPropertyDic:(NSDictionary*)item
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        //property名称
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id valueItem = item[propertyName];
        if (valueItem) {
            //获取该property的数据类型
            const char* attries = property_getAttributes(property);
            NSString *attrString = [NSString stringWithUTF8String:attries];
            [self kbSetPropery:attrString value:valueItem propertyName:propertyName];
        }
    }
    if(properties) free(properties);
}

- (void)kbResetAllProperty {
    //获取所有property
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        //property名称
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        //获取该property的数据类型
        const char* attries = property_getAttributes(property);
        NSString *attrString = [NSString stringWithUTF8String:attries];
        if ([attrString hasPrefix:@"T@"]) {
            [self setValue:nil forKey:propertyName];
        }
    }
    if(properties) free(properties);
}

- (void)kbSetPropery:(NSString*)attriString
               value:(id)value
        propertyName:(NSString*)propertyName{
    //kvc不支持c的数据类型，所以只能NSNumber转化，NSNumber可以  64位是TB
    if ([attriString hasPrefix:@"T@\"NSString\""]) {
        [self setValue:kbToString(value) forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"Tc"] || [attriString hasPrefix:@"TB"]) {
        //32位Tc  64位TB
        [self setValue:[NSNumber numberWithBool:[value boolValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"Ti"] || [attriString hasPrefix:@"Tq"]) {
        //32位 Ti是int 和 NSInteger  64位后，long 和  NSInteger 都是Tq， int 是Ti
        [self setValue:[NSNumber numberWithInteger:[kbToString(value) integerValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"TQ"] || [attriString hasPrefix:@"TI"]) {
        [self setValue:[NSNumber numberWithInteger:[kbToString(value) integerValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"Tl"]) { //32位 long
        [self setValue:[NSNumber numberWithLongLong:[kbToString(value) longLongValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"Tf"]) { //float
        [self setValue:[NSNumber numberWithFloat:[kbToString(value) floatValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"Td"]) { //CGFloat
        [self setValue:[NSNumber numberWithDouble:[kbToString(value) doubleValue]] forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"T@\"NSMutableArray\""]) {
        [self setValue:kbToMutableArray(value) forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"T@\"NSArray\""]) {
        [self setValue:kbToArray(value) forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"T@\"NSDictionary\""]) {
        [self setValue:kbToDictionary(value) forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"T@\"NSMutableDictionary\""]) {
        [self setValue:kbToMutableDictionary(value) forKey:propertyName];
    }
    else if ([attriString hasPrefix:@"T@\"NSNumber\""]) {
        [self setValue:@([kbToString(value) integerValue]) forKey:propertyName];
    }
}

- (NSDictionary*)kbAllPropertiestAndValues {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        //property名称
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        if ([self valueForKey:propertyName]) {
            [props setObject:[self valueForKey:propertyName] forKey:propertyName];
        }
    }
    if(properties) free(properties);
    return props;
}

- (NSString*)kbJsonEncode {
    if ([self isKindOfClass:[NSArray class]] ||
        [self isKindOfClass:[NSMutableArray class]] ||
        [self isKindOfClass:[NSDictionary class]] ||
        [self isKindOfClass:[NSMutableDictionary class]]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:&error];
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (id)kbObjectFortKeySafe:(NSString *)key {
    if ([self isKindOfClass:[NSDictionary class]] || [self isKindOfClass:[NSMutableDictionary class]]) {
        return [(NSDictionary*)self objectForKey:key];
    }
    return nil;
}

- (id)kbObjectIndexSafe:(NSUInteger)index {
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSMutableArray class]]) {
        if (index < [(NSArray*)self count]) {
            return [(NSArray*)self objectAtIndex:index];
        }
        return nil;
    }
    return nil;
}

@end


/**
 *  数据校验
 */
NSString* kbToString(id obj) {
    return [obj isKindOfClass:[NSObject class]]?[NSString stringWithFormat:@"%@",obj]:@"";
}

NSArray* kbToArray(id obj)  {
    return [obj isKindOfClass:[NSArray class]]?obj:nil;
}

NSDictionary* kbToDictionary(id obj) {
    return [obj isKindOfClass:[NSDictionary class]]?obj:nil;
}

NSMutableArray* kbToMutableArray(id obj)   {
    return [obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSMutableArray class]] ? [NSMutableArray arrayWithArray:obj] :nil;
}

NSMutableDictionary* kbToMutableDictionary(id obj)  {
    return [obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSMutableDictionary class]] ? [NSMutableDictionary dictionaryWithDictionary:obj] : nil;
}



