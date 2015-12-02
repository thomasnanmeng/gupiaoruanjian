//
//  GetData.m
//  Stock
//
//  Created by 李旗 on 15/12/1.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "GetData.h"

@implementation GetData

-(id)init
{
    self= [super init];
    if (self)
    {
        
    }
    return self;
}
-(NSDictionary *)get_miniute_data :(double)chart_height
{
//    NSError *error;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://data.gtimg.cn/flashdata/hushen/minute/sh600600.js?maxage=10"]];
    NSData *respose = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *miniute_data = [[NSString alloc]initWithData:respose encoding:NSUTF8StringEncoding];
    NSArray *mimiute = [miniute_data componentsSeparatedByString:@"\\n\\"];
    //把网上的信息按照\n\分成数组
    NSMutableArray *miniute_array = [NSMutableArray arrayWithArray:mimiute];//因为数组的元素并不都是需要的数据，所以把数组放到一个可变数组里
    [miniute_array removeObject:[miniute_array objectAtIndex:0]];
    [miniute_array removeObject:[miniute_array objectAtIndex:0]];
    //注意上一句删掉一行以后，第二行变成了第一行
    [miniute_array removeLastObject];
    //删除不需要的第一行第二行和最后一行数据
    price = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i < miniute_array.count; i++)
    {
        NSArray  * miniute_price = [[miniute_array objectAtIndex:i]componentsSeparatedByString:@" "];
        //把获取的数据的每个元素按空格分成三个元素
        [price addObject:[miniute_price objectAtIndex:1]];
        //取第二个元素放在一个可变数组里，就得到了需要的价格
        
    }
    double max = [[price valueForKeyPath:@"@max.doubleValue"] doubleValue];
    double min = [[price valueForKeyPath:@"@min.doubleValue"] doubleValue];
    double first_price = [[price objectAtIndex:0]doubleValue];
    if ((max -first_price) >= (first_price - min))
    {
         proportion = (max-first_price)/(chart_height/2);
    }
    else
    {
        proportion = (first_price - min)/(chart_height/2);
    }
    
    NSDictionary *data_source = [[NSDictionary alloc]initWithObjectsAndKeys:price,@"价格数组",[NSNumber numberWithDouble:proportion],@"比例", nil];

    return  data_source;
    
}


@end
