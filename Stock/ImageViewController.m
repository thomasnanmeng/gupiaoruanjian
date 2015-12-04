
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
    [self toolbar_with_button];
    [self button_pressed_daily];
    yesterday = [end lastObject];
    [self button_pressed_minute];//先调用一下点击按钮的时间才能获取price_arr的值
    today_begin = [price_arr objectAtIndex:0];
    today_now = [price_arr lastObject];
    [self creat_label];
    
    

}
-(void)draw_chart  //画表格
{
    DrawChart *stock = [[DrawChart alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-230, self.view.frame.size.width, 230) :200];
    stock.backgroundColor = [UIColor blackColor];
    [self.view addSubview:stock];//表格的imageview

}
-(void)draw_broken_line //画折线图
{
    [self get_minute_data];
    brokenLine = [[BrokenLine alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-230, self.view.frame.size.width, 230) :price_arr :proportion];
    [self.view addSubview:brokenLine];
   
    

}
-(void)get_minute_data  //调用minute里需要的数据
{
    GetData *data = [[GetData alloc]init];
    NSDictionary *dataSource = [data get_miniute_data:200:stock_code];
    price_arr = [dataSource objectForKey:@"价格数组"];
    proportion = [[dataSource objectForKey:@"比例"]doubleValue];
    label_highest = [dataSource objectForKey:@"最高"];
    label_lowest = [dataSource objectForKey:@"最低"];
    
}


-(void)draw_kline  //画k线图
{
    [self get_kline_data];
    kline = [[AllKLine alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-230, self.view.frame.size.width, 230) :begin :end :highest :lowest :200 :5.0 :1.0 :1.0];
    [self.view addSubview:kline];
    
}


-(void)get_kline_data      //调用k线的数据
{
    GetKLineData *kline_data = [[GetKLineData alloc]init];
    NSDictionary *kline_data_source = [kline_data get_kline_data:button_choose :stock_code :200];
    begin =[kline_data_source objectForKey:@"开始"];
    end =[kline_data_source objectForKey:@"结束"];
    highest =[kline_data_source objectForKey:@"最高"];
    lowest =[kline_data_source objectForKey:@"最低"];

    
}

-(UILabel *)creat_label_with_title :(NSString *)title :(CGRect)frame//创建label的方法
{
    UILabel *label_with_title = [[UILabel alloc]initWithFrame:frame];
    label_with_title.text = title;
    label_with_title.textColor = [UIColor whiteColor];
    label_with_title.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label_with_title];
    return label_with_title;
}
-(void)creat_label   //创建label
{
    [self creat_label_with_title:@"今开" :CGRectMake(150,70,40,40)];
    [self creat_label_with_title:@"昨收" :CGRectMake(270,70,40,40)];
    [self creat_label_with_title:@"成交额" :CGRectMake(150,152,70,40)];
    [self creat_label_with_title:@"最高" :CGRectMake(30,240,40,40)];
    [self creat_label_with_title:@"最低" :CGRectMake(130,240,40,40)];
    [self creat_label_with_title:@"成交量" :CGRectMake(240,240,60,40)];
    [self creat_label_with_title:today_begin :CGRectMake(150,111,60,40)];
    [self creat_label_with_title:yesterday :CGRectMake(270,111,60,40)];
    [self creat_label_with_title:@"" :CGRectMake(150,193,100,40)];
    [self creat_label_with_title:label_highest :CGRectMake(71,240,60,40)];
    [self creat_label_with_title:label_lowest :CGRectMake(171,240,60,40)];
    [self creat_label_with_title:@"" :CGRectMake(301,240,100,40)];
   UILabel *label_now =  [self creat_label_with_title:today_now :CGRectMake(20,100,110,110)];
    label_now.font = [UIFont boldSystemFontOfSize:40];
    label_now.textColor = [UIColor greenColor];
}
-(UIToolbar *)toolbar_with_button  //创建toolbar
{
    toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(60, 330, 240, 40)];
    btn_minute =  [self creat_toolbar_button:@"分线"  :CGRectMake(0,0,60,40)  :@selector(button_pressed_minute) :self];
    btn_daily =  [self creat_toolbar_button:@"日k线" :CGRectMake(60,0,60,40) :@selector(button_pressed_daily) :self];
    btn_week = [self creat_toolbar_button:@"周k线" :CGRectMake(120,0,60,40) :@selector(button_pressed_week) :self];
    btn_month =  [self creat_toolbar_button:@"月k线" :CGRectMake(180,0,60,40) :@selector(button_pressed_month) :self];
    [self.view addSubview:toolbar];
    return toolbar;
}
-(UIButton *)creat_toolbar_button:(NSString *)title :(CGRect)frame :(SEL)buttonPressed :(id)target  //toolbar的button的方法
{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.backgroundColor = [UIColor blackColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor blueColor].CGColor;
    button.layer.borderWidth = 1;
    [button addTarget:target action:buttonPressed forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview:button];
    return button;
}

-(void)button_pressed_minute     //分线按钮
{
    [self draw_broken_line];
    btn_minute.backgroundColor = [UIColor blueColor];
    [btn_minute setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [kline removeFromSuperview];
    [self button_color:btn_daily :btn_week :btn_month];
    
}
-(void)button_pressed_daily  //日k线按钮
{
    button_choose = @"daily";//网址先更改
    [kline removeFromSuperview];
    [self draw_kline];
    btn_daily.backgroundColor = [UIColor blueColor];
    [btn_daily setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [brokenLine removeFromSuperview];//加载k线需要吧折线图移除
    [self button_color:btn_minute :btn_week :btn_month];
    
}
-(void)button_pressed_week  //周k线按钮
{
     button_choose = @"weekly";
    [kline removeFromSuperview];
    [self draw_kline];
    btn_week.backgroundColor = [UIColor blueColor];
    [btn_week setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self button_color:btn_minute :btn_daily :btn_month];
    [brokenLine removeFromSuperview];
}
-(void)button_pressed_month //月k线按钮
{
    button_choose = @"monthly";
    [kline removeFromSuperview];
    [self draw_kline];
    btn_month.backgroundColor = [UIColor blueColor];
    [btn_month setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self button_color:btn_daily :btn_week :btn_minute];
    [brokenLine removeFromSuperview];
}
-(void)button_color :(UIButton *)button_a :(UIButton *)button_b :(UIButton *)button_c
{
    button_a.backgroundColor = [UIColor blackColor];
    button_b.backgroundColor = [UIColor blackColor];
    button_c.backgroundColor = [UIColor blackColor];
    [button_a setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button_b setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button_c setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}//点击按钮后其他按钮的颜色

@end
