//
//  AppShareContext.m
//  youyou
//
//  Created by co5der on 13-6-20.
//  Copyright (c) 2013年 co5der. All rights reserved.
//
#import <sys/utsname.h>
#import "AppShareContext.h"
#import "Utility.h"
#import "MUser.h"
#import "ApiHelp.h"
#import <LKDBHelper.h>
@interface AppShareContext()
//for db
@property (nonatomic, copy) NSString *ownerWhereStr;
@end

@implementation AppShareContext
//DEFINE_SINGLETON_FOR_CLASS(AppShareContext)


+ (AppShareContext *)sharedAppShareContext {
    static AppShareContext *sharedAppShareContext = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAppShareContext = [[self alloc] init];
        struct utsname u;
        uname(&u);
        NSString* machine = [NSString stringWithCString:u.machine encoding:NSUTF8StringEncoding];
        sharedAppShareContext.deviceName = machine;
        sharedAppShareContext.tabIndex = 0;//index
        DLog(@"#####**machine**#####:[%@]",machine);
        sharedAppShareContext.callWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        sharedAppShareContext.openUpdateLocation = [[NSUserDefaults standardUserDefaults] boolForKey:kKey_OPEN_UPDATE_GPS];
        sharedAppShareContext.mUser = [[MUser alloc]init];
        //init database.
//        [AppShareContext initDB];
//        [LKDBHelper getUsingLKDBHelper];
    });
    return sharedAppShareContext;
}




static NSMutableDictionary * _Nonnull extracted() {
    return [NSMutableDictionary dictionaryWithCapacity:3];
}

+ (NSMutableDictionary *) getLoginUserInfo:(NSString *)action
{
    NSMutableDictionary *retDict = extracted();
    AppShareContext *app = [AppShareContext sharedAppShareContext];
    
    return retDict;
}

+ (BOOL) isMyself:(NSString *)name
{
    BOOL ret = NO;
//    AppShareContext *app = [AppShareContext sharedAppShareContext];
//    if([[app.mUser getUQName] isEqualToString:name]) {
//        ret = YES;
//    }
    return ret;
}

-(void) reset
{
    self.mUser = nil;
    self.chatBgPath = nil;
    self.chatingName = nil;
    self.hadUpToken = NO;
    self.disAbleImage = NO;
    self.tabIndex = 0;
    self.badageValue = 0;
    self.ownerWhereStr = nil;
    self.unReadedSysCnt = 0;
    self.isShopIdentity = NO;
    self.haveLoadMessage = NO;
    
    
}

+ (NSMutableDictionary *) getLoginUserInfo
{
    NSMutableDictionary *retDict = [NSMutableDictionary new];
    AppShareContext *app = [AppShareContext sharedAppShareContext];
    
    //,@"usertype":@"1"
//    if ([Utility isString:app.mUser.username lengthLonger:0] && [Utility isString:app.mUser.password lengthLonger:0]) {
//        retDict = [@{@"username":app.mUser.username, @"password":StringEmpDef(app.mUser.password.length < 20?[ApiHelp getSimpleEnc:app.mUser.password]:app.mUser.password)} mutableCopy];
//    }
    return retDict;
}

- (BOOL) isLowDevices {
    if ([_deviceName hasPrefix:@"iPhone3"]) {
        return YES;
    }
    return NO;
}

-(BOOL) canEdit:(NSDictionary *)user
{
//    if(user && [[user objectForKey:USERNAME_PARAM] isEqualToString:[self.userInfo objectForKey:USERNAME_PARAM]]){
//        return YES;
//    }
    return NO;
}

-(void) saveProperty:(NSDictionary *)dict
{
//    NSMutableDictionary *newDict = [NSMutableDictionary dictionaryWithDictionary:_userInfo];
//    for (NSString *key in [dict allKeys]) {
//        if ([key isEqualToString:PASSWD_PARAM]) {
//            continue;
//        }
//        [newDict setObject:[dict objectForKey:key] forKey:key];
//        DLog(@"key:%@, v:%@, s:%@",key, [dict objectForKey:key], [newDict objectForKey:key]);
//    }
//    
//    [NetRequest saveUserPropertyToLocal:newDict];
//    for (NSString *k in [dict allKeys]) {
//        DLog(@"new,key:%@ = %@",k, [dict objectForKey:k]);
//        DLog(@"old,key:%@ = %@",k, [newDict objectForKey:k]);
//        DLog(@"sav,key:%@ = %@",k, [_userInfo objectForKey:k]);
//    }
}

