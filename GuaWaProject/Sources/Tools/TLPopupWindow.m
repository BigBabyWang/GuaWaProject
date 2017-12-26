//
//  TLPopupWindow.m
//  popupWindow
//
//  Created by 余天龙 on 16/4/26.
//  Copyright © 2016年 YuTianLong. All rights reserved.
//

#import "TLPopupWindow.h"
#import "Masonry.h"
#import "SitPickerView.h"
#define NSFoundationVersionNumber_iOS_7_1 1047.25

CGSize getScreenSize() {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) &&
        UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    return screenSize;
}
#define ALTER_WIDTH     300
#define ALTER_HEIGHT    180
#define SCREEN_WIDTH        (getScreenSize().width)
#define SCREEN_HEIGHT       (getScreenSize().height)

#define RGB_COLOR_ALPHA(r,g,b,a)    [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define RGB_COLOR(r,g,b)            RGB_COLOR_ALPHA(r,g,b,1)

@interface TLPopupWindow () <UIWebViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *twoTitle;
@property (nonatomic, strong) UILabel *threeTitle;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *introduce;

@property (nonatomic, strong) UIButton *completedButton;    //有边框
@property (nonatomic, strong) UIButton *cancelButton;       //有边框
@property (nonatomic, strong) UIButton *submitButton;       //无边框
@property (nonatomic, strong) UIButton *shutDownButton;

@property (nonatomic, copy) void (^completeBlcok)();
@property (nonatomic, copy) void (^cancel)();

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@property (nonatomic, strong) SitPickerView * sitPickerView;
@end

@implementation TLPopupWindow

- (instancetype)initWithPickerViewcompleteBlock:(void (^)(NSString *, NSString *, NSString *))completeBlock {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.completeBlcok = completeBlock;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        WS(ws)
        self.sitPickerView.ensureAction = ^(NSString *pro, NSString *city, NSString *region) {
            completeBlock(pro,city,region);
            [ws dismiss];
        };
        [self addSubview:self.sitPickerView];
        [self.sitPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self);
//            make.height.equalTo(@(220));
            make.width.equalTo(self.mas_width);
        }];
    }
    return self;
}

- (instancetype)initWithOperationType:(operationType)operationType content:(NSString *)content {
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        NSArray<NSString *> *imageTitle = @[@"right", @"right", @"right", @"right"];
        NSArray<NSString *> *title = @[@"充值成功", @"充值失败", @"提现申请已提交", @"提现失败"];
        NSArray<NSString *> *titleTow = @[@"充值金额: ¥", @"", @"提现金额: ¥", @""];
    
        self.imageView.image = [UIImage imageNamed:imageTitle[operationType]];
        self.twoTitle.text = title[operationType];
        self.contentLabel.text = [NSString stringWithFormat:@"%@%@",titleTow[operationType], content];
        [self.shutDownButton setBackgroundImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
        [self.shutDownButton addTarget:self action:@selector(shutDown:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.imageView];
        [self addSubview:self.twoTitle];
        [self addSubview:self.contentLabel];
        [self addSubview:self.shutDownButton];
        [self commonInit2];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content introduce:(NSString *)introduce {
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        self.twoTitle.text = title;
        self.contentLabel.text = content;
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.introduce.text = introduce;
        self.introduce.font = [UIFont systemFontOfSize:14];
        self.introduce.lineBreakMode = NSLineBreakByTruncatingTail;
        self.introduce.numberOfLines = 0;
        [self.shutDownButton setBackgroundImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
        [self.shutDownButton addTarget:self action:@selector(shutDown:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.twoTitle];
        [self addSubview:self.contentLabel];
        [self addSubview:self.introduce];
        [self addSubview:self.shutDownButton];
        [self commonInit3];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content completeBlock:(void (^)())completeBlock {
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.completeBlcok = completeBlock;
        self.titleLabel.text = title;
        self.contentLabel.text = content;
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.contentLabel.numberOfLines = 0;
        [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.submitButton setBackgroundColor:RGB_COLOR(252, 23, 85)];
        [self.submitButton addTarget:self action:@selector(completed:) forControlEvents:UIControlEventTouchUpInside];
        [self.shutDownButton setBackgroundImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
        [self.shutDownButton addTarget:self action:@selector(shutDown:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.submitButton];
        [self addSubview:self.shutDownButton];
        [self commonInit4];
    }
    return self;
}

- (instancetype)initCompleteBlock:(void (^)())completed {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        self.completeBlcok = completed;
        self.imageView.image = [UIImage imageNamed:@"right"];
        self.contentLabel.text = @"支付成功";
        [self.completedButton setTitle:@"分享给参与人，获取活动红包" forState:UIControlStateNormal];
        self.completedButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.completedButton setBackgroundColor:[UIColor colorWithWhite:0.039 alpha:1.000]];
        [self.completedButton addTarget:self action:@selector(completed:) forControlEvents:UIControlEventTouchUpInside];
        [self.shutDownButton setBackgroundImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
        [self.shutDownButton addTarget:self action:@selector(shutDown:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.imageView];
        [self addSubview:self.contentLabel];
        [self addSubview:self.completedButton];
        [self addSubview:self.shutDownButton];
        [self commonInit5];
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url {
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        [self addSubview:self.webView];
        [self addSubview:self.spinner];
        [self addSubview:self.shutDownButton];
        
        self.spinner.tintColor = [UIColor whiteColor];
        [self.spinner startAnimating];
        self.webView.layer.masksToBounds= YES;
        self.webView.layer.cornerRadius = 5;
        self.webView.layer.borderWidth = 1;
        self.webView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.webView.delegate = self;
        self.webView.backgroundColor = [UIColor colorWithRed:0.303 green:0.247 blue:0.175 alpha:1.000];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
        [self.shutDownButton setBackgroundImage:[UIImage imageNamed:@"pop"] forState:UIControlStateNormal];
        [self.shutDownButton addTarget:self action:@selector(shutDown:) forControlEvents:UIControlEventTouchUpInside];
        [self commonInit6];
    }
    return self;
}

- (instancetype)initWithCustomView:(UIView *)customView {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
//        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:customView];
        UIImage * image = [UIImage imageNamed:@"tanchuang"];
        [customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@(image.size.height));
            make.width.equalTo(@(image.size.width));
        }];
    }
    return self;
}

#pragma mark - Private methods

- (void)commonInit {
    self.backgroundColor = RGB_COLOR(74, 74, 74);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(10);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@20);
    }];
    [self.twoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.width.equalTo(@SCREEN_WIDTH);
        make.height.equalTo(@25);
    }];
//    [self.threeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mas_centerX);
//        make.top.equalTo(self.twoTitle.mas_bottom).offset(15);
//        make.width.equalTo(@SCREEN_WIDTH);
//        make.height.equalTo(@25);
//    }];
    [self.completedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.twoTitle.mas_bottom).offset(30);
        make.width.equalTo(self.mas_width).offset(-40);
        make.height.equalTo(@40);
    }];
