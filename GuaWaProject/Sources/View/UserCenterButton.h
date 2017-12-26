//
//  UserCenterButton.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/15.
//  Copyright © 2017年 木炎. All rights reserved.
//
enum UserCenterButtonType
{
    
    UserCenterButtonGold    = 1,
    UserCenterButtonSilver  = 2,
    UserCenterButtonBronze  = 3,
    UserCenterButtonNormal  = 4
};
#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface UserCenterButton : UIView
@property (nonatomic, assign) enum UserCenterButtonType buttonType;
@property (nonatomic, assign) IBInspectable NSInteger type;
@property (nonatomic, strong)NSString * _Nullable imageName;
@property (nonatomic, copy) void (^ _Nonnull touchAction)(UIButton * _Nullable sender);

@end
