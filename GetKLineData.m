//
//  GetKLineData.m
//  Stock
//
//  Created by 李旗 on 15/12/3.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "GetKLineData.h"

@implementation GetKLineData

-(NSDictionary *)get_kline_data :(NSString *)button_choose :(NSString *)stock_code :(double)chart_height
{
    NSString *url = [NSString stringWithFormat:@"http://data.gtimg.cn/flashdata/hushen/latest/%@/%@.js?maxage=43201",button_choose,stock_code];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *respose = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *kline_data = [[NSString alloc]initWithData:respose encoding:NSUTF8StringEncoding];
    NSArray *kline_info = [kline_data componentsSeparatedByString:@"\\n\\"];
    //把网上的信息按照\n\分成数组
    NSMutableArray *kline_array = [NSMutableArray arrayWithArray:kline_info];//因为数组的元素并不都是需要的数据，所以把数组放到一个可变数组里
    [kline_array removeObject:[kline_array objectAtIndex:0]];
    [kline_array removeObject:[kline_array objectAtIndex:0]];
    //注意上一句删掉一行以后，第二行变成了第一行
    [kline_array removeLastObject];
    //删除不需要的第一行第二行和最后一行数据
    kline_begin = [[NSMutableArray alloc]initWithCapacity:0];
    kline_end =[[NSMutableArray alloc]initWithCapacity:0];
    kline_highest = [[NSMutableArray alloc]initWithCapacity:0];
    kline_lowest = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i < kline_array.count; i++)
    {
        NSArray  * kline_price = [[kline_array objectAtIndex:i]componentsSeparatedByString:@" "];
        //把获取的数据的每个元素按空格分成三个元素
        [kline_begin addObject:[kline_price objectAtIndex:1]];
        //取第二个元素放在一个可变数组里，就得到了需要的价格
        [kline_end  addObject:[kline_price objectAtIndex:2]];
        [kline_highest addObject:[kline_price objectAtIndex:3]];
        [kline_lowest addObject:[kline_price objectAtIndex:4]];
    }

    NSDictionary *kline_source = [[NSDictionary alloc]initWithObjectsAndKeys:kline_begin,@"开始",kline_end,@"结束",kline_highest,@"最高",kline_lowest,@"最低",  nil];
    return kline_source;
}

@end
