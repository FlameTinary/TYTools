//
//  TYTools.m
//  TYToolSet
//
//  Created by user001 on 2018/3/29.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import "TYDeviceInfo.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "sys/utsname.h"

@implementation TYDeviceInfo

/*******************Device相关*******************/

//设备唯一标识符
+ (NSString *)identifierString
{
    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return identifierStr;
}
//手机别名： 用户定义的名称
+ (NSString *)userPhoneName
{
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    return userPhoneName;
}
//设备名称
+ (NSString *)deviceName
{
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
}
//手机系统版本
+ (NSString *)phoneVersion
{
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
}
//地方型号  （国际化区域名称）
+ (NSString *)localPhoneModel
{
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    return localPhoneModel;
}
// 当前应用软件版本  比如：1.0.1
+ (NSString *)appCurVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appCurVersion;
}
// 当前应用版本号码   int类型
+ (NSString *)appCurVersionNum
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    return appCurVersionNum;
}
//设备尺寸
+ (CGSize)deviceSize
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    return size;
}
//设备分辨率
+ (CGSize)deviceResolutionRatio
{
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    CGSize size = [TYDeviceInfo deviceSize];
    return CGSizeMake(size.width*scale_screen, size.height*scale_screen);
}

//运营商
+ (NSString *)deviceOperator
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    return carrier.carrierName;
}
//获取设备型号
+ (NSString*)deviceEquipment
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone12,1"])   return @"iPhone 11";
    if ([deviceModel isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";
    if ([deviceModel isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    if ([deviceModel isEqualToString:@"iPhone12,8"]) return @"iPhone SE (2nd generation)";
    if ([deviceModel isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([deviceModel isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([deviceModel isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([deviceModel isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    
    if ([deviceModel isEqualToString:@"iPhone14,4"]) return @"iPhone 13 mini";
    if ([deviceModel isEqualToString:@"iPhone14,5"]) return @"iPhone 13";
    if ([deviceModel isEqualToString:@"iPhone14,2"]) return @"iPhone 13 Pro";
    if ([deviceModel isEqualToString:@"iPhone14,3"]) return @"iPhone 13 Pro Max";
    
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPod7,1"])      return @"iPod Touch (6 Gen)";
    if ([deviceModel isEqualToString:@"iPod9,1"])      return @"iPod Touch (7 Gen)";
    
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad11,1"])      return @"iPad Mini 5 (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad11,2"])      return @"iPad Mini 5 (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad14,1"])      return @"iPad Mini 6 (6 Gen)";
    if ([deviceModel isEqualToString:@"iPad14,2"])      return @"iPad Mini 6 (6 Gen)";
    
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9 (2 Gen)";
    if ([deviceModel isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9 (2 Gen)";
    if ([deviceModel isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5";
    if ([deviceModel isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5";
    if ([deviceModel isEqualToString:@"iPad8,1"])      return @"iPad Pro 11.0";
    if ([deviceModel isEqualToString:@"iPad8,2"])      return @"iPad Pro 11.0";
    if ([deviceModel isEqualToString:@"iPad8,3"])      return @"iPad Pro 11.0";
    if ([deviceModel isEqualToString:@"iPad8,4"])      return @"iPad Pro 11.0";
    if ([deviceModel isEqualToString:@"iPad8,5"])      return @"iPad Pro 12.9 (3 Gen)";
    if ([deviceModel isEqualToString:@"iPad8,6"])      return @"iPad Pro 12.9 (3 Gen)";
    if ([deviceModel isEqualToString:@"iPad8,7"])      return @"iPad Pro 12.9 (3 Gen)";
    if ([deviceModel isEqualToString:@"iPad8,8"])      return @"iPad Pro 12.9 (3 Gen)";
    if ([deviceModel isEqualToString:@"iPad8,9"])      return @"iPad Pro 11.0 (2 Gen)";
    if ([deviceModel isEqualToString:@"iPad8,10"])      return @"iPad Pro 11.0 (2 Gen)";
    if ([deviceModel isEqualToString:@"iPad8,11"])      return @"iPad Pro 12.9 (4 Gen)";
    if ([deviceModel isEqualToString:@"iPad8,12"])      return @"iPad Pro 12.9 (4 Gen)";
    
    if ([deviceModel isEqualToString:@"iPad13,4"])      return @"iPad Pro 11.0 (3 Gen)";
    if ([deviceModel isEqualToString:@"iPad13,5"])      return @"iPad Pro 11.0 (3 Gen)";
    if ([deviceModel isEqualToString:@"iPad13,6"])      return @"iPad Pro 11.0 (3 Gen)";
    if ([deviceModel isEqualToString:@"iPad13,7"])      return @"iPad Pro 11.0 (3 Gen)";
    if ([deviceModel isEqualToString:@"iPad13,8"])      return @"iPad Pro 12.9 (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad13,9"])      return @"iPad Pro 12.9 (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad13,10"])      return @"iPad Pro 12.9 (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad13,11"])      return @"iPad Pro 12.9 (5 Gen)";
    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    if ([deviceModel isEqualToString:@"arm64"])        return @"Simulator";
    return deviceModel;
}

@end
