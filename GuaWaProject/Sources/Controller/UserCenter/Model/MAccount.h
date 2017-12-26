//
//  MAccount.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MAccountsList : NSObject
@property (nonatomic, strong)NSArray * accountsList;
@end
/*
 {
 "memberId":1,
 "memberNickname":"robert",
 "amount":100,
 "amountDetailId":1,
 "amountOpType":1,
 "description":"充值呱娃",
 "status":1
 }
 */
@interface MAccount : NSObject
@property (nonatomic, strong)NSString * memberNickname;
@property (nonatomic, strong)NSString * des;

@property (nonatomic, assign)NSInteger memberId;
@property (nonatomic, assign)NSInteger amount;
@property (nonatomic, assign)NSInteger amountDetailId;
@property (nonatomic, assign)NSInteger cardId;
@property (nonatomic, assign)NSInteger status;
@end