//    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.mas_centerX);
//        make.top.equalTo(self.completedButton.mas_bottom).offset(10);
//        make.width.equalTo(@(SCREEN_WIDTH-40));
//        make.height.equalTo(@40);
//    }];
}

- (IBAction)completed:(UIButton *)sender {
    self.completeBlcok();
    [self dismiss];
}

- (IBAction)cancel:(UIButton *)sender {
    self.cancel();
    [self dismiss];
}

- (void)commonInit2 {
    self.backgroundColor = [UIColor colorWithWhite:0.039 alpha:1.000];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-100);
        make.width.height.equalTo(@80);
    }];
    [self.twoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(3);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@SCREEN_WIDTH);
        make.height.equalTo(@25);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoTitle.mas_bottom).offset(30);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@SCREEN_WIDTH);
        make.height.equalTo(@25);
    }];
    [self.shutDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-100));
        make.centerX.equalTo(self.mas_centerX);
        make.height.width.equalTo(@30);
    }];
}

- (void)commonInit3 {

    self.backgroundColor = RGB_COLOR(74, 74, 74);
    
    [self.twoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-200);
        make.width.equalTo(@SCREEN_WIDTH);
        make.height.equalTo(@20);
    }];
    UIView *viewLine = [UIView new];
    viewLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewLine];
    [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoTitle.mas_bottom).offset(10);
        make.leading.equalTo(@10);
        make.trailing.equalTo(@(-10));
        make.height.equalTo(@1);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewLine.mas_bottom).offset(10);
        make.leading.equalTo(@20);
        make.trailing.equalTo(@(-20));
        make.height.equalTo(@20);
    }];
    [self.introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(20);
        make.leading.equalTo(@20);
        make.trailing.equalTo(@(-20));
        make.height.lessThanOrEqualTo(@200);
    }];
    [self.shutDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-100));
        make.centerX.equalTo(self.mas_centerX);
        make.height.width.equalTo(@30);
    }];
}

