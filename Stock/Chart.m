//
//  Chart.m
//  Stock
//
//  Created by 李旗 on 15/11/27.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "Chart.h"

@implementation Chart

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_margin_left = 20;
        m_row = 4;
        m_column = 3;
        
        [self creat_label];
        [self toolbar_with_button];
//        [self drawRect:frame];
    }
    return self;
}


-(void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);//线条颜色
    CGContextSetLineWidth(context, 1.0);//线条宽度
    CGContextAddRect(context, CGRectMake(20, 370, 320, 240));
    CGContextMoveToPoint(context, 20, 490);//开始画线, x，y 为开始点的坐标
    CGContextAddLineToPoint(context, 340, 490);//画直线, x，y 为线条结束点的坐标
    CGContextMoveToPoint(context, 20, 430);
    CGContextAddLineToPoint(context, 340, 430);
    CGContextMoveToPoint(context, 20, 550);
    CGContextAddLineToPoint(context, 340, 550);
    
    
    CGContextMoveToPoint(context, 130, 370);
    CGContextAddLineToPoint(context,130, 610);
    CGContextMoveToPoint(context, 230, 370);
    CGContextAddLineToPoint(context, 230, 610);
    CGContextStrokePath(context); //开始画线
}
-(UILabel *)creat_label_with_title :(NSString *)title :(CGRect)frame
{
    UILabel *label_with_title = [[UILabel alloc]initWithFrame:frame];
    label_with_title.text = title;
    label_with_title.textColor = [UIColor whiteColor];
    label_with_title.backgroundColor = [UIColor redColor];
    [self addSubview:label_with_title];
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
    [self addSubview:toolbar];
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




//-(void)drawRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);//线条颜色
//    CGContextSetLineWidth(context, 1.0);//线条宽度
//    CGContextAddRect(context, CGRectMake(20, 370, 320, 240));
//    CGContextMoveToPoint(context, 20, 490);//开始画线, x，y 为开始点的坐标
//    CGContextAddLineToPoint(context, 340, 490);//画直线, x，y 为线条结束点的坐标
//    CGContextMoveToPoint(context, 20, 430);
//    CGContextAddLineToPoint(context, 340, 430);
//    CGContextMoveToPoint(context, 20, 550);
//    CGContextAddLineToPoint(context, 340, 550);
//    
//    
//    CGContextMoveToPoint(context, 130, 370);
//    CGContextAddLineToPoint(context,130, 610);
//    CGContextMoveToPoint(context, 230, 370);
//    CGContextAddLineToPoint(context, 230, 610);
//    CGContextStrokePath(context); //开始画线
//}
@end
