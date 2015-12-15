//
//  LabelData.m
//  Stock
//
//  Created by 李旗 on 15/12/8.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "LabelData.h"

@implementation LabelData
-(id)initWithFrame:(CGRect)frame :(NSString *)today_begin :(NSString *)yesterday :(NSString *)label_highest :(NSString *)label_lowest :(NSString *)today_now
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self creat_label :(NSString *)today_begin :(NSString *)yesterday :(NSString *)label_highest :(NSString *)label_lowest :(NSString *)today_now];
    }
    return self;
}

-(UILabel *)creat_label_with_title :(NSString *)title :(CGRect)frame//创建label的方法
{
    UILabel *label_with_title = [[UILabel alloc]initWithFrame:frame];
    label_with_title.text = title;
    label_with_title.textColor = [UIColor whiteColor];
    label_with_title.backgroundColor = [UIColor clearColor];
    label_with_title.textAlignment = NSTextAlignmentRight;
    [self addSubview:label_with_title];
    return label_with_title;
}

-(void)creat_label :(NSString *)today_begin :(NSString *)yesterday :(NSString *)label_highest :(NSString *)label_lowest :(NSString *)today_now  //创建label
{
    [self creat_label_with_title:@"今开" :CGRectMake(170,70,40,40)];
    [self creat_label_with_title:@"昨收" :CGRectMake(290,70,40,40)];
    [self creat_label_with_title:@"成交量" :CGRectMake(157,122,70,40)];
    [self creat_label_with_title:@"换手率" :CGRectMake(277,122,70,40)];
    [self creat_label_with_title:@"最   高" :CGRectMake(10,200,60,40)];
    [self creat_label_with_title:@"最   低" :CGRectMake(120,200,60,40)];
    [self creat_label_with_title:@"成交额" :CGRectMake(240,200,60,40)];
    [self creat_label_with_title:@"内   盘" :CGRectMake(10,230,60,40)];
    [self creat_label_with_title:@"外   盘" :CGRectMake(120,230,60,40)];
    [self creat_label_with_title:@"总市值" :CGRectMake(240,230,60,40)];
    [self creat_label_with_title:@"市盈率" :CGRectMake(10,260,60,40)];
    [self creat_label_with_title:@"振   幅" :CGRectMake(120,260,60,40)];
    [self creat_label_with_title:@"流通市值" :CGRectMake(250,260,70,40)];
    [self creat_label_with_title:today_begin :CGRectMake(150,91,60,40)];
    [self creat_label_with_title:yesterday :CGRectMake(270,91,60,40)];
    [self creat_label_with_title:@"－－" :CGRectMake(110,143,100,40)];
    [self creat_label_with_title:@"－－" :CGRectMake(230,143,100,40)];
    [self creat_label_with_title:label_highest :CGRectMake(61,200,60,40)];
    [self creat_label_with_title:label_lowest :CGRectMake(171,200,60,40)];
    [self creat_label_with_title:@"－－" :CGRectMake(270,200,100,40)];
    [self creat_label_with_title:@"－－" :CGRectMake(61,230,60,40)];
    [self creat_label_with_title:@"－－" :CGRectMake(131,230,100,40)];
    [self creat_label_with_title:@"－－" :CGRectMake(270,230,100,40)];
    [self creat_label_with_title:@"－－" :CGRectMake(61,260,60,40)];
    [self creat_label_with_title:@"－－" :CGRectMake(131,260,100,40)];
    [self creat_label_with_title:@"－－" :CGRectMake(270,260,100,40)];
    UILabel *label_now =  [self creat_label_with_title:today_now :CGRectMake(20,60,110,110)];
    label_now.font = [UIFont boldSystemFontOfSize:50];
    label_now.textColor = [UIColor greenColor];
}


@end
