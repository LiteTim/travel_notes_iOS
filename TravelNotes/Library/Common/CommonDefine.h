//
//  CommonDefine.h
//  TravelNotes
//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//

/**
 *  一些公共属性define
 */

//  打印日志
#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...) nil
#endif

#ifdef DEBUG
#else
#define NSLog(...) {}
#endif

//  weakSelf
#define kWeakSelf  __weak typeof(self) weakSelf = self;
//-----------------------------------  颜色  ------------------------------------
// e.g. HEXCOLOR(0xCECECE);
#define HEXCOLOR(rgbValue)  [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// e.g. HEXCOLORA(0xCECECE, 0.8);
#define HEXCOLORA(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColorAlpha(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
// 随机颜色
#define RandomColor RGBColor(arc4random() % 256, arc4random() % 256, arc4random() % 256)
//  天蓝色
#define CommonColor_SkyBlue            RGBColor(69, 181, 244)
//  浅绿色
#define CommonColor_LightGreen         RGBColor(151, 208, 69)
//  灰黑色 字体颜色
#define CommonColor_LightBlack         RGBColor(117, 117, 117)
//  浅灰色 字体颜色
#define CommonColor_LightGrayBlack     RGBColor(150, 150, 150)
//  灰色
#define CommonColor_GrayBlack          RGBColor(200, 200, 200)
//  浅灰色
#define CommonColor_LightGray          RGBColor(243, 243, 243)
//  蓝色
#define CommonColor_Blue               RGBColor(33, 150, 243)
//  灰线颜色
#define CommonColor_grayLine           RGBColor(190, 190, 190)
//  蓝色 navi使用
#define CommonColor_Navi_Bg            RGBColor(58, 166, 242)

//  字体大小
#define CommonFont_(x)             [UIFont systemFontOfSize:x]
//  自适应字体大小
#define CommonFontAutoFix_(x)      [UIFont systemFontOfSize:Relative_x(x)]


//-----------------------------------  旋转角度  ------------------------------------
#define DegreesToRadians(degrees)             degrees*M_PI/180
#define RadiansToDegrees(radians)             radians*180/M_PI

//-----------------------------------  设备的宽高  ------------------------------------
/**
 *  获取当前系统版本
 */
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//  是否高于ios8
#define IOS_8_UP ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

#define APP_SCREEN_BOUNDS    [UIScreen mainScreen].bounds
#define APP_SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define APP_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height

//  状态栏
#define STATUS_BAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//  navi
#define NAVI_HEIGHT self.navigationController.navigationBar.bounds.size.height
//  状态栏 + navi 高度
#define NAVI_STATUS_HEIGHT STATUS_BAR_HEIGHT + NAVI_HEIGHT
// 在iPhone 上 x 轴的相对比例(iPhone 7为标准屏)
#define Relative_x(x) (x * APP_SCREEN_WIDTH)/375.f
// 在iPhone 上 y 轴的相对比例(iPhone 7为标准屏)
#define Relative_y(y) (y * APP_SCREEN_HEIGHT)/667.f

//----------------------------------- 是否会打印log ------------------------------------
#ifdef  DEBUG
#define NSLog(fmt, ...)		NSLog((@"%@ [Line: %d] %s " fmt),[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, ##__VA_ARGS__)
#else
#define NSLog(...)
#endif


#pragma mark -- 数据校验
/**
 *  安全获取字符串
 */
#define NSStringSafety(obj) \
[obj isKindOfClass:[NSObject class]] ? [NSString stringWithFormat:@"%@",obj] : @""

/**
 *  安全获取字典中的Value
 */
#define ObjectForKeySafety(obj,key) \
[obj isKindOfClass:[NSDictionary class]] && ![[obj objectForKey:key] isKindOfClass:[NSNull class]] ? [obj objectForKey:key]:nil

/**
 *  安全获取数组中的Value
 */
#define ObjectIndexSafety(obj,index) \
[obj isKindOfClass:[NSArray class]] && index < [obj count] && ![[obj objectAtIndex:index] isKindOfClass:[NSNull class]] ? [obj objectAtIndex:index] :nil
/**
 *  提示用户信息，默认点击消失，2S存在时间
 *
 */
#define Show_iToast(string) [HUDLoading showMsgHUD:string duration:2.f touchClose:YES];
/**
 *  格式化字符串
 *
 *  @param format 格式符串
 *  @param ...    参数列表
 *
 *  @return 格式化了的字符串
 */
#define FMT_STR(format, ...) [NSString stringWithFormat:format, ##__VA_ARGS__]

