//
//  KLine.h
//  Stock
//
//  Created by 李旗 on 15/12/1.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllKLine : UIView
{
    
    double m_margin_left;
    double m_margin_y;
    double max;
    double min;
    double kline_proportion;

}
-(id)initWithFrame:(CGRect)frame :(NSArray *)begin :(NSArray *)end :(NSArray *)highest :(NSArray *)lowest :(double)chart_height :(double)line_with_cu :(double)line_with_xi :(double)spacing;
@end