- (void)commonInit4 {

    self.backgroundColor = RGB_COLOR(74, 74, 74);
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-200);
        make.width.equalTo(@SCREEN_WIDTH);
        make.height.equalTo(@20);
    }];
    
    UIView *viewLine = [UIView new];
    viewLine.backgroundColor = [UIColor whiteColor];
    [self addSubview:viewLine];
    [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.leading.equalTo(@10);
        make.trailing.equalTo(@(-10));
        make.height.equalTo(@1);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewLine.mas_bottom).offset(10);
        make.leading.equalTo(@20);
        make.trailing.equalTo(@(-20));
        make.bottom.equalTo(self.submitButton.mas_top).offset(-20);
    }];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(20);
        make.leading.equalTo(@25);
        make.trailing.equalTo(@(-25));
        make.height.equalTo(@40);
        make.bottom.equalTo(self.shutDownButton.mas_top).offset(-20);
    }];
    [self.submitButton setContentCompressionResistancePriority:(UILayoutPriorityDefaultHigh + 1) forAxis:UILayoutConstraintAxisHorizontal];
    [self.shutDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-100));
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.equalTo(@30);
    }];
    [self.shutDownButton setContentCompressionResistancePriority:(UILayoutPriorityDefaultHigh + 1) forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)commonInit5 {

    self.backgroundColor = [UIColor colorWithWhite:0.039 alpha:1.000];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-100);
        make.height.width.equalTo(@80);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(3);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@SCREEN_WIDTH);
        make.height.equalTo(@25);
    }];
    [self.completedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(50);
        make.leading.equalTo(@25);
        make.trailing.equalTo(@(-25));
        make.height.equalTo(@40);
    }];
}
 - (void)commonInit6 {
     
     self.backgroundColor = [UIColor colorWithWhite:0.039 alpha:1.000];
     
     [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(@100);
         make.leading.equalTo(@20);
         make.trailing.equalTo(@(-20));
         make.bottom.equalTo(self.shutDownButton.mas_top).offset(-20);
     }];
     [self.spinner mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.equalTo(self.mas_centerX);
         make.centerY.equalTo(self.mas_centerY);
         make.height.width.equalTo(@20);
     }];
     [self.shutDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(@(-100));
         make.centerX.equalTo(self.mas_centerX);
         make.height.width.equalTo(@30);
     }];
     [self.shutDownButton setContentCompressionResistancePriority:(UILayoutPriorityDefaultHigh + 1) forAxis:UILayoutConstraintAxisHorizontal];
 }

- (IBAction)shutDown:(UIButton *)sender {
    [self dismiss];
}

#pragma mark - Getter & Setter
- (SitPickerView *) sitPickerView{
    WS(ws)
    if (!_sitPickerView) {
        _sitPickerView = [[[NSBundle mainBundle]loadNibNamed:@"SitPickerView" owner:nil options:nil]lastObject];
        //取消
        _sitPickerView.cancelAction = ^(void){
            [ws dismiss];
        };
        //确定
        
    }
    return _sitPickerView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.userInteractionEnabled = YES;
    }
    return _titleLabel;
}

- (UILabel *)twoTitle {
    if (!_twoTitle) {
        _twoTitle = [[UILabel alloc] init];
        _twoTitle.font = [UIFont systemFontOfSize:16];
        _twoTitle.textAlignment = NSTextAlignmentCenter;
        _twoTitle.textColor = [UIColor whiteColor];
        _twoTitle.userInteractionEnabled = YES;
    }
    return _twoTitle;
}

- (UILabel *)threeTitle {
    if (!_threeTitle) {
        _threeTitle = [[UILabel alloc] init];
        _threeTitle.font = [UIFont systemFontOfSize:18];
        _threeTitle.textAlignment = NSTextAlignmentCenter;
        _threeTitle.textColor = [UIColor whiteColor];
        _threeTitle.userInteractionEnabled = YES;
    }
    return _threeTitle;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.userInteractionEnabled = YES;
    }
    return _contentLabel;
}

-  (UILabel *)introduce {
    if (!_introduce) {
        _introduce = [[UILabel alloc] init];
        _introduce.font = [UIFont systemFontOfSize:16];
        _introduce.textAlignment = NSTextAlignmentCenter;
        _introduce.textColor = [UIColor whiteColor];
        _introduce.userInteractionEnabled = YES;
    }
    return _introduce;
}

- (UIButton *)completedButton {
    if (!_completedButton) {
        _completedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_completedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _completedButton.layer.masksToBounds= YES;
        _completedButton.layer.cornerRadius = 3;
        _completedButton.layer.borderWidth = 1;
        _completedButton.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _completedButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelButton.layer.masksToBounds= YES;
        _cancelButton.layer.cornerRadius = 3;
        _cancelButton.layer.borderWidth = 1;
        _cancelButton.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return _cancelButton;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _submitButton;
}

- (UIButton *)shutDownButton {
    if (!_shutDownButton) {
        _shutDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _shutDownButton;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = NO;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.opaque = NO;
        _webView.userInteractionEnabled = YES;
    }
    return _webView;
}

- (UIActivityIndicatorView *)spinner {
    if (!_spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _spinner.hidesWhenStopped = YES;
        _spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return _spinner;
}

#pragma mark - UIWebViewDelegate methods

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
}

#pragma mark -

- (void)show:(BOOL)animated {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    animated ?
    [self shakeToShow:self] :
    nil;
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.alpha = 0;
                         [self layoutSubviews];
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)setHideWhenTapOutside:(BOOL)hideWhenTapOutside {
    
//    if (hideWhenTapOutside) {
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//        [window addGestureRecognizer:gesture];
//    }
}

- (void)shakeToShow:(UIView *)aView{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    NSMutableArray *values = [NSMutableArray array];

    [values addObject:[NSValue valueWithCATransform3D: CATransform3DMakeScale(0.5, 0.5, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D: CATransform3DMakeScale(0.75, 0.75, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"");
}

@end
