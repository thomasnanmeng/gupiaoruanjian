//
//  GetData.h
//  Stock
//
//  Created by 李旗 on 15/12/1.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetData : NSObject

{
    NSMutableArray *price;
    double proportion;
  
}
-(NSDictionary *)get_miniute_data :(double)chart_height;
@end
