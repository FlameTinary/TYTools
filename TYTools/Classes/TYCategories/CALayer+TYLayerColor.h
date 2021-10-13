//
//  CALayer+TYLayerColor.h
//  TYToolSet
//
//  Created by user001 on 2018/3/28.
//  Copyright © 2018年 Sheldon. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (TYLayerColor)
// 解决使用xib设置border color
- (void)setBorderColorFromUIColor:(UIColor *)color;
@end
