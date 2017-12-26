//
//  MUser.h
//  PhoneGame
//
//  Created by co5der on 14-3-4.
//  Copyright (c) 2014年 co5der. All rights reserved.
//


#import "NSString+URLTool.h"
#import <LKDBHelper.h>


@interface MUser : NSObject 


@property (nonatomic, strong)NSString * portrait;
@property (nonatomic, strong)NSString * nickname;
@property (nonatomic, strong)NSString * uid;
@property (nonatomic, strong)NSString * accessToken;
@property (nonatomic, strong)NSString * wxOpenid;
@property (nonatomic, assign)NSInteger sex;

@property (nonatomic, assign)NSInteger diamond;//钻石
@property (nonatomic, assign)NSInteger coin;//金币
@property (nonatomic, assign)NSInteger guawa;//呱娃


@end
