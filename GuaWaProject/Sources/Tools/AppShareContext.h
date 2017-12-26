//
//  AppShareContext.h
//  youyou
//
//  Created by co5der on 13-6-20.
//  Copyright (c) 2013年 co5der. All rights reserved.
//
@class MUser;
@class MCity;
#import <CoreLocation/CoreLocation.h>


@interface AppShareContext : NSObject {
    MCity *_mCity;
}

@property (atomic, strong) MUser *mUser;
@property (nonatomic, strong) MCity *mCity;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *chooseAddress;
//weak id ,to check if chatView is activity.
@property (atomic, strong) NSString* chatingName;
@property (atomic, assign) BOOL openUpdateLocation;
@property (atomic, assign) BOOL hadUpToken;
@property (atomic, assign) BOOL haveLoadMessage;
@property (atomic, assign) BOOL reUpdata;
@property (nonatomic, strong) NSString *tokenStr;
@property (nonatomic, strong) NSString *buildIdStr;
@property (nonatomic, strong) NSString *chatBgPath;
@property (nonatomic, strong) NSDictionary *thirdLoginDic;

@property (nonatomic, strong) NSString *thirdPartTockon;//微博tockon

//@property (nonatomic, assign) double distance;//计算距离

/**
 * 区分商家端和用户端，当为YES时表示为商家端，否则为用户端
 */
@property (assign, nonatomic) BOOL isShopIdentity;

@property (nonatomic, strong) NSString *deviceName;
//for face input view.
@property (atomic, assign) BOOL disAbleImage;
@property (nonatomic, strong) UIWebView *callWebView;
@property (atomic, assign) NSInteger tabIndex;
@property (atomic, assign) NSInteger badageValue;
@property (atomic, assign) NSInteger unReadedSysCnt;
@property (atomic, assign) BOOL cityIsChange;
@property (atomic, assign) BOOL selectNeedUp;
@property (nonatomic, strong) NSArray *myFavGameList;
//host
@property (nonatomic, strong) NSString *imDomain;
@property (nonatomic, strong) NSString *apiDomain;
@property (nonatomic, strong) NSString *imgPreUrl;

DEFINE_SINGLETON_FOR_HEADER(AppShareContext);
+ (NSString *)getOwnerWhereStr;
+ (NSMutableDictionary *) getLoginUserInfo:(NSString *)action;
+ (BOOL) isMyself:(NSString *)name;
+ (NSString *)generateMsgId;
+ (NSString *)getKeyWithUName:(NSString *)key;

- (void) delSectionID;

-(BOOL) canEdit:(NSDictionary *)user;
-(void) saveProperty:(NSDictionary *)dict;
-(NSDictionary *) getUnCompletedDict;
-(void) reset;
-(BOOL) isLowDevices;
- (BOOL) setOnlineDomain:(NSDictionary *)paramDict;
- (NSString *)getApiDomainStr;
- (NSString *)getImgPreUrlStr;
+ (NSMutableDictionary *)getLoginUserInfo;
@end
