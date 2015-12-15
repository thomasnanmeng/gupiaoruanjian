//
//  TableViewController.h
//  Stock
//
//  Created by 李旗 on 15/12/7.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController
<NSURLConnectionDelegate>
{
    NSArray *price_arr;
    double proportion;
//    UITableView *myTbaleView;
    NSMutableArray *m_arr_all_stock_codes;
    NSString *stock_code;
    UIRefreshControl *refresh;
    UISearchController *searchController;
    NSMutableArray *filtered;
    NSString *getData;
}
@property(nonatomic,strong)NSMutableData *receiveData;

@end
