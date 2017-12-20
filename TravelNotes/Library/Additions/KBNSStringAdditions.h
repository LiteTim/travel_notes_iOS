//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (KBNSStringAdditions)
/**
 *  当前string的md5
 */
- (NSString *)kbMD5;
/**
 *  string json 解码
 */
- (id)kbJsonDecode;
/**
 *  获取指定宽度情况下，字符串value的高度fontSize 字体的大小 andWidth 限制字符串显示区域的宽度
 */
- (CGFloat)heightWithFont:(UIFont*)font width:(CGFloat)width NS_AVAILABLE_IOS(7_0);
/**
 *  获取指定区域的size
 *  @param font font
 *  @param size size
 */
- (CGSize)textSizeWithFont:(UIFont *)font
         constrainedToSize:(CGSize)size;

- (CGSize)getTextSize:(UIFont *)font maxWidth:(CGFloat)maxWidth;

/**
 *  计算字符串宽度(指当该字符串放在view时的自适应宽度)
 *
 *  @param size 填入预留的大小
 *  @param fontOfSize 字体大小
 *  @param isBold 字体是否加粗
 *
 *  @return 返回CGRect
 */
- (CGRect)stringWidthRectWithSize:(CGSize)size fontOfSize:(CGFloat)fontOfSize isBold:(BOOL)isBold;


/**
 *  string 转 date
 *
 *  @param dateFormat 日期格式  eg：yyyy-MM-dd   HH:mm
 *
 *  @return date
 */
- (NSDate *)dateWithDateFormat:(NSString *)dateFormat;

#pragma mark - 正则表达式

/**
 *  是否是email格式
 */
- (BOOL)isEmailFormat;

/**
 *  是否是手机号码格式
 */
- (BOOL)isMobilePhoneNumFormat;

/**
 *  是否身份证格式
 */
- (BOOL)isIDCardFormat;

/**
 *  是否纯数字格式
 */
- (BOOL)isOnlyNumberFormat;

/**
 *  是否不带符号的密码格式[有字母数字组成]
 */
- (BOOL)isPasswordWithoutSymbolFormat;

@end
