//
//  ViewController.h
//  Stock
//
//  Created by 李旗 on 15/11/27.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *price_arr;
    double proportion;
    UITableView *myTbaleView;
    NSMutableArray *m_arr_all_stock_codes;
    NSString *stock_code;
}


@end

