//
//  MProp.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MPropsList : NSObject
@property (nonatomic, strong)NSArray * propsList;

@end
/*
 {
 "cardNo":"VIP 2017 1219 1227 4380",
 "nickname":"这hi月卡啊",
 "cardId":2,
 "cardStatus":1,
 "startTime":"12:00",
 "endTime":"13:00",
 "type":2
 },
 */
@interface MProp : NSObject
@property (nonatomic, strong)NSString * cardNo;
@property (nonatomic, strong)NSString * nickname;
@property (nonatomic, strong)NSString * startTime;
@property (nonatomic, strong)NSString * endTime;

@property (nonatomic, assign)NSInteger cardId;
@property (nonatomic, assign)NSInteger cardStatus;// 1：背包中  3：使用中  4：失效

@property (nonatomic, assign)NSInteger type;//1：月卡  2：周卡  3：临时卡

@property (nonatomic, assign)BOOL isSelect;//表格专用属性
@end
