//
//  MainViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/11/26.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MainViewController.h"
#import "MYAlterViewController.h"
#import "RoomListViewController.h"
#import "MYMButton.h"
#import "UserCenterViewController.h"
#import "GoodsInfo.h"
#import "LocationView.h"
#import "SitPickerView.h"

#import "jianpan.h"
#import <WXApi.h>
#import "UserCenterButton.h"
#define TABLE_CELL_HEIGHT @[@"125",@"208",@"180"]
#define SHOW_FRAME CGRectMake(0, ScreenHeight-220, ScreenWidth, 220)
#define HiDEN_FRAME CGRectMake(0, ScreenHeight, ScreenWidth, 220)
@interface MainViewController ()<WXApiDelegate>
{
    
    __weak IBOutlet MYMButton *btn_roomList;//加入游戏
    __weak IBOutlet UserCenterButton *btn_userCenter;//个人中心
    
    //排行榜
    __weak IBOutlet UserCenterButton *goldView;//冠军
    __weak IBOutlet UserCenterButton *silverView;//亚军
    __weak IBOutlet UserCenterButton *bronzeView;//季军
    
    
    __weak IBOutlet UITextField *ceshitf;
    
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self uploadData];
}

- (void)uploadData{
    [self.busEngine getUserInfo:[AppShareContext sharedAppShareContext].mUser.uid completionHandler:^(MResult *res) {
        if (res.isSuccess) {
            [self setUI];
        }
    } errorHandler:^(NSError *error) {
        ERROR_NET
    }];
}
#pragma mark -----SetUI-----
- (void)setUI{
    btn_userCenter.imageName = [AppShareContext sharedAppShareContext].mUser.portrait;
    btn_userCenter.buttonType = UserCenterButtonNormal;
    btn_userCenter.touchAction = ^(UIButton *sender) {
        [self doPopControl];
    };
    
    
    goldView.imageName = [AppShareContext sharedAppShareContext].mUser.portrait;
    silverView.imageName = [AppShareContext sharedAppShareContext].mUser.portrait;
    bronzeView.imageName = [AppShareContext sharedAppShareContext].mUser.portrait;
    goldView.buttonType = UserCenterButtonGold;
    silverView.buttonType = UserCenterButtonSilver;
    bronzeView.buttonType = UserCenterButtonBronze;
}
- (void)wxPay:(NSDictionary *)wxPayDic{
    
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
    {
        NSLog(@"没有安装微信");
        return;
    }
    /*
     "nonceStr":"36065e3e1f381835f1a59c5a9af336bc",
     "package":"Sign=WXPay",
     "partnerId":"1485515692",
     "prepayId":"wx201712251417201de45ac02d0587454757",
     "sign":"BAE6BA359ED1FEEBFFE7651A908C695D",
     "timeStamp":"1514182640"
     */
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = wxPayDic[@"partnerId"];
    request.prepayId= wxPayDic[@"prepayId"];
    request.package = wxPayDic[@"package"];
    request.nonceStr= wxPayDic[@"nonceStr"];
    
    request.timeStamp= [wxPayDic[@"timeStamp"] intValue];
    request.sign= wxPayDic[@"sign"];
    [WXApi sendReq:request];
}
#pragma mark -----ButtonAction-----
- (void)doPopControl{
    
    //动画效果待商榷
    UserCenterViewController * _vc = [UserCenterViewController new];
    [XMRKTransition viewTransition:self.navigationController.view andAnimationTime:0.8 andAnimationType:XMRKTransitionOglFlip andAnimationSubtype:@"" andAnimationkey:@"userAnimation"];
    
    [self.navigationController pushViewController:_vc animated:NO];
}
- (IBAction)btnRoomListAction:(UIButton *)sender {
//    UINib *nib = [UINib nibWithNibName:@"jianpan" bundle:nil];
//    jianpan * jianpan = [nib instantiateWithOwner:nil options:nil].firstObject;
//    ceshitf.inputAccessoryView = jianpan;
//    [ceshitf becomeFirstResponder];
    
    [self.busEngine weixinPay:1 completionHandler:^(MResult *res) {
        if (res.isSuccess) {
            NSDictionary * dic = res.retObject;
            [self wxPay:dic];
        }
    } errorHandler:^(NSError *error) {
        ERROR_NET
    }];
    return;
    RoomListViewController * _vc = [RoomListViewController new];
    [self.navigationController pushViewController:_vc animated:YES];
}
- (IBAction)btnShopAction:(UIButton *)sender {
    
    
    UINib *nib = [UINib nibWithNibName:@"LocationView" bundle:nil];
    LocationView * goodInfo = [nib instantiateWithOwner:nil options:nil].firstObject;
//    UINib *nib = [UINib nibWithNibName:@"GoodsInfo" bundle:nil];
//    GoodsInfo * goodInfo = [nib instantiateWithOwner:nil options:nil].firstObject;
    TLPopupWindow * popup = [[TLPopupWindow alloc]initWithCustomView:goodInfo];
    goodInfo.cancel = ^{
        [popup dismiss];
    };
    goodInfo.save = ^(NSDictionary * locationDic) {
        [self.busEngine addLocation:locationDic completionHandler:^(MResult *res) {
            if (res.isSuccess) {
                
            }
        } errorHandler:^(NSError *error) {
            ERROR_NET
        }];
    };
//    [popup setHideWhenTapOutside:YES];
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
