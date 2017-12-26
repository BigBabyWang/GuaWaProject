//
//  HistoryDetailViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/26.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "HistoryDetailViewController.h"

@interface HistoryDetailViewController ()
{
    
    __weak IBOutlet UIButton *btnBack;
    __weak IBOutlet UIImageView *image_video;
}
@end

@implementation HistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Utility resizableImageWithBackBtn:btnBack andTitle:@"游戏记录"];
    [btnBack addTarget:self action:@selector(doPopControl) forControlEvents:(UIControlEventTouchUpInside)];
    [self uploadHistoryDetail];
}
#pragma mark ------Set UI------
- (void)setUI{
    
}
#pragma mark ------Set Data------
- (void)setData{
    
}
#pragma mark ------HTTP------
- (void)uploadHistoryDetail{
    
}
#pragma mark ------Button Action------

- (IBAction)btnShareAction:(id)sender {
}
- (IBAction)btnPlayAction:(UIButton *)sender {
}
- (IBAction)btnReplayAction:(id)sender {
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
