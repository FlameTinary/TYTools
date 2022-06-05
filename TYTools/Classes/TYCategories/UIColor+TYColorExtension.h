//
//  UIColor+TYColorExtension.h
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TYColorExtension)
/// 随机颜色
+ (UIColor *)randomColor;


/// 十六进制的颜色值转换为颜色UIColor（带透明度）
/// @param hexValue 十六进制value
/// @param alphaValue 透明度 0~1
+ (UIColor*)colorWithHex:(UInt32)hexValue alpha:(CGFloat)alphaValue;


/// 十六进制的颜色值转换为颜色UIColor
/// @param hexValue 十六进制
+ (UIColor*)colorWithHex:(UInt32)hexValue;


/// 十六进制字符串转color
/// @param hexString 十六进制字符串
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
@end
