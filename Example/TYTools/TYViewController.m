//
//  TYViewController.m
//  TYTools
//
//  Created by tianyu on 08/02/2019.
//  Copyright (c) 2019 tianyu. All rights reserved.
//

#import "TYViewController.h"
#import <TYTools/NSString+TYStringExtension.h>
#import <TYTools/TYUIMacro.h>
#import <TYTools/TYDeviceMacro.h>

@interface TYViewController ()

@end

@implementation TYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString * timeStr = @"34523413525";
    NSLog(@"%@",[timeStr stringToDate]);
    NSLog(@"%@",[timeStr returnChinaTimeData]);
    if (UI_IS_IPHONE_X) {
        TYLog(@"%@", @"是");
    } else {
        TYLog(@"不是");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
