//
//  ApiHelp.h
//  JYApp
//
//  Created by co5der on 14-3-7.
//  Copyright (c) 2014年 co5der. All rights reserved.
//

#import <Foundation/Foundation.h>

//打印API log
//#ifdef DEBUG
//#    define API_LOG(...) NSLog(__VA_ARGS__)
//#else
//#    define API_LOG(...) /* */
//#endif
#define API_LOG(...) /* */


#define API_VER @"v1"
#define SERVER_CALL @"400-863-9889"

#define USERIMAGE_PRE [[AppShareContext sharedAppShareContext] getImgPreUrlStr]//@"http://yoyou.dmfive.com/d/file/user/" //user send image url pre

//common param
#define TYPE_PARAM @"type"
#define EXT_PARAM @"ext"
#define ID_PARAM @"id"
#define NEW_PARAM @"new"
#define PAGESIZE_PARAM @"pagesize"
#define TIME_PARAM @"time"
#define URL_PARAM @"url"
#define IMAGEID_PARAM @"image_id"


//database
#define DB_TABLE_NUM 5
#define DB_FRIEND_TABLE @"user_friend"
#define DB_MSG_TABLE @"user_msg"
#define FROM_UNAME_PARAM @"from_username"
#define TO_UNAME_PARAM @"to_username"
#define FROM_NICK_PARAM @"from_nick"
#define TO_NICK_PARAM @"to_nick"
#define MSG_BODY_PARAM @"msg_body"

//local
#define LOCAL_USER_DICT @"local_user_dict"
#define LOCAL_DB_INITNUM @"local_db_init_num"
#define LOCAL_PENG_DICT @"local_userpeng_dict"
#define LOCAL_CHATBG_PATH @"local_chat_bg_path"
#define LOCAL_CHAT_RECIVER @"local_chat_use_listen"


#define INPUT_ICON_LIST @[@"icon_photo.png", @"icon_photograph.png"]


#define HEAD_PLACEHOLDER [UIImage imageNamed:@"place_head.png"]
#define VOICE_IMAGE_ME [UIImage imageNamed:@"icon_sound_me.png"]
#define VOICE_IMAGE_OTHER [UIImage imageNamed:@"icon_sound.png"]
#define VOICE_IMAGES_ME @[ \
[UIImage imageNamed:@"icon_sound_me_2.png"], \
[UIImage imageNamed:@"icon_sound_me_1.png"], \
[UIImage imageNamed:@"icon_sound_me.png"]]
#define VOICE_IMAGES_OTHER @[ \
[UIImage imageNamed:@"icon_sound_2.png"], \
[UIImage imageNamed:@"icon_sound_1.png"], \
[UIImage imageNamed:@"icon_sound.png"]]
#define VOICE_IMAGES_COMM @[ \
[UIImage imageNamed:@"ic_sound_3.png"], \
[UIImage imageNamed:@"ic_sound_2.png"], \
[UIImage imageNamed:@"ic_sound_1.png"], \
[UIImage imageNamed:@"ic_sound.png"]]

//app UI photo view
#define PHOTO_PLACEHOLDER [UIImage imageNamed:@"place_head.png"]
#define BACKPIC_PLACEHOLDER [UIImage imageNamed:@"index_bg.jpg"]
#define PHOTO_WIDTH 300.0f
#define PHOTO_FULL_WIDTH 298.0f

#define PHOTO_BOTTOM_LABEL_H 32.0f

typedef enum : NSUInteger {
    MUserTypeTeacher = 1,
    MUserTypeStuden,
    MUserTypeOther
} MUserType;

typedef enum {
    UPLOAD_TYPE_VOICE = 0,
    UPLOAD_TYPE_IMAGE
} UPLOAD_TYPE;

@interface ApiHelp : NSObject
+ (id) getJSONFromResponse:(id)str;
+ (NSURL *) getHeadUrl:(NSInteger)uid;
+ (NSURL *) getFullUrl:(NSString *)subUrlStr;
+ (NSString *)getSubUrl:(NSString *)mode Action:(NSString *)action Param:(NSDictionary *)param;
+ (NSString *)getApiUrl;
+ (NSString *)getSimpleEnc:(NSString *)passwd;
+ (NSMutableDictionary *)getSimpleDic;
@end
