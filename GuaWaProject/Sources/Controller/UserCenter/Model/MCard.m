//
//  MCard.m
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import "MCard.h"
@implementation MCardsList
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"cardsList" : [MCard class]
             };
}
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"cardsList":@"data",
             };
}
@end
@implementation MCard

@end
