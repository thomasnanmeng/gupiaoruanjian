//
//  AppDelegate.h
//  Stock
//
//  Created by 李旗 on 15/11/27.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "Chart.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)ViewController *viewController;
@property (strong, nonatomic)Chart *chart;

@end

