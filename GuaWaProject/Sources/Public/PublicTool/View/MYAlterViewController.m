//
//  MYAlterViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/11/27.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MYAlterViewController.h"

@interface MYAlterViewController ()

@end

@implementation MYAlterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView * bgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_main"]];
    [self.view insertSubview:bgImage atIndex:1];
    
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
