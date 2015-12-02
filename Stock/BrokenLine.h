//
//  BrokenLine.h
//  Stock
//
//  Created by 李旗 on 15/12/2.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrokenLine : UIView
{
    
    double m_margin_left;
    double m_margin_y;
    double minute;
    double price_x_end;
}
- (id)initWithFrame:(CGRect)frame :(NSArray *)unit_prices :(double)prop;

@end
