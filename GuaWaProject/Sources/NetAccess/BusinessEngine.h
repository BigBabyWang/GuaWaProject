//
//  PublicEngine.h
//  JYApp
//
//  Created by co5der on 14-3-7.
//  Copyright (c) 2014年 co5der. All rights reserved.
//
#import "ApiHelp.h"
#import "MKNetworkEngine.h"
#import "MResult.h"
#import "MUser.h"
//#import "MAccount.h"
@class MReserve;
@class MRecruitment;
@class MGoods;
@class MAccept;
@class MApply;
@class MOrder;
@class MStaff;
@class MElt;
@class MResume;
typedef void (^ResultResponseBlock)(MResult* res);

@interface BusinessEngine : MKNetworkEngine

-(id) initWithDefaultSettings;

#pragma mark - 微信登录

-(MKNetworkOperation*) weChatLogin:(NSDictionary*) WeChatDic
               completionHandler:(ResultResponseBlock) completion
                    errorHandler:(MKNKErrorBlock) errorBlock;

#pragma mark - 获取个人信息
-(MKNetworkOperation*) getUserInfo:(NSString *)uid
                 completionHandler:(ResultResponseBlock) completion
                      errorHandler:(MKNKErrorBlock) errorBlock;

#pragma mark - 获取订单列表
-(MKNetworkOperation*) getMyOrderList:(NSInteger)optype
                    completionHandler:(ResultResponseBlock) completion
                         errorHandler:(MKNKErrorBlock) errorBlock;

#pragma mark - 我的背包
-(MKNetworkOperation*) getMyKnapsack:(NSInteger)optype
                   completionHandler:(ResultResponseBlock) completion
                        errorHandler:(MKNKErrorBlock) errorBlock;
#pragma mark - 我的账户记录
-(MKNetworkOperation*) getMyAccount:(NSInteger)optype
                  completionHandler:(ResultResponseBlock) completion
                       errorHandler:(MKNKErrorBlock) errorBlock;
#pragma mark - 我的收货地址
-(MKNetworkOperation*) getMyLocation:(NSInteger)optype
                   completionHandler:(ResultResponseBlock) completion
                        errorHandler:(MKNKErrorBlock) errorBlock;
#pragma mark - 新增地址
-(MKNetworkOperation*) addLocation:(NSDictionary *)locationDic
                 completionHandler:(ResultResponseBlock) completion
                      errorHandler:(MKNKErrorBlock) errorBlock;
#pragma mark - 微信支付
-(MKNetworkOperation*) weixinPay:(NSInteger)documentId
               completionHandler:(ResultResponseBlock) completion
                    errorHandler:(MKNKErrorBlock) errorBlock;
#pragma mark - 抓娃记录
-(MKNetworkOperation*) catchDollList:(NSString *)str
                   completionHandler:(ResultResponseBlock) completion
                        errorHandler:(MKNKErrorBlock) errorBlock;

@end
