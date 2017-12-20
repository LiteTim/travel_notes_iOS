//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

#import "KBNSStringAdditions.h"
#import <commoncrypto/CommonDigest.h>
#import "CommonDefine.h"
#import "KBNSObjectAdditions.h"

@implementation NSString (KBNSStringAdditions)

- (NSString *)kbMD5
{
    const char *str = [self UTF8String];
    unsigned char res[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str,(CC_LONG)strlen(str), res);
    NSMutableString *m = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [m appendFormat:@"%02x",res[i]];
    }
    return m;
}

- (id)kbJsonDecode {
    if(![self isKindOfClass:[NSString class]]) return nil;
    NSData *data =  [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error=nil;
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:NSJSONReadingMutableContainers error:&error];
}

- (CGFloat)heightWithFont:(UIFont*)font width:(CGFloat)width
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize sizeToFit = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                           options:NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading
                                        attributes:attributes context:nil].size;
    
    return sizeToFit.height;
}

- (CGSize)textSizeWithFont:(UIFont *)font
         constrainedToSize:(CGSize)size
{
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        
        textSize = [self sizeWithAttributes:attributes];
    }
    else
    {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（注：字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}


- (CGSize)getTextSize:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    
    CGSize textSize;
    
    textSize = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                  options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                               attributes:@{NSFontAttributeName: font}
                                  context:nil].size;
    
    return textSize;
}

/**
 *  计算字符串宽度(指当该字符串放在view时的自适应宽度)
 *
 *  @param size 填入预留的大小
 *  @parafontOfSizent 字体大小
 *  @param isBold 字体是否加粗
 *
 *  @return 返回CGRect
 */
- (CGRect)stringWidthRectWithSize:(CGSize)size fontOfSize:(CGFloat)fontOfSize isBold:(BOOL)isBold{
    NSDictionary * attributes;
    if (isBold) {
        attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:fontOfSize]};
    }else{
        attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:fontOfSize]};
    }
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}




/**
 *  string 转 date
 *
 *  @param dateFormat 日期格式  eg：yyyy-MM-dd   HH:mm
 *
 *  @return date
 */
- (NSDate *)dateWithDateFormat:(NSString *)dateFormat
{
    if ([self isNilObj]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:dateFormat]; //@"yyyy-MM-dd"
        NSDate *destDate = [dateFormatter dateFromString:self];
        
        return destDate;
    }
    return nil;
}



#pragma mark - 正则表达式

- (BOOL)isEmailFormat
{
    NSString *judgeRole = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isMobilePhoneNumFormat
{
    //  14x[数据卡号段] 17xx[虚拟运营商号段]
    /**
     * 手机号码
     * 移动：134[0-8] 13[5-9] 150 151 152 157 158 159 182 183 184 187 188
     * 联通：130 131 132 155 156 185 186
     * 电信：133 1349[卫通] 153 180 181 189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9]|7[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8] 13[5-9] 150 151 152 157 158 159 182 183 184 187 188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[0-27-9]|8[2-478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349[卫通],153,180,181,189
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        if([regextestcm evaluateWithObject:self] == YES) {
            DLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:self] == YES) {
            DLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:self] == YES) {
            DLog(@"China Unicom");
        } else {
            DLog(@"Unknow");
        }
        
        return YES;
    }
    
    return NO;
}

- (BOOL)isIDCardFormat
{
    if (self.length <= 0) {
        return NO;
    }
    
    NSString *judgeRole = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isOnlyNumberFormat
{
    NSString *judgeRole = @"^[0-9]*[1-9][0-9]*$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    
    return [predicate evaluateWithObject:self];
}

- (BOOL)isPasswordWithoutSymbolFormat
{
    NSString *judgeRole = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", judgeRole];
    
    return [predicate evaluateWithObject:self];
}

@end
