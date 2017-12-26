//
//  LocationViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/4.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "LocationViewController.h"
#import "MyLocationCell.h"
#import "MLocation.h"
#import "LocationView.h"
@interface LocationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    __weak IBOutlet UITableView *_tableview;
}
@property (nonatomic, strong)NSArray * tableData;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self uploadLocation];
}
#pragma mark ------Set UI------
- (void)setUI{
    
}
#pragma mark ------Set Data------
- (void)setData{
    
}
#pragma mark ------HTTP------
- (void)uploadLocation{
    [self.busEngine getMyLocation:0 completionHandler:^(MResult *res) {
        if (res.isSuccess) {
            MLocationsList * locationsList = res.retObject;
            self.tableData = locationsList.locationsList;
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
    return self.tableData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyLocationCell * cell = [[MyLocationCell alloc]initWithTableview:tableView];
    MLocation * location = self.tableData[indexPath.row];
    cell.location = location;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIImage * img = [UIImage imageNamed:@"bg_location"];
    return img.size.height+5.0;
}
#pragma mark ------TableViewDelegate------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //编辑
    MLocation * location = self.tableData[indexPath.row];
    [self showPopupWindow:location];
}
#pragma mark ------Button Action------

- (IBAction)btnAddLocationAction:(UIButton *)sender {
    //新增地址
    [self showPopupWindow:nil];
}
- (void)showPopupWindow:(MLocation *)location{
//    NSArray  *apparray = [[NSBundle mainBundle]loadNibNamed:@"LocationView" owner:nil options:nil];
//    LocationView * locationView = [apparray firstObject];
    UINib *nib = [UINib nibWithNibName:@"LocationView" bundle:nil];
    LocationView * locationView = [nib instantiateWithOwner:nil options:nil].firstObject;
    if (location) {
        locationView.location = location;
    }
    WS(ws)
    TLPopupWindow * popup = [[TLPopupWindow alloc]initWithCustomView:locationView];
    locationView.cancel = ^{
        [popup dismiss];
    };
    locationView.save = ^(NSDictionary * locationDic) {
        [self.busEngine addLocation:locationDic completionHandler:^(MResult *res) {
            if (res.isSuccess) {
                [ws uploadLocation];
                [popup dismiss];
            }
        } errorHandler:^(NSError *error) {
            ERROR_NET
        }];
    };
    [popup show:YES];
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
