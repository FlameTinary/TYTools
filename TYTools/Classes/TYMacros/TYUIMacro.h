//
//  TYUIMacro.h
//  Pods
//
//  Created by TianYu on 2021/10/13.
//

#ifndef TYUIMacro_h
#define TYUIMacro_h

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define kScreenScale [UIScreen mainScreen].scale
// statusBar高度 (状态栏) （49） 与APP状态有关(后台地图、打开热点等…)
#define stautsBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height)
// tabBar高度 （49）
#define TabBar_HEIGHT 49
// NavigationBar高度 （44）
#define NavigationBar_HEIGHT 44
#define naviBarHeight (self.navigationController.navigationBar.frame.size.height)
// 由角度转换为弧度
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
// 由弧度转换为角度
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)


/**
 Synthesize a weak or strong reference.
 
 Example:
    @weakify(self)
    [self doSomething^{
        @strongify(self)
        if (!self) return;
        ...
    }];

 */

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif


// 设置 view 圆角和边框
#define TYViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]


//获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


#define UI_IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define UI_IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE4 (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define UI_IS_IPHONE5 (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define UI_IS_IPHONE6 (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define UI_IS_IPHONE6PLUS (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0)
#define UI_IS_IPHONE_X art_screenHasNotch()
inline static BOOL art_screenHasNotch()
{
   if(@available(iOS 11.0, *)){
       return [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0;
   }
   return NO;
}
#endif /* TYUIMacro_h */
