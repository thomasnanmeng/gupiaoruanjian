//
//  StockInfor.m
//  Stock
//
//  Created by 李旗 on 15/11/30.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "StockInfor.h"

@implementation StockInfor
-(id)initWithFrame:(CGRect)frame :(double) chart_height
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_margin_left = 20;
        m_row = 4;
        m_column = 3;
        m_margin_y = 30;
        UIImage *chart_image = [self draw_chart:chart_height];
        UIImageView *chart_imageview = [[UIImageView alloc]initWithImage:chart_image];
        [self addSubview:chart_imageview];
    }
    return self;
}
-(UIImage *)draw_chart :(double) chart_height
{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);//线条颜色
    CGContextSetLineWidth(context, 1.0);//线条宽度
    CGContextAddRect(context, CGRectMake(m_margin_left, self.frame.size.height-m_margin_y-chart_height, self.frame.size.width-m_margin_left*2, chart_height));
    
    CGContextMoveToPoint(context, m_margin_left,self.frame.size.height-m_margin_y-chart_height/m_row);//开始画线, x，y 为开始点的坐标
    CGContextAddLineToPoint(context, self.frame.size.width-m_margin_left, self.frame.size.height-m_margin_y-chart_height/m_row);//画直线, x，y 为线条结束点的坐标
    CGContextMoveToPoint(context, m_margin_left,self.frame.size.height-m_margin_y-chart_height/m_row*2);
    CGContextAddLineToPoint(context, self.frame.size.width-m_margin_left, self.frame.size.height-m_margin_y-chart_height/2);
    CGContextMoveToPoint(context, m_margin_left,self.frame.size.height-m_margin_y-chart_height/m_row*3);
    CGContextAddLineToPoint(context, self.frame.size.width-m_margin_left, self.frame.size.height-m_margin_y-chart_height/m_row*3);
    
    
    CGContextMoveToPoint(context, (self.frame.size.width-m_margin_left*2)/m_column+m_margin_left,self.frame.size.height-m_margin_y);
    CGContextAddLineToPoint(context, (self.frame.size.width-m_margin_left*2)/m_column+m_margin_left, self.frame.size.height-m_margin_y-chart_height);
    CGContextMoveToPoint(context, self.frame.size.width-(self.frame.size.width-m_margin_left*2)/m_column-m_margin_left,self.frame.size.height-m_margin_y);
    CGContextAddLineToPoint(context, self.frame.size.width-(self.frame.size.width-m_margin_left*2)/m_column-m_margin_left, self.frame.size.height-m_margin_y-chart_height);
    
    CGContextStrokePath(context); //开始画线
    UIImage *draw_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  draw_image;
}


@end
