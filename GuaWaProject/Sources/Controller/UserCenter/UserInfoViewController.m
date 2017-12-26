//
//  UserInfoViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/4.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()
{
    __weak IBOutlet UIImageView *userImageView;
    __weak IBOutlet UILabel *lab_userName;
    __weak IBOutlet UILabel *lab_leve;
    __weak IBOutlet UILabel *lab_userID;
    __weak IBOutlet UILabel *lab_userLocation;
    __weak IBOutlet UILabel *lab_version;
    __weak IBOutlet UIButton *btn_userSex;
    
    
}
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self uploadUserInfo];
}
#pragma mark ------Set  UI------
- (void)setUI{
    MUser * user = [AppShareContext sharedAppShareContext].mUser;
    [userImageView sd_setImageWithURL:[NSURL URLWithString:user.portrait] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            userImageView.image = [Utility imageWithImage:image scaledToSize:userImageView.bounds.size];
            userImageView.layer.cornerRadius = 15.0f;
            userImageView.layer.masksToBounds = YES;
//                 userImageView.layer.cornerRadius = 15.0f;
        }
    }];
    lab_userName.text = user.nickname;
    
    btn_userSex.selected = user.sex;//男0 女1
    lab_leve.text = @"Lv1 小菜鸡";
    lab_userID.text = user.uid;
    lab_userLocation.text = @"福建 厦门";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString * version = [NSString stringWithFormat:@"V%@",app_build];
    lab_version.text = version;
    

}
#pragma mark ------Set  Data------
- (void)setData{
    
}
#pragma mark ------HTTP------
- (void)uploadUserInfo{
    MUser * user = [AppShareContext sharedAppShareContext].mUser;
    [self.busEngine getUserInfo:user.uid completionHandler:^(MResult *res) {
        if (res.isSuccess) {
//            [self setUI];
        }
    } errorHandler:^(NSError *error) {
        ERROR_NET
    }];
}

#pragma mark ------Button Action------
- (IBAction)btnSetMusic:(UIButton *)sender {
    sender.selected = !sender.selected;
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
