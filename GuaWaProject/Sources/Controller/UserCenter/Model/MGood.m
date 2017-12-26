//
//  MGood.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MGood.h"
@implementation MGoodsList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"goodsList" : [MGood class]
             };
}
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"goodsList":@"data",
             };
}
@end
@implementation MGood

@end
