//
//  UserCenterButton.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/15.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "UserCenterButton.h"
@interface UserCenterButton ()
{
    UIButton * userImg;
    UIImageView * championImg;
    UIImageView * specialImg;
}
@end

@implementation UserCenterButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUI];
}
- (void)setUI{
    CALayer *layer = [CALayer layer];
    layer.frame = self.bounds;
    layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
    layer.shadowOffset = CGSizeMake(0, 8);
//    layer.shadowOpacity = 0.35;
    layer.cornerRadius = self.frame.size.width/2.0;
    //这里self表示当前自定义的view
    [self.layer addSublayer:layer];
    userImg = [[UIButton alloc]initWithFrame:self.bounds];
    [userImg setBackgroundColor:[UIColor redColor]];
    [self addSubview:userImg];
    [userImg addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [Utility setCircleRadius:userImg borderColor:[UIColor whiteColor]];
    championImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_jin"]];
    championImg.center = CGPointMake(10, 0);
    [self addSubview:championImg];
    
    specialImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"paihangbangtexiao"]];
    specialImg.center = userImg.center;
    specialImg.hidden = YES;
    [self addSubview:specialImg];
}
- (void)btnAction:(UIButton *)sender{
    if (self.touchAction) {
        self.touchAction(sender);
    }
    
}
- (void)setImageName:(NSString *)imageName{
    if (imageName) {
        NSURL * url = [NSURL URLWithString:imageName];
        [userImg.imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (imageName) {
                [userImg setImage:image forState:(UIControlStateNormal)];
            }
        }];
    }
}
- (void)setButtonType:(enum UserCenterButtonType)type{
    [self setChampionImage:type];
}
- (void)setType:(NSInteger)type{
    _type = type;
}
- (void)setChampionImage:(NSInteger)type{
    specialImg.hidden = YES;
    switch (type) {
        case UserCenterButtonNormal:
            championImg.image = nil;
            break;
        case UserCenterButtonGold:
            [championImg setImage:[UIImage imageNamed:@"icon_jin"]];
            specialImg.hidden = NO;
            break;
        case UserCenterButtonSilver:
            [championImg setImage:[UIImage imageNamed:@"icon_yin"]];
            break;
        case UserCenterButtonBronze:
            [championImg setImage:[UIImage imageNamed:@"icon_tong"]];
            break;
            
        default:
            championImg.image = nil;
            break;
    }
}
@end
