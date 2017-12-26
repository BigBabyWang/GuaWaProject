//
//  MAccount.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MAccount.h"
@implementation MAccountsList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"accountsList" : [MAccount class]
             };
}
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"accountsList":@"data",
             };
}
@end
@implementation MAccount
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"des":@"description",
             };
}
@end
