//
//  MResult.m
//  PhoneGame
//
//  Created by tulip on 14-4-29.
//  Copyright (c) 2014年 co5der. All rights reserved.
//

#import "MResult.h"

@implementation MResult
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"respcode":@"success",
             @"respmsg":@"errorMessage",
             @"respdata":@"data"
             };
}
- (BOOL) isSuccess
{
    if (_respcode &&[_respcode isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}
- (BOOL) accessExpired
{
    return NO;
}
@end

@implementation MParam
+ (NSDictionary *) modelCustomPropertyMapper {
    return @{};
}

//overwrite
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pageSize = DEF_PAGE_SIZE;
        self.currPage = 0;
    }
    return self;
}
- (instancetype)initWithCur:(NSInteger)cur ps:(NSInteger)ps
{
    self = [super init];
    if (self) {
        self.currPage = cur>0?cur:0;
        self.pageSize = ps;
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone
{
	MParam *p = [[MParam allocWithZone:zone] init];
	p.currPage = self.currPage;
    p.pageSize = self.pageSize;
    p.total = self.total;
    p.pageCount = self.pageCount;
	return p;
}

- (BOOL) haveMore
{
    if ((_currPage+1)*_pageSize < _total) {//have more
        return YES;
    }
    return NO;
}
- (NSMutableDictionary *) getReqDic:(BOOL)isRefresh
{
    NSMutableDictionary *retDict = [NSMutableDictionary dictionaryWithCapacity:4];
    retDict[@"id"] = @(_currPage<0?0:_currPage);
    retDict[@"new"] = isRefresh?@(0):@(1); //get new., 1 load more
    retDict[@"pagesize"] = @(self.pageSize);
    return retDict;
}

- (NSMutableDictionary *) getBBSDic
{
    NSMutableDictionary *retDict = [NSMutableDictionary dictionaryWithCapacity:4];
    retDict[@"pageno"] = @(_currPage);
    retDict[@"pagesize"] = @(self.pageSize);
    return retDict;
}
@end
