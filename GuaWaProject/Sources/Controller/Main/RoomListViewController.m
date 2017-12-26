//
//  RoomListViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/1.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "RoomListViewController.h"

@interface RoomListViewController ()
{
    __weak IBOutlet UIButton *btn1;
    __weak IBOutlet UIButton *btn2;
    __weak IBOutlet UIButton *btn3;
    
    __weak IBOutlet UITableView *table;
    UIImageView *bgimg;
}
@end

@implementation RoomListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:[self getCommNavTopView:@"" numButton:3]];
    table.layer.borderWidth = 2.0f;
    table.layer.backgroundColor = [UIColor blackColor].CGColor;
    bgimg = [UIImageView new];
    bgimg.frame = btn1.frame;
    bgimg.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:bgimg belowSubview:btn1];
}
- (IBAction)action:(UIButton *)sender {
    [UIView animateWithDuration:0.1 animations:^{
        bgimg.frame = sender.frame;
    }];
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
