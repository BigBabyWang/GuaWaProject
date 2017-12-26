//
//  MOrder.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MOrderList : NSObject
@property (nonatomic, strong)NSArray * orderList;
@end
/*
 {
 "applySendTime":"2017-12-06 19:00:33",
 "goodsNum":3,
 "ordersId":13,
 "goods":[]
 */
@interface MOrder : NSObject
@property (nonatomic, strong)NSString * applySendTime;
@property (nonatomic, assign)NSInteger goodsNum;
@property (nonatomic, assign)NSInteger ordersId;
@property (nonatomic, strong)NSArray * goodsList;
@end
