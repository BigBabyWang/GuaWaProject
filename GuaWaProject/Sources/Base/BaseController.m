//
//  BaseController.m
//  saleplace
//
//  Created by tulip on 14-11-10.
//  Copyright (c) 2014年 sale. All rights reserved.
//

#import "BaseController.h"
#import "AppDelegate.h"
//#import "LoginController.h"
@interface BaseController ()
{
    UIView *_topView;
}
@end

@implementation BaseController
- (void)dealloc
{
    _bMainTable.delegate = nil;
    _bMainTable.dataSource = nil;
    self.bMainTable = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _base_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.view.backgroundColor = DEF_CVBG_COLOR;
    [self setUI];
    [self setData];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    // Do any additional setup after loading the view.
    self.busEngine = [[BusinessEngine alloc] initWithDefaultSettings];
  
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    
}
- (void)setUI{
    
}
- (void)setData{
    
}
- (void)viewWillLayoutSubviews
{
    if (self.bContentHeight > 1.0f) {
        CGSize contentSize = self.bContentScroll.bounds.size;
        contentSize.height = self.bContentHeight;
        self.bContentScroll.contentSize = contentSize;
    }
}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [[EIMService sharedEIMService] setChatDelegate:self];
//}
- ( UIStatusBarStyle )preferredStatusBarStyle
{
    // 白色样式
//    DLog(@"%s",__func__);
    return UIStatusBarStyleLightContent;
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isAppearing = YES;
    
    //默认开启导航栏,需要关闭，客户端重写
//    self.navigationController.navigationBarHidden = NO;
//    if(self.bContentHeight > 1.0){
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    }
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideKeyBoard:nil];
    self.isAppearing = NO;
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (UIView *) getCommNavTopView:(NSString *)title numButton:(NSInteger)numButton
{
    CGRect frame = self.view.frame;
    frame.origin = CGPointZero;
    frame.size.height = 64;
    UIView *top = [[UIView alloc] initWithFrame:frame];
    top.backgroundColor = [UIColor clearColor];
    UIImageView *bg = [[UIImageView alloc] initWithFrame:frame];
    bg.autoresizingMask = ~UIViewAutoresizingNone;
    self.bg_nav = bg;
    
    [top addSubview:bg];
    top.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    
    frame.origin.y = 20;
    frame.size.height = 44;
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.font = [UIFont boldSystemFontOfSize:14.0];
    lab.textColor = [UIColor whiteColor];
//    lab.autoresizingMask = ~UIViewAutoresizingNone;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = title;
    lab.backgroundColor = [UIColor clearColor];
    
    
    self.titleLabel = lab;
//    [top addSubview:lab];
    
    //left button
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    frame.size.width = 44;
    frame.origin.x = 10;
    leftBtn.frame = frame;
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [leftBtn setTitle:@"  返回" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    leftBtn.layer.shadowOffset = CGSizeMake(1, 1);
    leftBtn.layer.shadowOpacity = 1;
    
    leftBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    [leftBtn setImage:[UIImage imageNamed:@"btn_main_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(doPopControl) forControlEvents:UIControlEventTouchUpInside];
    [top addSubview:leftBtn];
    self.leftButton = leftBtn;
    
    
    
    if (numButton >= 1) {
        //right button
        frame.origin.x = ScreenWidth - 128-10;
        frame.size.width = 128;
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[rightBtn setBackgroundColor:[UIColor blueColor]];
        rightBtn.frame = frame;
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_main_coin"] forState:UIControlStateNormal];
        
        [top addSubview:rightBtn];
        self.rightButton = rightBtn;
        
        frame.origin.x = 54;
        frame.size.width = (ScreenWidth - 128+10 - ScreenWidth / 2) * 2;
        
    }
    lab.frame = frame;
    if (numButton >= 2) {
        //center button
        frame.origin.x = ScreenWidth - 128-10-115-10;
        frame.size.width = 115;
        UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[centerBtn setBackgroundColor:[UIColor orangeColor]];
        centerBtn.frame = frame;
        [centerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        centerBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [centerBtn setBackgroundImage:[UIImage imageNamed:@"icon_main_accumulatepoints"] forState:UIControlStateNormal];
        [top addSubview:centerBtn];
        self.centerButton = centerBtn;
        frame.origin.x = 119 ;
        lab.frame = frame;
        
    }
    
    
    
    if (numButton == 3) {
        frame.origin.x = ScreenWidth - 128-10-115-10-115-10;
        frame.size.width = 115;
        UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[centerBtn setBackgroundColor:[UIColor orangeColor]];
        centerBtn.frame = frame;
        [centerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        centerBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [centerBtn setBackgroundImage:[UIImage imageNamed:@"icon_main_accumulatepoints"] forState:UIControlStateNormal];
        [top addSubview:centerBtn];
        self.rightThirdButton = centerBtn;
        lab.frame = frame;
    }
    
    [top addSubview:lab];
    
    _topView = top;
    return top;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIKeyboardNotification

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    void(^animations)() = ^{
        [self willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    };
    
    void(^completion)(BOOL) = ^(BOOL finished){
    };
    
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:completion];
}

- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame
{
    if (beginFrame.origin.y == ScreenHeight) {
        CGRect frame = self.bContentScroll.frame;
        frame.size.height =CGRectGetHeight(self.view.frame) - CGRectGetHeight(toFrame);
        self.bContentScroll.frame = frame;
    } else if (toFrame.origin.y == ScreenHeight) {
        CGRect frame = self.bContentScroll.frame;
        frame.size.height =CGRectGetHeight(self.view.frame);
        self.bContentScroll.frame = frame;
    }
}

#pragma mark -- Public method
- (IBAction) hideKeyBoard:(UIButton *)sender
{
    [self.view endEditing:YES];
}
- (IBAction) doPopControl
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//- (void)setRightButton:(NSString *)title action:(SEL)action
//{
//    self.navigationItem.rightBarButtonItem = nil;
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
//    [rightButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem = rightButton;
//}
- (IBAction) dismissControl
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (IBAction) goMainControl:(id)sender
//{
//    UIViewController *uc = nil;
//    for (UIViewController *vc in self.navigationController.viewControllers) {
//        //        if ([vc isKindOfClass:[MainController class]]) {
//        //            uc = vc;
//        //            break;
//        //        }
//    }
//    if (uc) {
//        [self.navigationController popToViewController:uc animated:YES];
//    } else {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
//    
//    
//}

//- (void)setBackButton:(SEL)action
//{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    //[btn setTitle:@"返回" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    [btn setImage:[UIImage imageNamed:@"icon_comm_back"] forState:UIControlStateNormal];
//    btn.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 0, 0);
//    if (action) {
//        [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    } else {
//        [btn addTarget:self action:@selector(doPopControl) forControlEvents:UIControlEventTouchUpInside];
//    }
////    if (ios7After) {
////        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
////    }
//    btn.frame = CGRectMake(0, 0.0, 60.0, 30.0);
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//}

- (void)popToViewControllerOfClass:(Class)clazz animated:(BOOL)animated {
    UIViewController *vc = nil;
    for (UIViewController *c in self.navigationController.viewControllers) {
        if ([c isKindOfClass:clazz]) {
            vc = c;
            break;
        }
    }
    [self.navigationController popToViewController:vc animated:animated];
}
//- (IBAction)goLoginControl:(id)sender
//{
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[LoginController new]];
//    [self presentViewController:nav animated:YES completion:^{
//        ;
//    }];
//}

- (void)setHelpBtn{
    [self.rightButton setTitle:@"帮助" forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(goWalletHelp) forControlEvents:UIControlEventTouchUpInside];
}


- (CAGradientLayer *)changeBackColor:(NSString *)starColor andEndColor:(NSString *)endColor
{
    CAGradientLayer *layer = [CAGradientLayer new];
    layer.colors = @[(__bridge id)[UIColor colorWithHex:starColor].CGColor, (__bridge id)[UIColor colorWithHex:endColor].CGColor];
    layer.startPoint = CGPointMake(0.5, 0);
    layer.endPoint = CGPointMake(0.5, 1);
    layer.frame = self.view.frame;
    
    return layer;
}


- (void)openUserInteractionEnabled:(UIButton *)button
{
    button.userInteractionEnabled = YES;
    [button setImage:[UIImage imageNamed:@"push_select_btn"] forState:UIControlStateNormal];
}
- (void)closeUserInteractionEnabled:(UIButton *)button
{
    button.userInteractionEnabled = NO;
    [button setImage:[UIImage imageNamed:@"push_button"] forState:UIControlStateNormal];
}

- (IBAction) goFeedBackClick:(UIButton *)sender
{
    UIStoryboard * sbFB = [UIStoryboard storyboardWithName:@"FeedBack" bundle:nil];
    UIViewController *uc = [sbFB instantiateViewControllerWithIdentifier:@"feed_back_controller"];
    [self.navigationController pushViewController:uc animated:YES];
}

@end
