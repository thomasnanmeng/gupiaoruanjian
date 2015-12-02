//
//  Chart.h
//  Stock
//
//  Created by 李旗 on 15/11/27.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Chart : UIView
{
    UIToolbar *toolbar;
    int m_row;
    int m_column;
    double m_margin_left;
    double m_y;
}

- (void)drawRect:(CGRect)rect;
@end
