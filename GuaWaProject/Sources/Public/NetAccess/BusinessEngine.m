 //
//  PublicEngine.m
//  JYApp
//
//  Created by co5der on 14-3-7.
//  Copyright (c) 2014年 co5der. All rights reserved.
//

#import "BusinessEngine.h"
#import "AppShareContext.h"
#import "NSString+SSToolkitAdditions.h"
#import <JSONKit/JSONKit.h>
#import <SFHFKeychainUtils.h>
#import "MHelp.h"
#import "MOrder.h"
#import "MGood.h"
#import "MCard.h"
#import "MProp.h"
#import "MAccount.h"
#import "MLocation.h"
#import "MHistory.h"
@implementation BusinessEngine
-(id) initWithDefaultSettings {
    NSMutableDictionary *headerDict = [NSMutableDictionary dictionaryWithCapacity:6];
    headerDict[@"x-client-identifier"] = @"iOS";
    headerDict[@"Accept-Encoding"] = @"gzip, deflate";

    if(self = [super initWithHostName:API_HOST customHeaderFields:headerDict]) {
        //[self useCache];
        DLog(@"header:%@",headerDict);
    }
    return self;
}

-(id) initWithLoginRegSettings
{
    NSMutableDictionary *headerDict = [NSMutableDictionary dictionaryWithCapacity:1];
    headerDict[@"x-client-identifier"] = @"iOS";
    if(self = [super initWithHostName:API_HOST customHeaderFields:headerDict]) {
        //[self useCache];
        DLog(@"header:%@",headerDict);
    }
    return self;
}

//over write cache dir.
-(NSString*) cacheDirectoryName {
    static NSString *cacheDirectoryName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        documentsDirectory = [documentsDirectory stringByAppendingPathComponent:CACHE_DIR_NAME];
        cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:MKNETWORKCACHE_DEFAULT_DIRECTORY];
    });
    return cacheDirectoryName;
}

