//
//  WebViewController.m
//  yijiaqin
//
//  Created by 木炎 on 2017/11/17.
//  Copyright © 2017年 厦门乙科网络有限公司. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *webView;
    
}
///返回
@property (nonatomic , strong) UIButton* exitBtn;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:[self getCommNavTopView:@"呱娃（APP）软件许可及服务协议" numButton:0]];
    
    webView.opaque = NO;
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    NSURL * url = [NSURL URLWithString:_url?_url:@"http://wap.guawaapp.com/user/agreement"];
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    [self.view addSubview:self.exitBtn];
    
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