-(NSDictionary *) getUnCompletedDict
{
//    NSDictionary *ret = nil;
//    NSArray *mustList = MUST_PROPERTY_LIST;
//    for (NSDictionary *ty in mustList) {
//        NSString *key = [ty objectForKey:@"key"];
//        NSObject *type = [ty objectForKey:@"type"];
//        if ([type isKindOfClass:[NSString class]]) {
//            if (![Utility isString:[_userInfo objectForKey:key] lengthLonger:0]) {
//                DLog(@"unCmp, key:%@, uValue:%@",key, [_userInfo objectForKey:key]);
//                ret = ty;
//                break;
//            }
//        } else if ([type isKindOfClass:[NSArray class]]) {
//            NSArray *tmp = [_userInfo objectForKey:key];
//            if (!(tmp && [tmp isKindOfClass:[NSArray class]] && tmp.count > 0)) {
//                ret = ty;
//                break;
//            }
//        } else if ([type isKindOfClass:[NSNumber class]]) {
//            NSNumber *tmp = [_userInfo objectForKey:key];
//            DLog(@"numCmp, key:%@, uValue:%@",key, [_userInfo objectForKey:key]);
//            if (tmp && ([tmp isKindOfClass:[NSNumber class]] || [tmp isKindOfClass:[NSString class]])) {
//                if (!([Utility getIntValueFromObj:tmp] > 0)) {
//                    ret = ty;
//                    break;
//                }
//            } else {
//                ret = ty;
//                break;
//            }
//            
//        }
//    }
    return nil;
}

- (BOOL) setOnlineDomain:(NSDictionary *)paramDict
{
    BOOL ret = NO;
    if([paramDict objectForKey:@"app_api_domain"]) {
        ret = YES;
        self.apiDomain = [NSString stringWithFormat:@"http://%@/?",[paramDict objectForKey:@"app_api_domain"]];
        self.imgPreUrl = [NSString stringWithFormat:@"http://%@/d/file/user/",[paramDict objectForKey:@"app_api_domain"]];
    }
    if ([paramDict objectForKey:@"app_im_domain"]) {
        ret = YES;
        self.imDomain = [paramDict objectForKey:@"app_im_domain"];
    }
    return ret;
}

- (NSString *)getApiDomainStr
{
    if (![Utility isString:_apiDomain lengthLonger:5]) {
        //try again.
//        [[AppShareContext sharedAppShareContext] setOnlineDomain:[MobClick getConfigParams]];
//        if (![Utility isString:_apiDomain lengthLonger:5]) {
//            return @"http://yoyou.iyoyou.cn/?";
//        }
    }
    return _apiDomain;
}
- (NSString *)getImgPreUrlStr
{
//    if (![Utility isString:_imgPreUrl lengthLonger:8]) {
//        //try again.
//        [[AppShareContext sharedAppShareContext] setOnlineDomain:[MobClick getConfigParams]];
//        if (![Utility isString:_imgPreUrl lengthLonger:8]) {
//            return @"http://yoyou.iyoyou.cn/d/file/user/";
//        }
//    }
    return _imgPreUrl;
}
//
+ (void) initDB
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [LKDBUtils getPathForDocuments:DBFILE_NAME inDir:@"db"];
    DLog(@"DB:%@",filePath);
    if(![fileManager fileExistsAtPath:filePath]) //如果不存在
    {
        NSString *dbPath = [NSBundle pathForResource:@"LKDB"
                                              ofType:@"db"
                                         inDirectory:[[NSBundle mainBundle] bundlePath]];
        NSError *error;
        if([fileManager copyItemAtPath:dbPath toPath:filePath error:&error]) //拷贝
        {
            NSLog(@"#copy %@ success",filePath);
        }
        else
        {
            NSLog(@"#copy db file: %@",error);
        }
    }
}

-(void)setMCity:(MCity *)mCity{
    _mCity = mCity;
    [self saveCity:_mCity];
}


- (MCity *)mCity {
    if (_mCity) {
        return _mCity;
    }
    MCity * city = [self readCity];
    if (city) {
        _mCity = city;
        return _mCity;
    }
//    city = [MCity new];
//    city.city_name = @"厦门";
//    city.city_id = 9;
//    city.latitude = 24;
//    city.longitude = 118;
//    _mCity = city;
    return _mCity;
}

-(void)saveCity:(MCity *)city{
    // 要归档的对象.
    // 创建归档时所需的data 对象.
    NSMutableData *data = [NSMutableData data];
    
    // 归档类.
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    // 开始归档（@"model" 是key值，也就是通过这个标识来找到写入的对象）.
    [archiver encodeObject:city forKey:@"city"];
    
    // 归档结束.
    [archiver finishEncoding];
    
    // 写入本地（@"weather" 是写入的文件名）.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:CITY_SERVER_NAME];
    
    [data writeToFile:file atomically:YES];
}

-(MCity *)readCity{
    // 从本地（@"weather" 文件中）获取.
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:CITY_SERVER_NAME];
    
    // data.
    NSData *data = [NSData dataWithContentsOfFile:file];
    
    // 反归档.
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    // 获取@"model" 所对应的数据
    MCity *city = [unarchiver decodeObjectForKey:@"city"];
    
    // 反归档结束.
    [unarchiver finishDecoding];
    
    return city;
}
@end
