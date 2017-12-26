//
//  ZMRecommendOrInvideView.m
//  GuaWaProject
//
//  Created by chenzm on 2017/12/26.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "ZMRecommendOrInvideView.h"
#import <Masonry.h>
@interface ZMRecommendOrInvideView()

///背景视图
@property(nonatomic,strong)UIImageView *imgVBg;
///左侧按钮
@property(nonatomic,strong)UIButton *leftBtn;
///右侧按钮
@property(nonatomic,strong)UIButton *rightBtn;

///说明标签
@property(nonatomic,strong)UILabel *intrumentLbl;

///提示图
@property(nonatomic,strong)UIImageView *hintImgV;

///输入文本框
@property(nonatomic,strong)UITextField *inputTxtF;

///分享到朋友的按钮
@property(nonatomic,strong)UIButton *shareToFriBtn;
///分享到朋友圈
@property(nonatomic,strong)UIButton *shareToCircleOfFriBtn;

///确认按钮
@property(nonatomic,strong)UIButton *confirmBtn;
///取消按钮
@property(nonatomic,strong)UIButton *cancleBtn;

@end



@implementation ZMRecommendOrInvideView{
    CGFloat topDefBtn_h;
    CGFloat topSelBtn_h;
    CGFloat hintImgV_h;
}

#pragma mark - 赋值


#pragma mark -Methods


#pragma mark - Intial
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpBaseData];
        [self setUpUI];
    }
    return self;
}

///基本数据配置
-(void)setUpBaseData{
    UIImage *selImg = kImage(@"btn_selected_pink");
    UIImage *defImg = kImage(@"btn_unselected_left");
    UIImage *hintImg = kImage(@"duihuanyaoqingma");
    topDefBtn_h = defImg.size.height;
    topDefBtn_h = selImg.size.height;
    hintImgV_h = hintImg.size.height;
}

///控件添加
-(void)setUpUI{
    [self addSubview:self.imgVBg];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.intrumentLbl];
    [self addSubview:self.hintImgV];
    [self addSubview:self.inputTxtF];
}

#pragma mark - 布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_imgVBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self);
        make.size.mas_equalTo(kSize(self.frame.size.width/2, topSelBtn_h));
        make.width.mas_equalTo(self.mas_width);
    }];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self);
         make.size.mas_equalTo(kSize(self.frame.size.width/2, topSelBtn_h));
    }];

    [_intrumentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(topSelBtn_h+kDef_margin*2);
        make.left.mas_equalTo(self).offset(kDef_margin*2);
        make.right.mas_equalTo(self).offset(-kDef_margin*2);
        make.height.mas_equalTo(kDef_margin*6);
    }];
    
    [_hintImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_intrumentLbl.mas_bottom).offset(kDef_margin);
        make.left.mas_equalTo(self).offset(kDef_margin*2);
        make.height.mas_equalTo(hintImgV_h);
    }];
    
    [_inputTxtF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_hintImgV.mas_bottom).offset(kDef_margin);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(kSize(self.frame.size.width/2, kDef_margin*2));
    }];
    

    
}

#pragma mark - lazyload
-(UIImageView *)imgVBg{
    if (!_imgVBg) {
        _imgVBg = [UIImageView new];
        UIImage *img = [UIImage imageNamed:@"kuangRecommended"];
        _imgVBg.image = img;
    }
    return _imgVBg;
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton new];
    }
    return _leftBtn;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton new];
    }
    return _rightBtn;
}
-(UILabel *)intrumentLbl{
    if (!_intrumentLbl) {
        _intrumentLbl = [UILabel new];
        _intrumentLbl.numberOfLines = 0;
    }
    return _intrumentLbl;
}
-(UIImageView *)hintImgV{
    if (!_hintImgV) {
        _hintImgV = [UIImageView new];
    }
    return _hintImgV;
}

-(UITextField *)inputTxtF{
    if (!_inputTxtF) {
        _inputTxtF = [UITextField new];
    }
    return _inputTxtF;
}

-(UIButton *)shareToFriBtn{
    if (!_shareToFriBtn) {
        _shareToFriBtn = [UIButton new];
    }
    return _shareToFriBtn;
}

-(UIButton *)shareToCircleOfFriBtn{
    if (!_shareToCircleOfFriBtn) {
        _shareToCircleOfFriBtn = [UIButton new];
    }
    return _shareToCircleOfFriBtn;
}

-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton new];
    }
    return _confirmBtn;
}
-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton new];
    }
    return _cancleBtn;
}

-(void)dealloc{
    
}
@end
