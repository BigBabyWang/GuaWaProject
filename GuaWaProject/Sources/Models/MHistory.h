//
//  MHistory.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/25.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MHistorysList : NSObject
@property (nonatomic, strong)NSArray * historysList;
@end
/*
 {
 "memberId":1,
 "goodsId":1,
 "thumbnail":"http://gms-shop.oss-cn-hangzhou.aliyuncs.com/common/1512279767000004.jpg",
 "tip":"蒙奇奇X1",
 "title":"蒙奇奇",
 "roomId":1,
 "coin":35,
 "memberNickname":"Robert",
 "roomTitle":"蒙奇奇",
 "status":1
 }
 */
@interface MHistory : NSObject
@property (nonatomic, strong)NSString * thumbnail;
@property (nonatomic, strong)NSString * tip;
@property (nonatomic, strong)NSString * title;
@property (nonatomic, strong)NSString * memberNickname;
@property (nonatomic, strong)NSString * roomTitle;

@property (nonatomic, assign)NSInteger memberId;
@property (nonatomic, assign)NSInteger goodsId;
@property (nonatomic, assign)NSInteger roomId;
@property (nonatomic, assign)NSInteger coin;
@property (nonatomic, assign)NSInteger status;
@end
