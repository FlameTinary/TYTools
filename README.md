# TYTools

[![CI Status](https://img.shields.io/travis/tianyu/TYTools.svg?style=flat)](https://travis-ci.org/tianyu/TYTools)
[![Version](https://img.shields.io/cocoapods/v/TYTools.svg?style=flat)](https://cocoapods.org/pods/TYTools)
[![License](https://img.shields.io/cocoapods/l/TYTools.svg?style=flat)](https://cocoapods.org/pods/TYTools)
[![Platform](https://img.shields.io/cocoapods/p/TYTools.svg?style=flat)](https://cocoapods.org/pods/TYTools)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TYTools is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TYTools'
```

## Usage
### TYPhotoPicker

**简介：** 用于获取系统相册图片和照相机拍照图片

**用法：**

导入头文件

```
#import "TYPhotoPicker.h"
```
调用方法

```
[[TYPhotoPicker sharePicker] selectPhotoSourceWithViewController:self FinishSelectImageBlcok:^(UIImage *image) {
    //dosomething;
}];
```

### TYDrawingView

**简介：** 用于在View上绘制文字，主要用于解决定时器倒计时文字晃动

**用法：**

导入头文件

```
#import "TYDrawingView.h"
```

示例：

```
TYDrawingView * drawView = [TYDrawingView new];
drawView.frame = CGRectMake(100, 200, 200, 44);
drawView.title = @"我是绘制的文字";
[self.view addSubview:drawView];
```

### CALayer+TYLayerColor

**简介：** 用于支持xib中设置borderColor

**示例：**

![Snip20180328_1](http://7xtfqf.com1.z0.glb.clouddn.com/Snip20180328_1.png)

### UIView+TYViewExtension

**简介：** UIView的扩展

### UIColor+TYColorExtension

**简介：** UIColor的扩展

随机颜色

```
+ (UIColor *)randomColor;
```

十六进制的颜色值转换为颜色UIColor（带透明度）

```
+(UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
```


十六进制的颜色值转换为颜色UIColor

```
+(UIColor*) colorWithHex:(NSInteger)hexValue;
```

### NSString+TYStringExtension

**简介：** NSString的扩展

时间字符串

```
- (NSString *)stringToDate;
```

返回年月日,时分格式的字符串

```
- (NSString *)stringToYearMonthDayHourMinuteDate;
```

倒计时 返回时间字符串

```
- (NSString *)countDownStringWithData;
```

返回中文格式的月日时分 返回中文格式的月日时分

```
- (NSString *)returnChinaTimeData;
```

比较两个日期的大小,格式为yyyy-MM-dd HH:mm:ss

```
+ (NSInteger)compareDate:(NSString *)aDate withDate:(NSString *)bDate;
```

返回自定义格式的字符串

```
- (NSString *)stringToCustomDate:(NSString *)dateString;
```
判断内容是否含有中文

```
- (BOOL)isChinese;
```

### UIImage+TYImageExtension

**简介：** UIImage的扩展

相关方法：

```
/*
 *  使用UIColor创建UIImage
 */
+ (UIImage *) imageWithColor: (UIColor *)color;
/** 取消UIImage的渲染模式 */
+ (UIImage *)imageRenderingModeImageNamed:(NSString *)imageName;
//改变图片大小
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
//图片质量压缩
+ (UIImage*)compressImg:(UIImage*)img quality:(float)qly;
//图片虚化处理
+ (UIImage *)blurrImage:(UIImage *) _image scale:(float)_scale;
//绘制图片圆角
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size;

/**
 
 *  图片左右拉伸
 *  fLeftCapWidth:  第一次拉伸的left点
 *  fTopCapHeight:  第一次拉伸的top点
 *  tempWidth:      图片最后要展示的宽度
 *  sLeftCapWidth:  第二次拉伸的left点
 *  sTopCapHeight:  第二次拉伸的top点
 */
- (UIImage *)stretchImageWithFLeftCapWidth:(CGFloat)fLeftCapWidth
                             fTopCapHeight:(CGFloat)fTopCapHeight
                                 tempWidth:(CGFloat)tempWidth
                             sLeftCapWidth:(CGFloat)sLeftCapWidth
                             sTopCapHeight:(CGFloat)sTopCapHeight;

```

### NSData+TYDataExtension

**简介：** NSData的扩展

相关方法：

```
//对象转NSData:对象必须实现NSCoding
+(NSData *)objectToData:(NSObject *)object;
//NSData转对象:对象必须实现NSCoding
+(NSObject *)dataToObject:(NSData *)data;
```

### UIButton+TYButtonExtension

**简介：** UIButton的扩展

相关：

```
/**设置点击时间间隔*/
@property (nonatomic, assign) NSTimeInterval timeInterval;
/**
 *  用于设置单个按钮不需要被hook
 */
@property (nonatomic, assign) BOOL isIgnore;
```
### TYWeakProxy
**简介** 用于定时器解耦,防止强引用


## Author

Sheldon, tinarychina@gmail.com

## License

TYTools is available under the MIT license. See the LICENSE file for more info.
