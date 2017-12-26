//
//  OrderListViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/4.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListViewCell.h"
#import "MOrder.h"
@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UIButton *btn_left;
    __weak IBOutlet UIButton *btn_mid;
    __weak IBOutlet UIButton *btn_right;
    
    __weak IBOutlet UITableView *_tableview;
}
@property (nonatomic, assign)NSInteger type;//记录数据类型 1 待发货 2 派送中 3 已完成
@property (nonatomic, strong)MOrderList * orderList;
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self uploadOrderList];
}
#pragma mark ------Set  UI------
- (void)setUI{
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark ------Set  Data------
- (void)setData{
    self.type = 1;
}
#pragma mark ------HTTP------
- (void)uploadOrderList{
    [self.busEngine getMyOrderList:_type completionHandler:^(MResult *res) {
        if (res.isSuccess) {
            _orderList = res.retObject;
            
            [_tableview reloadData];
        }
    } errorHandler:^(NSError *error) {
        ERROR_NET
    }];
}
#pragma mark ------TableViewDataSource------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _orderList.orderList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListViewCell * cell = [[OrderListViewCell alloc]initWithTableview:tableView ];
    MOrder * order = _orderList.orderList[indexPath.row];
    cell.order = order;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [UIImage imageNamed:@"bg_orderList"].size.height+15.0f;
}
#pragma mark ------TableViewDelegate------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"敬请期待");
}
#pragma mark ------ButtonAction------
- (IBAction)btnNavAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    
    btn_left.selected = NO;
    btn_mid.selected = NO;
    btn_right.selected = NO;
    sender.selected = YES;
    _type = sender.tag;
    [self uploadOrderList];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
