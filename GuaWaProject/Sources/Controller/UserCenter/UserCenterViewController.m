//
//  UserCenterViewController.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/4.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "UserCenterViewController.h"
#import "ZWTopSelectButton.h"
#import "ZWTopSelectVcView.h"
#import "UserInfoViewController.h"
#import "OrderListViewController.h"
#import "AccountViewController.h"
#import "KnapsackViewController.h"
#import "LocationViewController.h"
#import "HistoryViewController.h"
#define TopToSuper 64
#define BottomToSuper 20
#define SelectWidth [UIImage imageNamed:@"btn_fenye_xuanzhong"].size.width
#define SelectLongWidth 10
@interface UserCenterViewController ()<ZWTopSelectVcViewDelegate>
{
    __weak IBOutlet UIButton *btnBack;
    
}
@property (nonatomic, strong) ZWTopSelectVcView *topSelectVcView;
@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [btnBack setTitleShadowColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
    [Utility resizableImageWithBackBtn:btnBack andTitle:@"我的"];
    
    
    [self.view insertSubview:self.topSelectVcView belowSubview:btnBack];
    
}
- (IBAction)btnBackAction:(UIButton *)sender {
    [XMRKTransition viewTransition:self.navigationController.view andAnimationTime:0.8 andAnimationType:XMRKTransitionOglFlip andAnimationSubtype:@"" andAnimationkey:@"userAnimation"];
    
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - ZWTopSelectVcViewDelegate
//初始化设置
-(NSMutableArray *)totalControllerInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    
    NSMutableArray *controllerMutableArr=[NSMutableArray array];
    
    UserInfoViewController *userInfoVC= [[UserInfoViewController alloc]init];
    userInfoVC.title=@"基本资料";
    
    [controllerMutableArr addObject:userInfoVC];
    
    OrderListViewController *orderListVC= [[ OrderListViewController alloc]init];
    orderListVC.title=@"我的订单";
    [controllerMutableArr addObject:orderListVC];
    
    AccountViewController *accountVC= [[ AccountViewController alloc]init];
    accountVC.title=@"我的账户";
    [controllerMutableArr addObject:accountVC];
    
    KnapsackViewController *knapsackVC= [[KnapsackViewController alloc]init];
    knapsackVC.title=@"我的背包";
    [controllerMutableArr addObject:knapsackVC];
    
    LocationViewController *locationVC= [[ LocationViewController alloc]init];
    locationVC.title=@"收货地址";
    [controllerMutableArr addObject:locationVC];
    
    HistoryViewController *historyVC= [[ HistoryViewController alloc]init];
    historyVC.title=@"抓娃记录";
    [controllerMutableArr addObject:historyVC];
    
    return controllerMutableArr;
    
}

///菜单view高度
-(CGFloat)topViewHeightInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return ScreenHeight-TopToSuper;
}
///菜单view宽度
-(CGFloat)topViewWidthInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return SelectWidth;
}
///菜单view X
-(CGFloat)topViewXInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return  0;
}

///菜单view Y
-(CGFloat)topViewYInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return  TopToSuper;
}

///子控制器childVcViewY
-(CGFloat)childVcViewYInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return 0;
}
///子控制器childVcViewX
-(CGFloat)childVcViewXInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return  SelectWidth+SelectLongWidth;
}
///子控制器childVcView高度
-(CGFloat)childVcViewHeightInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return ScreenHeight;
}
///子控制器childVcView宽度
-(CGFloat)childVcViewWidthInZWTopSelectVcView:(ZWTopSelectVcView *)topSelectVcView
{
    return ScreenWidth-SelectWidth-SelectLongWidth;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (ZWTopSelectVcView *)topSelectVcView{
    if (!_topSelectVcView) {
        _topSelectVcView=[[ZWTopSelectVcView alloc]init];
//        _topSelectVcView.titleBG = @[@"btn_jibenziliao",@"btn_wodedingdan",@"btn_wodezhanghu",@"btn_wodebeibao",@"btn_shouhuodizhi",@"btn_zhuawajilu"];
        _topSelectVcView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _topSelectVcView.delegate=self;
        [_topSelectVcView setupZWTopSelectVcViewUI];
        _topSelectVcView.animationType=Fade;
        
    }
    return _topSelectVcView;
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
