//
//  MOrder.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MOrder.h"
#import "MGood.h"
@implementation MOrderList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"orderList" : [MOrder class]
             };
}
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"orderList":@"data",
             };
}
@end
@implementation MOrder
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"goodsList" : [MGood class]
             };
}
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"goodsList":@"goods",
             };
}
@end
