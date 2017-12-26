//
//  BaseTableController.m
//  MeiFaCustomer
//
//  Created by xmrk3 on 15/11/17.
//  Copyright (c) 2015年 xmrk. All rights reserved.
//

#import "BaseTableController.h"

@interface BaseTableController ()


@end

@implementation BaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _table_Data = [NSMutableArray new];
//    _dataDic = [NSMutableDictionary new];
    //下拉刷新

    self.delegate = self;
}

-(void)getSubUrl{
    _mode = @"";
    _action = @"";
}
-(void)getDataDic{
    _dataDic = [NSMutableDictionary new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _table_Data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"kcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kcell"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//-(void)loadTableData:(ODRefreshControl*)rfc{
//    [self getSubUrl];
//    [self getDataDic];
//    //判断rfc类型，用于通知或者不传时
//    if ([rfc isKindOfClass:[ODRefreshControl class]]) {
//        [rfc endRefreshing];
//    }
//    
//    dispatch_after(3000000, dispatch_get_main_queue(), ^{
//        [_mainTable.footer endRefreshing];
//    });
//
//    SHOWHUDLOAD(@"")
//    [self.busEngine ceshi:nil dataDic:_dataDic mode:_mode action:_action completionHandler:^(MResult *res) {
//        if (res.isSuccess) {
//            HIDEHUD(YES)
//            [self.delegate isSuccess:res];
//        }else{
//            SHOWHUDERR(res.info)
//        }
//    } errorHandler:^(NSError *error) {
//        ERROR_NET
//    }];
//}
//-(void)loadMoreTableData{
//    [self getSubUrl];
//    [self getDataDic];
//    if (![_mParam haveMore]) {
//        SHOWHUDERR(@"没有更多了");
//        [_mainTable.footer endRefreshing];
//        return;
//    }
//    dispatch_after(3000000, dispatch_get_main_queue(), ^{
//        [_mainTable.footer endRefreshing];
//    });
//    MParam *p = [self.mParam copy];
//    p.currPage += 1;
//    SHOWHUDLOAD(@"")
//    [self.busEngine ceshi:p dataDic:_dataDic mode:_mode action:_action completionHandler:^(MResult *res) {
//        if (res.isSuccess) {
//            HIDEHUD(YES)
//            [self.delegate isSuccessLoadMore:res];
//        }else{
//            SHOWHUDERR(res.info)
//        }
//    } errorHandler:^(NSError *error) {
//        ERROR_NET
//    }];
//    
//
//}

-(void)isSuccess:(MResult *)res{
    if (!self.mParam) {
        self.mParam = [MParam new];
    }
    self.mParam = res.param;
}
-(void)dealloc{
    _mainTable.delegate = nil;
    _mainTable.dataSource = nil;
    _mainTable = nil;
    _mode = @"";
    _action = @"";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