#pragma mark - 微信登录
//@"openid":openId,@"tokens":__device_token,@"type":type,@"uname":nicName,@"headurl":urlString
-(MKNetworkOperation*) weChatLogin:(NSDictionary*) WeChatDic
               completionHandler:(ResultResponseBlock) completion
                    errorHandler:(MKNKErrorBlock) errorBlock
{
    NSMutableDictionary * p = [NSMutableDictionary new];
    if (WeChatDic) {
        [p addEntriesFromDictionary:WeChatDic];
    }
    
    
    
    
    NSString *path = [[NSString alloc]initWithFormat:@"/guawa/api/member/oauth/wxLogin"];
    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:API_HOST];
    MKNetworkOperation *op = [engine operationWithPath:path params:p httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation){
         
         NSDictionary *dict = [completedOperation responseJSON];
        MResult *res = [MResult yy_modelWithDictionary:dict];
         if (completion) {
             [[AppShareContext sharedAppShareContext] reset];
         }
         
         
         NSDictionary *dictt = dict[@"data"];
         if (res.isSuccess && ![dictt isKindOfClass:[NSNull class]]) {
             res.dict = dictt;
         }
         if ([res isSuccess]) {
             
             
             [AppShareContext sharedAppShareContext].mUser = [MUser yy_modelWithDictionary:dictt];

             
             
             //save to local keychain.

             BOOL isUserNameSave = [SFHFKeychainUtils storeUsername:PASS_STORE_PHONE andPassword:WeChatDic[@"openId"] forServiceName:PASS_SERVER_NAME updateExisting:YES error:nil];
             BOOL isUserPasswedSave = [SFHFKeychainUtils storeUsername:PASS_STORE_PASSWD andPassword:WeChatDic[@"accessToken"] forServiceName:PASS_SERVER_NAME updateExisting:YES error:nil];


             NSString *phone = [SFHFKeychainUtils getPasswordForUsername:PASS_STORE_PHONE andServiceName:PASS_SERVER_NAME error:nil];
             NSString *psword = [SFHFKeychainUtils getPasswordForUsername:PASS_STORE_PASSWD andServiceName:PASS_SERVER_NAME error:nil];
             
         }
         
         if (completion) {
             completion(res);
         }
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         if (errorBlock) {
             errorBlock(error);
         }
         
     }];
    [self enqueueOperation:op];
    return op;
}
#pragma mark - 个人信息
-(MKNetworkOperation*) getUserInfo:(NSString *)uid
                 completionHandler:(ResultResponseBlock) completion
                      errorHandler:(MKNKErrorBlock) errorBlock
{
    
    NSMutableDictionary * p = [ApiHelp getSimpleDic];
    p[@"memberId"] = @(2);
    
    
    NSString *path = [[NSString alloc]initWithFormat:@"/guawa/api/member/memberInfo"];
    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:API_HOST customHeaderFields:@{@"X-MUYAN-SIGN":[@"V1.0" md5]}];
    MKNetworkOperation *op = [engine operationWithPath:path params:p httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary *dict = [completedOperation responseJSON];
         MResult *res = [MResult yy_modelWithDictionary:dict];
         if (completion) {
             [[AppShareContext sharedAppShareContext] reset];
         }
         
         
         NSDictionary *dictt = dict[@"data"];
         if (res.isSuccess && ![dictt isKindOfClass:[NSNull class]]) {
             res.dict = dictt;
         }
         if ([res isSuccess]) {
             
             
             [AppShareContext sharedAppShareContext].mUser = [MUser yy_modelWithDictionary:dictt];
             
         }
         
         if (completion) {
             completion(res);
         }
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         if (errorBlock) {
             errorBlock(error);
         }
         
     }];
    [self enqueueOperation:op];
    return op;
}
#pragma mark - 我的订单
-(MKNetworkOperation*) getMyOrderList:(NSInteger)optype
                    completionHandler:(ResultResponseBlock) completion
                         errorHandler:(MKNKErrorBlock) errorBlock
{
    
    NSMutableDictionary * p = [ApiHelp getSimpleDic];
    p[@"memberId"] = @(1);
    p[@"optype"] = @(optype);
    
    
    NSString *path = [[NSString alloc]initWithFormat:@"/guawa/api/member/ordersList"];
    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:API_HOST customHeaderFields:@{@"X-MUYAN-SIGN":[@"V1.0" md5]}];
    MKNetworkOperation *op = [engine operationWithPath:path params:p httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary *dict = [completedOperation responseJSON];
         MResult *res = [MResult yy_modelWithDictionary:dict];
         
         
         
         NSDictionary *dictt = dict[@"data"];
         if (res.isSuccess && ![dictt isKindOfClass:[NSNull class]]) {
             res.dict = dictt;
         }
         if ([res isSuccess]) {
             MOrderList * orderList = [MOrderList yy_modelWithDictionary:dict];
             res.retObject = orderList;
             
         }
         
         if (completion) {
             completion(res);
         }
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         if (errorBlock) {
             errorBlock(error);
         }
         
     }];
    [self enqueueOperation:op];
    return op;
}
#pragma mark - 我的背包
-(MKNetworkOperation*) getMyKnapsack:(NSInteger)optype
                   completionHandler:(ResultResponseBlock) completion
                        errorHandler:(MKNKErrorBlock) errorBlock
{
    
    NSMutableDictionary * p = [ApiHelp getSimpleDic];
    p[@"memberId"] = @(1);
    p[@"optype"] = @(optype);
    
    
    NSString *path = [[NSString alloc]initWithFormat:@"/guawa/api/member/packageList"];
    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:API_HOST customHeaderFields:@{@"X-MUYAN-SIGN":[@"V1.0" md5]}];
    MKNetworkOperation *op = [engine operationWithPath:path params:p httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary *dict = [completedOperation responseJSON];
         MResult *res = [MResult yy_modelWithDictionary:dict];
         
         
         
         NSDictionary *dictt = dict[@"data"];
         if (res.isSuccess && ![dictt isKindOfClass:[NSNull class]]) {
             res.dict = dictt;
         }
         if ([res isSuccess]) {
             if (optype == 1) {
                 MGoodsList * goodsList = [MGoodsList yy_modelWithDictionary:dict];
                 res.retObject = goodsList;
             }else if (optype == 2){
                 MCardsList * cardsList = [MCardsList yy_modelWithDictionary:dict];
                 res.retObject = cardsList;
             }else{
                 MPropsList * propsList = [MPropsList yy_modelWithDictionary:dict];
                 res.retObject = propsList;
             }
             
             
         }
         
         if (completion) {
             completion(res);
         }
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         if (errorBlock) {
             errorBlock(error);
         }
         
     }];
    [self enqueueOperation:op];
    return op;
}
#pragma mark - 我的账户记录
-(MKNetworkOperation*) getMyAccount:(NSInteger)optype
                   completionHandler:(ResultResponseBlock) completion
                        errorHandler:(MKNKErrorBlock) errorBlock
{
    
    NSMutableDictionary * p = [ApiHelp getSimpleDic];
    p[@"memberId"] = @(1);
    p[@"optype"] = @(optype);
    
    
    NSString *path = [[NSString alloc]initWithFormat:@"/guawa/api/member/account"];
    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:API_HOST customHeaderFields:@{@"X-MUYAN-SIGN":[@"V1.0" md5]}];
    MKNetworkOperation *op = [engine operationWithPath:path params:p httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary *dict = [completedOperation responseJSON];
         MResult *res = [MResult yy_modelWithDictionary:dict];
         
         
         
         NSDictionary *dictt = dict[@"data"];
         if (res.isSuccess && ![dictt isKindOfClass:[NSNull class]]) {
             res.dict = dictt;
         }
         if ([res isSuccess]) {
             
             MAccountsList * accountsList = [MAccountsList yy_modelWithDictionary:dict];
             res.retObject = accountsList;
             
         }
         
         if (completion) {
             completion(res);
         }
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         if (errorBlock) {
             errorBlock(error);
         }
         
     }];
    [self enqueueOperation:op];
    return op;
}
#pragma mark - 我的收货地址
-(MKNetworkOperation*) getMyLocation:(NSInteger)optype
                  completionHandler:(ResultResponseBlock) completion
                       errorHandler:(MKNKErrorBlock) errorBlock
{
    
    NSMutableDictionary * p = [ApiHelp getSimpleDic];
    p[@"memberId"] = @(1);
    
    
    NSString *path = [[NSString alloc]initWithFormat:@"/guawa/api/member/addressList"];
    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:API_HOST customHeaderFields:@{@"X-MUYAN-SIGN":[@"V1.0" md5]}];
    MKNetworkOperation *op = [engine operationWithPath:path params:p httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary *dict = [completedOperation responseJSON];
         MResult *res = [MResult yy_modelWithDictionary:dict];
         
         
         
         NSDictionary *dictt = dict[@"data"];
         if (res.isSuccess && ![dictt isKindOfClass:[NSNull class]]) {
             res.dict = dictt;
         }
         if ([res isSuccess]) {
             
             MLocationsList * locationsList = [MLocationsList yy_modelWithDictionary:dict];
             res.retObject = locationsList;
             
         }
         
         if (completion) {
             completion(res);
         }
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         if (errorBlock) {
             errorBlock(error);
         }
         
     }];
    [self enqueueOperation:op];
    return op;
}
#pragma mark - 新增地址
-(MKNetworkOperation*) addLocation:(NSDictionary *)locationDic
                 completionHandler:(ResultResponseBlock) completion
                      errorHandler:(MKNKErrorBlock) errorBlock
{
    NSMutableDictionary * p = [ApiHelp getSimpleDic];
    if (locationDic) {
        [p addEntriesFromDictionary:locationDic];
    }
    
    p[@"memberId"] = @(1);
    
    
    NSString *path = [[NSString alloc]initWithFormat:@"/guawa/api/member/saveOrUpdateAddress"];
    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:API_HOST customHeaderFields:@{@"X-MUYAN-SIGN":[@"V1.0" md5]}];
    MKNetworkOperation *op = [engine operationWithPath:path params:p httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary *dict = [completedOperation responseJSON];
         MResult *res = [MResult yy_modelWithDictionary:dict];
         
         
         
         NSDictionary *dictt = dict[@"data"];
         if (res.isSuccess && ![dictt isKindOfClass:[NSNull class]]) {
             res.dict = dictt;
         }
         if ([res isSuccess]) {
             
             
             
         }
         
         if (completion) {
             completion(res);
         }
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         if (errorBlock) {
             errorBlock(error);
         }
         
     }];
    [self enqueueOperation:op];
    return op;
}

