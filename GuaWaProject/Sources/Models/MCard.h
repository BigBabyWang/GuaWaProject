//
//  MCard.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MCardsList : NSObject
@property (nonatomic, strong)NSArray * cardsList;

@end
/*
 "data":[
 {
 "cardNo":" VIP 2017 1219 1226 1682",
 "nickname":"蒙奇奇月卡",
 "cardId":1,
 "cardStatus":1,
 "startTime":"06:00",
 "endTime":"12:00",
 "type":1
 }
 ]
 */
@interface MCard : NSObject
@property (nonatomic, strong)NSString * cardNo;
@property (nonatomic, strong)NSString * nickname;
@property (nonatomic, strong)NSString * startTime;
@property (nonatomic, strong)NSString * endTime;

@property (nonatomic, assign)NSInteger cardId;
@property (nonatomic, assign)NSInteger cardStatus;// 1：背包中  3：使用中  4：失效

@property (nonatomic, assign)NSInteger type;//1：月卡  2：周卡  3：临时卡

@property (nonatomic, assign)BOOL isSelect;//表格专用属性

@end
