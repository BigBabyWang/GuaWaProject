//
//  BaseTableController.h
//  MeiFaCustomer
//
//  Created by xmrk3 on 15/11/17.
//  Copyright (c) 2015年 xmrk. All rights reserved.
//

#import "BaseController.h"
#import <MJRefresh.h>

@protocol BaseDelegate <NSObject>
- (void) isSuccess:(MResult *)res;
@optional
- (void) isSuccessLoadMore:(MResult *)res;
@end

@interface BaseTableController : BaseController
<
    UITableViewDataSource,
    UITableViewDelegate,
    BaseDelegate
>
@property (nonatomic, strong) UITableView       * mainTable;
@property (nonatomic, strong) NSMutableArray    * table_Data;
@property (nonatomic, strong) MParam            * mParam;
@property (nonatomic, strong) NSString          * sel;
@property (nonatomic, strong) NSString          * mode;
@property (nonatomic, strong) NSString          * action;
@property (nonatomic, strong) NSMutableDictionary   * dataDic;
@property (nonatomic)id <BaseDelegate>delegate;
@property (nonatomic)id object;

//-(void)loadTableData:(ODRefreshControl*)rfc;
-(void)getSubUrl;
-(void)getDataDic;
@end
