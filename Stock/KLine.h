//
//  KLine.h
//  Stock
//
//  Created by 李旗 on 15/12/1.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLine : UIView
{
    
    double m_margin_left;
    double m_margin_y;
    double max;
    double min;
    double proportion;
}
-(UIImage *)drawRect :(double)begin :(double)end :(double)highest :(double)lowest;
@end
