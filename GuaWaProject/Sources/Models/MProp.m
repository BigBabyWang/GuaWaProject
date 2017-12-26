//
//  MProp.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MProp.h"
@implementation MPropsList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"propsList" : [MProp class]
             };
}
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"propsList":@"data",
             };
}
@end
@implementation MProp

@end
