    //
//  ImageViewController.m
//  Stock
//
//  Created by 李旗 on 15/12/3.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "ImageViewController.h"
#import "DrawChart.h"
#import "AllKLine.h"
#import "GetData.h"
#import "BrokenLine.h"
#import "GetKLineData.h"


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
    self.view.backgroundColor = [UIColor blackColor];
    [self draw_chart];
    [self draw_kline];
    [self draw_broken_line];
    [self creat_label];
    [self toolbar_with_button];
    

}
-(void)draw_chart
{
    DrawChart *stock = [[DrawChart alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-230, self.view.frame.size.width, 230) :200];
    stock.backgroundColor = [UIColor blackColor];
    [self.view addSubview:stock];//表格的imageview

}
-(void)draw_kline
{
    [self get_kline_data];
    AllKLine *kline = [[AllKLine alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-230, self.view.frame.size.width, 230) :begin :end :highest :lowest :200 :5.0 :1.0 :1.0];
    [self.view addSubview:kline];

}
-(void)draw_broken_line
{
    [self get_minute_data];
    BrokenLine *brokenLine = [[BrokenLine alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-230, self.view.frame.size.width, 230) :price_arr :proportion];
    [self.view addSubview:brokenLine];
    //加载折线图
    

}
-(void)get_minute_data
{
    GetData *data = [[GetData alloc]init];
    NSDictionary *dataSource = [data get_miniute_data:200:stock_code];
    price_arr = [dataSource objectForKey:@"价格数组"];
    proportion = [[dataSource objectForKey:@"比例"]doubleValue];
    //调用GetData里需要的数据
}
-(void)get_kline_data
{
    GetKLineData *kline_data = [[GetKLineData alloc]init];
    NSDictionary *kline_data_source = [kline_data get_kline_data:stock_code :200];
    begin =[kline_data_source objectForKey:@"开始"];
    end =[kline_data_source objectForKey:@"结束"];
    highest =[kline_data_source objectForKey:@"最高"];
    lowest =[kline_data_source objectForKey:@"最低"];
    //调用GetKLineData的数据
    
}

-(UILabel *)creat_label_with_title :(NSString *)title :(CGRect)frame
{
    UILabel *label_with_title = [[UILabel alloc]initWithFrame:frame];
    label_with_title.text = title;
    label_with_title.textColor = [UIColor whiteColor];
    label_with_title.backgroundColor = [UIColor redColor];
    [self.view addSubview:label_with_title];
    return label_with_title;
}
-(void)creat_label
{
    [self creat_label_with_title:@"今开" :CGRectMake(150,70,40,40)];
    [self creat_label_with_title:@"昨收" :CGRectMake(270,70,40,40)];
    [self creat_label_with_title:@"成交额" :CGRectMake(150,152,70,40)];
    [self creat_label_with_title:@"最高" :CGRectMake(30,240,40,40)];
    [self creat_label_with_title:@"最低" :CGRectMake(130,240,40,40)];
    [self creat_label_with_title:@"成交量" :CGRectMake(240,240,60,40)];
    [self creat_label_with_title:@"" :CGRectMake(150,111,40,40)];
    [self creat_label_with_title:@"" :CGRectMake(270,111,40,40)];
    [self creat_label_with_title:@"" :CGRectMake(150,193,100,40)];
    [self creat_label_with_title:@"" :CGRectMake(71,240,40,40)];
    [self creat_label_with_title:@"" :CGRectMake(171,240,40,40)];
    [self creat_label_with_title:@"" :CGRectMake(301,240,100,40)];
    [self creat_label_with_title:@"" :CGRectMake(20,100,110,110)];
}
-(UIToolbar *)toolbar_with_button
{
    toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(60, 300, 240, 40)];
    [self creat_toolbar_button:@"分线" :CGRectMake(0,0,60,40)];
    [self creat_toolbar_button:@"日k线" :CGRectMake(60,0,60,40)];
    [self creat_toolbar_button:@"周k线" :CGRectMake(120,0,60,40)];
    [self creat_toolbar_button:@"月k线" :CGRectMake(180,0,60,40)];
    [self.view addSubview:toolbar];
    return toolbar;
}
-(UIButton *)creat_toolbar_button:(NSString *)title :(CGRect)frame
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor blueColor].CGColor;
    button.layer.borderWidth = 1;
    [toolbar addSubview:button];
    return button;
}


@end
