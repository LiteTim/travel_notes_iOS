//
//  Created by Tmoson on 2017/12/20.
//  Copyright © 2017年 xunmei. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface UIImage (KBUIImageAdditions)
/**
    如果会产生崩溃，image执行toJPGImageWithCompressionQuality转换成jpg，再调用
 
    demo
    self.bgView.image = [[[mainWindow() createImageWithScale:2.f] toJPGImageWithCompressionQuality:1.f] 
                                                                                      gaussianBlur:0.4];
    vImage高斯模糊 0 < blur < 1.f
 */
- (UIImage *)kbGaussianBlur:(CGFloat)blur;
/**
 *  把图片写入某个文件中
 *
 *  @param filePath           如： file://xxx/xxx.jpg
 *  @param compressionQuality 图片质量，0～1，JPG文件有效
 */
- (BOOL)writeImageToFilePath:(NSString*)filePath
          compressionQuality:(CGFloat)compressionQuality;
/**
 *  转化成jpg格式
 */
- (UIImage*)toJPGImageWithCompressionQuality:(CGFloat)compressionQuality;
@end

