//
//  MResult.h
//  PhoneGame
//
//  Created by tulip on 14-4-29.
//  Copyright (c) 2014年 co5der. All rights reserved.
//


@interface MParam : NSObject
@property (nonatomic, assign) NSInteger currPage;//def 0
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger pageSize;//def 10
@property (nonatomic, assign) NSInteger total;
- (NSMutableDictionary *) getBBSDic;
- (BOOL) haveMore;
- (instancetype)initWithCur:(NSInteger)cur ps:(NSInteger)ps;
@end

@interface MResult : NSObject 
@property (nonatomic, strong) NSString *respcode; //if success,0,else error.
@property (nonatomic, strong) NSString *respmsg;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, assign) long time; //unix timestamp
@property (nonatomic, strong) NSDictionary *respdata;
@property (nonatomic, strong) id retObject;
@property (nonatomic, strong) MParam *param;
- (BOOL) isSuccess;
- (BOOL) accessExpired;
@end
