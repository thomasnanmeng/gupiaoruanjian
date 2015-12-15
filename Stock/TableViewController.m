//
//  TableViewController.m
//  Stock
//
//  Created by 李旗 on 15/12/7.
//  Copyright (c) 2015年 李旗. All rights reserved.
//

#import "TableViewController.h"
#import "DrawChart.h"
#import "AllKLine.h"
#import "BrokenLine.h"
#import "GetData.h"
#import "ImageViewController.h"
#import <ShareSDK/ShareSDK.h>



@implementation TableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 50);
    [self data_json];
    [self beginRefreshing];
    searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.dimsBackgroundDuringPresentation = NO;
    [searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = searchController.searchBar;
    UIBarButtonItem *back_barbutton_item = [[UIBarButtonItem alloc]init];
    back_barbutton_item.title = @"";
    self.navigationItem.backBarButtonItem = back_barbutton_item;
    UIBarButtonItem *share = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(ShareEventClicked:)];
    self.navigationItem.rightBarButtonItem = share;
}

-(void)data_json  //数据解析
{
   
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://smartbox.gtimg.cn/s3/?q=600&t=all"]];
    NSURLConnection *respose = [[NSURLConnection alloc]initWithRequest:request delegate:self];

}
- (NSString*) replaceUnicode:(NSString*)aUnicodeString //unicode转化成utf8
{
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}
//异步请求代理方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receiveData = [NSMutableData data];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    //拼接接收到的数据
    [self.receiveData appendData:data];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    
    //解析
    m_arr_all_stock_codes = [[NSMutableArray alloc]initWithCapacity:0];
    getData =  [[NSString alloc]initWithData:self.receiveData encoding:NSUTF8StringEncoding];
    
    NSArray *data_array = [getData componentsSeparatedByString:@"^"];
    for (int i = 0; i < data_array.count; i ++)
    {
        NSArray *item_tmp = [[data_array objectAtIndex:i] componentsSeparatedByString:@"~"];
        NSString *str_sh = [item_tmp objectAtIndex:0];
        NSString *str_value = [NSString stringWithFormat:@"%@%@   %@",[str_sh substringFromIndex:str_sh.length-2],[item_tmp objectAtIndex:1],[item_tmp objectAtIndex:2]];
        if ([[str_sh substringFromIndex:str_sh.length-2]isEqualToString:@"sh"]||[[str_sh substringFromIndex:str_sh.length-2]isEqualToString:@"sz"])
        {
            [m_arr_all_stock_codes addObject:[self replaceUnicode:str_value]];
        }
    }
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!searchController.active)
    {
        return m_arr_all_stock_codes.count;
    }
    else
        return filtered.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (!searchController.active) {
        cell.textLabel.text = [m_arr_all_stock_codes objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text =[filtered objectAtIndex:indexPath.row];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *code_array = [[m_arr_all_stock_codes objectAtIndex:[indexPath row]]componentsSeparatedByString:@"   "];
    NSString *code = [code_array objectAtIndex:0];
    NSString *stock_name = [code_array objectAtIndex:1];
    ImageViewController *stock_image = [[ImageViewController alloc]initWithCode:code :stock_name];
    [self.navigationController pushViewController:stock_image  animated:YES];
}
-(void)beginRefreshing
{
    refresh = [[UIRefreshControl alloc]init];
    refresh.tintColor = [UIColor lightGrayColor];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [refresh addTarget:self action:@selector(refreshTabelviewAction:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
}
-(void)refreshTabelviewAction:(UIRefreshControl *)refreshs
{
    if(refreshs.refreshing)
    {
        refreshs.attributedTitle = [[NSAttributedString alloc]initWithString:@"正在刷新"];
        [self performSelector:@selector(refreshData) withObject:nil afterDelay:2];
    }
}
-(void)refreshData
{
    NSString *syseTime = nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-mm-dd hh:mm:ss" ];
    syseTime = [formatter stringFromDate:[NSDate date]];
    NSString *lastUpdated = [NSString stringWithFormat:@"上一次更新时间为 %@", [formatter stringFromDate:[NSDate date]]];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated] ;
//    [self data_json];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
//    [filtered removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@",searchController.searchBar.text];
    filtered = [[NSMutableArray alloc]initWithArray: [m_arr_all_stock_codes filteredArrayUsingPredicate:searchPredicate]];
    [self.tableView reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (IBAction)ShareEventClicked:(id)sender
{
//    UIImage *image = [UIImage imageNamed:@"fenxiang"];
//    NSString *image_name = image;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"fenxiang" ofType:@"jpg"];
    
    //1、构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"要分享的内容111"
                                       defaultContent:@"默认内容"
                                               image :  [ShareSDK imageWithPath:imagePath ]
                                                title:@"Share"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条演示信息"
                                            mediaType:SSPublishContentMediaTypeNews];//图片要放在ShareSDK文件夹里
    //1+创建弹出菜单容器（iPad必要）
    id<ISSContainer> container = [ShareSDK container];
    
    //2、弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                //可以根据回调提示用户。
                                if (state == SSResponseStateSuccess)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                    message:nil
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                    message:[NSString stringWithFormat:@"失败描述：%@",[error errorDescription]]
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"OK"
                                                                          otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                            }];
}


@end
