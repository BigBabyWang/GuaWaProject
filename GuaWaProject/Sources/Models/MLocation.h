//
//  MLocation.h
//  GuaWaProject
//
//  Created by 木炎 on 2017/12/22.
//  Copyright © 2017年 木炎. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MLocationsList : NSObject
@property (nonatomic, strong)NSArray * locationsList;
@end
/*
 {
 "memberId":1,
 "mobile":"18888888888",
 "area":"福建省厦门市思明区",
 "detail":"blablablabla",
 "addressId":3,
 "linkName":"过气程序员",
 "default":true
 }
 */
@interface MLocation : NSObject
@property (nonatomic, strong)NSString * mobile;
@property (nonatomic, strong)NSString * detail;
@property (nonatomic, strong)NSString * area;
@property (nonatomic, strong)NSString * linkName;

@property (nonatomic, assign)NSInteger memberId;
@property (nonatomic, assign)NSInteger addressId;
@property (nonatomic, assign)NSInteger isDefault;
@end
