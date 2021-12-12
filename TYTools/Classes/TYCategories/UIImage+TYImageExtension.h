//
//  UIImage+TYImageExtension.h
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到下
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};
@interface UIImage (TYImageExtension)
/*
 *  使用UIColor创建UIImage
 */
+ (UIImage *) imageWithColor: (UIColor *)color;
/** 取消UIImage的渲染模式 */
+ (UIImage *)imageRenderingModeImageNamed:(NSString *)imageName;
//改变图片大小
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
- (instancetype)resizeImageToSize:(CGSize)reSize;
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
/**
 生成渐变色image

 @param colors 多个@[color]
 @param gradientType 渐变方向
 @param imgSize 图片大小
 @return UIImage
 */
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;
@end
