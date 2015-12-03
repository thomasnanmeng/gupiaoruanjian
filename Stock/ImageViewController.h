//
//  ImageViewController.h
//  Stock
//
//  Created by 李旗 on 15/12/3.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
{
    NSArray *price_arr;
    double proportion;
    NSString *stock_code;
}
- (id) initWithCode :(NSString *)code;
@end
