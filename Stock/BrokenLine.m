//
//  BrokenLine.m
//  Stock
//
//  Created by 李旗 on 15/12/2.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "BrokenLine.h"
@implementation BrokenLine

- (id)initWithFrame:(CGRect)frame :(NSArray *)unit_prices :(double)prop
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_margin_left = 20;
        m_margin_y = 30;
        minute = (self.frame.size.width-m_margin_left*2)/240;
        
        UIImage *broken_image = [self draw_broken_line:unit_prices :prop];
        UIImageView *briken_imageview = [[UIImageView alloc]initWithImage:broken_image];
        [self addSubview:briken_imageview];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(UIImage *)draw_broken_line :(NSArray *)unit_price :(double)prop
{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);//线条颜色
    CGContextSetLineWidth(context, 1.0);//线条宽度
    
    CGContextMoveToPoint(context, m_margin_left,(230-m_margin_y)/2);//开始画线, x，y 为开始点的坐标
    for (int i = 1; i < unit_price.count ; i++)
    {
      double difference =  [[unit_price objectAtIndex:i]doubleValue]-[[unit_price objectAtIndex:0]doubleValue];
        
        double price_y_end = (230
                              - m_margin_y )/2 - difference/prop;
     
        price_x_end = m_margin_left+ i *minute;//x轴结束的坐标
        CGContextAddLineToPoint(context, price_x_end,price_y_end );//画直线, x，y 为线条结束点的坐标
    }
    CGContextStrokePath(context);//画线
    UIImage *broken_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  broken_image;
    
}

@end
