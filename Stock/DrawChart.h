//
//  StockInfor.h
//  Stock
//
//  Created by 李旗 on 15/11/30.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawChart : UIView
{
    
    int m_row;
    int m_column;
    double m_margin_left;
    double m_margin_y;
}
-(id)initWithFrame:(CGRect)frame :(double)chart_height;


@end

