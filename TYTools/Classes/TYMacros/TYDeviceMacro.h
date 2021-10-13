//
//  TYDeviceMacro.h
//  Pods
//
//  Created by TianYu on 2021/10/13.
//

#ifndef TYDeviceMacro_h
#define TYDeviceMacro_h

#define IOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
#define IOS9            ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 9.0)
#define IOS11OrLater    @available(iOS 11.0, *)
#define IOS12OrLater    @available(iOS 12.0, *)

//APP对象 （单例对象）
#define kApplication [UIApplication sharedApplication]
//主窗口 （keyWindow）
#define kKeyWindow [UIApplication sharedApplication].keyWindow
//APP对象的delegate
#define kAppDelegate [UIApplication sharedApplication].delegate
//NSUserDefaults实例化
#define kUserDefaults [NSUserDefaults standardUserDefaults]
//通知中心 （单例对象）
#define kNotificationCenter [NSNotificationCenter defaultCenter]


// APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
// 获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
// 获取沙盒的Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
// 获取沙盒的temp路径
#define kTempPath NSTemporaryDirectory()
// 获取沙盒的Cache路径
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]


#ifdef DEBUG
#define TYLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define TYLog(...)
#endif


// 字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
// 是否空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

// GCD
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

// 判断是真机还是模拟器
#if TARGET_OS_IPHONE
    //iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
    //iPhone Simulator
#endif


#endif /* TYDeviceMacro_h */
