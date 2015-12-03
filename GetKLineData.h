//
//  GetKLineData.h
//  Stock
//
//  Created by 李旗 on 15/12/3.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetKLineData : NSObject
{
    NSMutableArray *kline_begin;
    NSMutableArray *kline_end;
    NSMutableArray *kline_highest;
    NSMutableArray *kline_lowest;
}

-(NSDictionary *)get_kline_data :(NSString *)stock_code :(double)chart_height;
@end