#pragma mark - 微信支付
-(MKNetworkOperation*) weixinPay:(NSInteger)documentId
               completionHandler:(ResultResponseBlock) completion
                    errorHandler:(MKNKErrorBlock) errorBlock
{
    NSMutableDictionary * p = [ApiHelp getSimpleDic];
   
    p[@"documentId"] = @(documentId);
    p[@"token"] = @(123);
    
    
    NSString *path = [[NSString alloc]initWithFormat:@"/guawa/api/pay/weixin/recharge"];
    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:API_HOST customHeaderFields:@{@"X-MUYAN-SIGN":[@"V1.0" md5]}];
    MKNetworkOperation *op = [engine operationWithPath:path params:p httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary *dict = [completedOperation responseJSON];
         MResult *res = [MResult yy_modelWithDictionary:dict];
         
         
         
         NSDictionary *dictt = dict[@"data"];
         if (res.isSuccess && ![dictt isKindOfClass:[NSNull class]]) {
             res.dict = dictt;
         }
         if ([res isSuccess]) {
             res.retObject = dictt;
             
             
         }
         
         if (completion) {
             completion(res);
         }
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         if (errorBlock) {
             errorBlock(error);
         }
         
     }];
    [self enqueueOperation:op];
    return op;
}

#pragma mark - 抓娃记录
-(MKNetworkOperation*) catchDollList:(NSString *)str
                 completionHandler:(ResultResponseBlock) completion
                      errorHandler:(MKNKErrorBlock) errorBlock
{
    NSMutableDictionary * p = [ApiHelp getSimpleDic];
    
    
    p[@"memberId"] = @(1);
    
    
    NSString *path = [[NSString alloc]initWithFormat:@"/guawa/api/member/catchDollList"];
    MKNetworkEngine * engine = [[MKNetworkEngine alloc]initWithHostName:API_HOST customHeaderFields:@{@"X-MUYAN-SIGN":[@"V1.0" md5]}];
    MKNetworkOperation *op = [engine operationWithPath:path params:p httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary *dict = [completedOperation responseJSON];
         MResult *res = [MResult yy_modelWithDictionary:dict];
         
         
         
         NSDictionary *dictt = dict[@"data"];
         if (res.isSuccess && ![dictt isKindOfClass:[NSNull class]]) {
             res.dict = dictt;
         }
         if ([res isSuccess]) {
             MHistorysList * historysList = [MHistorysList yy_modelWithDictionary:dict];
             res.retObject = historysList;
         }
         
         if (completion) {
             completion(res);
         }
         
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         if (errorBlock) {
             errorBlock(error);
         }
         
     }];
    [self enqueueOperation:op];
    return op;
}
@end
