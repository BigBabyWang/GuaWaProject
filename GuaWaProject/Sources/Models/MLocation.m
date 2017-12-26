//
//  MLocation.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MLocation.h"
@implementation MLocationsList
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"locationsList" : [MLocation class]
             };
}
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"locationsList":@"data",
             };
}
@end
@implementation MLocation
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"isDefault":@"default",
             };
}
@end
