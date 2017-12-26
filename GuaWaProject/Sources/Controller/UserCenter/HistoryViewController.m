//
//  HistoryViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/4.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryDetailViewController.h"

#import "HistoryCell.h"
#import "MHistory.h"

@interface HistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *_tableview;
}
@property (nonatomic, strong)NSArray * tableData;
@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self uploadCatchDollList];
}
#pragma mark ------Set UI------
- (void)setUI{
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark ------Set Data------
- (void)setData{
    
}
#pragma mark ------HTTP------
- (void)uploadCatchDollList{
    [self.busEngine catchDollList:nil completionHandler:^(MResult *res) {
        if (res.isSuccess) {
            MHistorysList * historysList = res.retObject;
            self.tableData = historysList.historysList;
            [_tableview reloadData];
        }
    } errorHandler:^(NSError *error) {
        ERROR_NET
    }];
}
#pragma mark ------TableViewDataSource------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;//self.tableData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell * cell = [[HistoryCell alloc]initWithTableview:tableView];
//    MHistory * history = self.tableData[indexPath.row];
//    cell.history = history;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIImage * img = [UIImage imageNamed:@"bg_history"];
    return img.size.height+9.0;
}
#pragma mark ------TableViewDelegate------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryDetailViewController * _vc = [HistoryDetailViewController new];
    NSLog(@"%@",[self viewController].navigationController);
//    [self.parentViewController.navigationController pushViewController:_vc animated:YES];
}
- (UIViewController *)viewController
{
    for (UIView* next = [self.view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
#pragma mark ------Button Action------
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
