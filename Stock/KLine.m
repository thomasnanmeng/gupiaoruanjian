//
//  KLine.m
//  Stock
//
//  Created by 李旗 on 15/12/1.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "KLine.h"
#import "GetData.h"

@implementation KLine
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_margin_left= 20;
    }
    return self;
}

-(UIImage *)drawRect :(double)begin :(double)end :(double)highest :(double)lowest
{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);//线条颜色
    CGContextSetLineWidth(context, 5.0);//线条宽度
    
    CGContextMoveToPoint(context, m_margin_left+2.0,begin);//开始画线, x，y 为开始点的坐标
    CGContextAddLineToPoint(context, m_margin_left+2.0, end);//画直线, x，y 为线条结束点的坐标


    CGContextStrokePath(context); //开始画线  画的是粗线
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//线条颜色
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, m_margin_left+2.0,highest);//开始画线, x，y 为开始点的坐标
    CGContextAddLineToPoint(context, m_margin_left+2.0, lowest);//画直线, x，y 为线条结束点的坐标
    CGContextStrokePath(context); //开始画线   画的是细线
    UIImage *kline_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  kline_image;
}

//}
@end
