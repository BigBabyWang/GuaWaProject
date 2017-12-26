//
//  ApiHelp.m
//  JYApp
//
//  Created by co5der on 14-3-7.
//  Copyright (c) 2014年 co5der. All rights reserved.
//

#import "ApiHelp.h"
#import "Utility.h"
#import "NSString+SSToolkitAdditions.h"
#import "NSData+SSToolkitAdditions.h"
#import "MD5Hash.h"

@implementation ApiHelp

+ (id)getJSONFromResponse:(id)str
{
    id ret = nil;
    if (str && [Utility isString:str lengthLonger:2]) {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        if (data) {
            NSError *error = nil;
            ret = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        }
    }
    return ret;
}

#pragma mark - MD5加密
+ (NSString *)getSimpleEnc:(NSString *)passwd
{
    if (![Utility isString:passwd lengthLonger:0]) {
        return nil;
    }
    return [MD5Hash multiMD5:passwd offset:20];
}

+ (NSURL *) getHeadUrl:(NSInteger)uid
{
    NSString *path ;//= [NSString stringWithFormat:@"http://%@/api/photo/%@",API_HOST,NSStringFromInt(uid)];
    return [NSURL URLWithString:path];
}
+ (NSURL *) getFullUrl:(NSString *)subUrlStr
{
    NSString *path ;//= [NSString stringWithFormat:@"http://%@/%@",API_HOST,subUrlStr];
    return [NSURL URLWithString:path];
}
+ (NSURL *) getHTTPUrl:(NSString *)url{
    if (![url hasPrefix:@"http"]) {
        return [ApiHelp getFullUrl:url];
    }
    return [NSURL URLWithString:url];
}
+ (NSString *)getApiUrl
{
    return @"api/api.aspx";
}
+ (NSMutableDictionary *)getSimpleDic
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithCapacity:4];
//    dic[@"openId"] = [AppShareContext sharedAppShareContext].mUser.wxOpenid;
//    dic[@"accessToken"] = [AppShareContext sharedAppShareContext].mUser.accessToken;
    dic[@"phonePlateform"] = @(1);
    dic[@"phoneVersion"] = @(1);
    
    return dic;
}
@end
