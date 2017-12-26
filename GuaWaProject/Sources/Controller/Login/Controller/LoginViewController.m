//
//  LoginViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/11/18.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "LoginViewController.h"
#import "WebViewController.h"
#import "MainViewController.h"
#import "UMSocialWechatHandler.h"
#import "OpenUDID.h"
@interface LoginViewController ()
{
    
    __weak IBOutlet UIView *view_bg;
    __weak IBOutlet UIButton *btn_wechat;
    __weak IBOutlet UIButton *btn_allowUP;
    __weak IBOutlet UIButton *btn_userProtocol;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    for(NSString *fontfamilyname in [UIFont familyNames])
//    {
//        NSLog(@"family:'%@'",fontfamilyname);
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//        {
//            NSLog(@"\tfont:'%@'",fontName);
//        }
//        NSLog(@"-------------");
//    }
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
//    label.text = @"这是一个TEST。123456";
//    label.font = [Utility getFont:24];
//    [self.view addSubview:label];
}
- (void)setUI{
    [Utility setButtonRadius:view_bg borderColor:nil];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:btn_userProtocol.titleLabel.text];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0,str.length)];
    [btn_userProtocol setAttributedTitle:str forState:UIControlStateNormal];
}
- (IBAction)btnWeChatAction:(UIButton *)sender {
    

//    SHOWHUDERR(@"登录成功")
//    MainViewController * _vc = [MainViewController new];
//    [self.navigationController pushViewController:_vc animated:YES];
//
//    return;
    if (!sender.selected) {
        SHOWHUDERR(@"请先阅读用户协议并同意")
        return;
    }
    SHOWHUDLOAD(@"这是一个很丑的loading")
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        
        if (error) {
            
            //            [NSObject showLoadHud:NO];
        }
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.gender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
        if (resp.openid.length == 0) {
            SHOWHUDERR(@"授权失败")
            return;
        }
        NSMutableDictionary * weChatDic = [NSMutableDictionary new];
        if (resp.openid) {
            weChatDic[@"openId"] = resp.openid;
        }
        if (resp.accessToken) {
            weChatDic[@"accessToken"] = resp.accessToken;
        }
        if (resp.iconurl) {
            weChatDic[@"headimgurl"] = resp.iconurl;
        }
        if (resp.name) {
            weChatDic[@"nickname"] = resp.name;
        }
        if (resp.originalResponse[@"country"]) {
            weChatDic[@"address"] = resp.originalResponse[@"country"];
        }
        weChatDic[@"phoneUUID"] = [OpenUDID value];
        weChatDic[@"phonePlateform"] = @(1);
        weChatDic[@"phoneVersion"] = @(1);
        weChatDic[@"sex"] = [resp.gender isEqualToString:@"m"]?@(0):@(1);
        [self requestLoginWeChatDic:weChatDic];
    }];
}

    
//授权登录
- (void)requestLoginWeChatDic:(NSMutableDictionary *)weChatDic{
    
    
    

    [self.busEngine weChatLogin:weChatDic completionHandler:^(MResult *res) {
        if (res.isSuccess) {
            SHOWHUDERR(@"登录成功")
            MainViewController * _vc = [MainViewController new];
            [self.navigationController pushViewController:_vc animated:YES];
        }else{
            SHOWHUDERR(res.respmsg)
        }
    } errorHandler:^(NSError *error) {
        ERROR_NET
    }];
    
}
- (IBAction)btnAllowUPAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    btn_wechat.selected = sender.selected;
}
- (IBAction)btnUserProtocolAction:(UIButton *)sender {
    WebViewController *_vc = [[WebViewController alloc]init];
    [self presentViewController:_vc animated:YES completion:nil];
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
