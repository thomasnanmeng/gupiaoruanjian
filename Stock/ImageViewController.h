//
//  ImageViewController.h
//  Stock
//
//  Created by 李旗 on 15/12/3.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawChart.h"
#import "AllKLine.h"
#import "GetData.h"
#import "BrokenLine.h"
#import "GetKLineData.h"

@interface ImageViewController : UIViewController
{
    NSArray *price_arr;
    double proportion;
    NSString *stock_code;
    NSArray *begin;
    NSArray *end;
    NSArray *highest;
    NSArray *lowest;
    UIToolbar *toolbar;
    UIButton *btn_minute;
    UIButton *btn_daily;
    UIButton *btn_week;
    UIButton *btn_month;
    AllKLine *kline;
    BrokenLine *brokenLine;
    NSString *button_choose;
    NSString *today_begin;
    NSString *today_now;
    NSString *yesterday;
    NSString *label_highest;
    NSString *label_lowest;
}
- (id) initWithCode :(NSString *)code;
@end
