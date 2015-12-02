//
//  ViewController.m
//  Stock
//
//  Created by 李旗 on 15/11/27.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "ViewController.h"
#import "Chart.h"
#import "StockInfor.h"
#import "KLine.h"
#import "BrokenLine.h"
#import "GetData.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];

    StockInfor *stock = [[StockInfor alloc]initWithFrame:self.view.frame];
    UIImage *chart_image = [stock drawRect :200];
    stock.backgroundColor = [UIColor whiteColor];
    UIImageView *imageChart = [[UIImageView alloc]initWithImage:chart_image];
    [self.view addSubview:imageChart];
    KLine *kline = [[KLine alloc]initWithFrame:self.view.frame];
    UIImage *kline_image = [kline drawRect:100 :200 :50 :250];
    kline.backgroundColor = [UIColor clearColor];
    UIImageView *imageKline = [[UIImageView alloc]initWithImage:kline_image];
    [self.view addSubview:imageKline];
    //表格的imageview
    
    GetData *data = [[GetData alloc]init];
    NSDictionary *dataSource = [data get_miniute_data:200];
    price_arr = [dataSource objectForKey:@"价格数组"];
    proportion = [[dataSource objectForKey:@"比例"]doubleValue];
    //调用GetData里需要的数据
    
    BrokenLine *brokenLine = [[BrokenLine alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-230, self.view.frame.size.width, 230) :price_arr :proportion];
//    UIImage *brokenline_image = [brokenLine draw_broken_line:test :proportion];
//    brokenLine.backgroundColor = [UIColor clearColor];
//    UIImageView *imageBroken = [[UIImageView alloc]initWithImage:brokenline_image];
//    imageBroken.frame = CGRectMake(0, self.view.frame.size.height-230, self.view.frame.size.width, 230);
    [self.view addSubview:brokenLine];
    
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
