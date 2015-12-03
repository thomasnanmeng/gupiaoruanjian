    //
//  ImageViewController.m
//  Stock
//
//  Created by 李旗 on 15/12/3.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "ImageViewController.h"
#import "StockInfor.h"
#import "KLine.h"
#import "GetData.h"
#import "BrokenLine.h"


@implementation ImageViewController
- (id) initWithCode :(NSString *)code
{
    self = [super init];
    if (self)
    {
        stock_code = code;
    }
    return self;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    StockInfor *stock = [[StockInfor alloc]initWithFrame:self.view.frame :200];
    stock.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:stock];
    

    KLine *kline = [[KLine alloc]initWithFrame:self.view.frame];
    UIImage *kline_image = [kline drawRect:100 :200 :50 :250];
    kline.backgroundColor = [UIColor clearColor];
    UIImageView *imageKline = [[UIImageView alloc]initWithImage:kline_image];
    [self.view addSubview:imageKline];
    //表格的imageview
    NSString *text = @"sh600600";
    GetData *data = [[GetData alloc]init];
    NSDictionary *dataSource = [data get_miniute_data:200:stock_code];
    price_arr = [dataSource objectForKey:@"价格数组"];
    proportion = [[dataSource objectForKey:@"比例"]doubleValue];
    //调用GetData里需要的数据
    
    BrokenLine *brokenLine = [[BrokenLine alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-230, self.view.frame.size.width, 230) :price_arr :proportion];
    [self.view addSubview:brokenLine];
    //

}
@end
