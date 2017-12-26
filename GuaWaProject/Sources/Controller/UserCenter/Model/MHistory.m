//
//  MHistory.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/25.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MHistory.h"
@implementation MHistorysList
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"historysList" : [MHistory class]
             };
}
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"historysList":@"data",
             };
}
@end
@implementation MHistory

@end
