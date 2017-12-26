//
//  AccountViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/4.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "AccountViewController.h"
#import "MyAccountCell.h"
#import "AccountListCell.h"
#import "MAccount.h"
@interface AccountViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UIButton *btn_left;
    __weak IBOutlet UIButton *btn_right;
    __weak IBOutlet UITableView *_tableview;
}
@property(nonatomic) CGPoint lastContentOffset;
@property (nonatomic, strong)NSArray * tableData;
@property (nonatomic, assign)NSInteger type;
@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self uploadAccount];
}
#pragma mark ------Set  UI------
- (void)setUI{
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark ------Set  Data------
- (void)setData{
    self.lastContentOffset = CGPointMake(0, 0);
    self.type = 1;
}
#pragma mark ------HTTP------
- (void)uploadAccount{
    if (_type == 1) {
        [_tableview reloadData];
        return;
    }
    [self.busEngine getMyAccount:_type completionHandler:^(MResult *res) {
        if (res.isSuccess) {
            MAccountsList * accountsList =res.retObject;
            self.tableData = accountsList.accountsList;
            [_tableview reloadData];
        }
    } errorHandler:^(NSError *error) {
        ERROR_NET
    }];
}
#pragma mark ------TableViewDataSource------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_type == 1) {
        tableView.userInteractionEnabled = NO;
        return 1;
    }else{
        tableView.userInteractionEnabled = YES;
        return self.tableData.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell;
    if (_type == 1) {
        cell = [[MyAccountCell alloc]initWithTableview:tableView];
    }else{
        AccountListCell *temCell = [[AccountListCell alloc]initWithTableview:tableView];
        MAccount * account = self.tableData[indexPath.row];
        temCell.account = account;
        cell = temCell;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type == 1) {
        return tableView.bounds.size.height;
    }else{
        return [UIImage imageNamed:@"bg_account"].size.height+9.0f;
    }
    
}
#pragma mark ------TableViewDelegate------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"敬请期待");
}
#pragma mark ------ButtonAction------
//标题
- (IBAction)btnNavAction:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    btn_left.selected = NO;
    btn_right.selected = NO;
    sender.selected = YES;
    _type = sender.tag;
    [_tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self uploadAccount];
   
}
//充值
- (IBAction)btnRechargeAction:(id)sender {
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
