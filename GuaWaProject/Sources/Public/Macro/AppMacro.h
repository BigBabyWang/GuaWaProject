//
//  AppMacro.h
//  PhoneGame
//
//  Created by co5der on 14-3-4.
//  Copyright (c) 2014年 co5der. All rights reserved.
//

#ifndef PhoneGame_AppMacro_h
#define PhoneGame_AppMacro_h
//正式服
#define IMPORT 8080
#define API_HOST @"test.guawaapp.com"

//测试服
//#define IMPORT 8080
//#define API_HOST @"def.guawa.com"


#define IMHOST @"220.160.127.98 "


///打开 发送语音功能
//#define VOICE_ON 1


//#define PROFILE_TEST 1

#define SEVRVICE_CALL @""
#define APPSTORE_URL [NSString stringWithFormat:@"http://%@/",API_HOST]//@"https://itunes.apple.com/us/app/guo-ke-zu/id910856784?l=zh"

#define is13859904670 1;
//版本
#define SOFTVER ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define PHONEVER    @"1"

#define VERNAME(p) [NSString stringWithFormat:@"%@",p];

#define DEF_PAGE_SIZE 10

#define PG_APP_NAME @""
#define DBFILE_NAME @"LKDB.db"
#define CACHE_DIR_NAME @"JHWImageCaches"

#define USE_MANUAL_DOWNIMG 1 // 0//

#define PASS_STORE_PHONE @"pass.com.GuaWa.phone"
#define PASS_STORE_PASSWD @"pass.com.GuaWa.passwd"
#define PASS_STORE_NAME @"pass.com.GuaWa.name"
#define PASS_SERVER_NAME @"com.GuaWa.pass"
#define CITY_SERVER_NAME @"com.GuaWa.city"
#define APP_SCHEMES @"com.matchlive.xmrk"
///测试电话
#define TEST_PHONE @"18888888888"
//变发型临时存放文件
#define ImageFilePath @""

#define BOTTOM_TABBAR_SELECTED_COLOR @"#00b6fa"
#define kPushAnimationDuration (ios7After?0.25:0.35f)

#define DM_TAB_HEIGHT 55.0f
#define DM_TAB_OFFSET (50-DM_TAB_HEIGHT)
#define ICON_WIDTH 50//65.0f
#define ICON_TITLE 25.0f

//网络错误提示语
#define DEF_ERROR_INFO @"您的网络不给力"
#define DEF_ERROR_TEXT @"您的网络不给力,请确认网络权限是否开启，您可以在“设置”中为此应用打开蜂窝移动数据。"


#define DEF_HEAD_IMG [UIImage imageNamed:@"ic_moren.png"]
//默认banner预加载图片
#define DEF_BANNER_IMG [UIImage imageNamed:@"jiazaishibai"]

#define DEF_MOREN_IMG DEF_BANNER_IMG
///默认头像
#define DEF_USER_IMG [UIImage imageNamed:@"touxiang_test"]
///默认通知 图标
#define DEF_NOTICE_IMG [UIImage imageNamed:@"ic_moren.png"]

///默认文字选择颜色
#define DEF_TEXT_SELECT_COLOR [UIColor colorWithHex:@"FC1755"] // 红色
///商家端tabbarItem文字颜色
#define DEF_SHOP_TAB_COLOR [UIColor colorWithHex:@"50E3C2"] // 绿色
///默认边框颜色
#define DEF_LINE_COLOR [UIColor colorWithHex:@"7D7E7F"]
///日历背景色
#define DEF_CALENDAR_COLOR [UIColor colorWithHex:@"303132"]
///字体绿色
#define DEF_TEXT_COLOR [UIColor colorWithHex:@"50E3C2"]
///字体橙色
#define DEF_TEXT_COLOR_ORANGE [UIColor colorWithHex:@"F5A623"]
///红色
#define DEF_BACK_RED_COLOR [UIColor colorWithHex:@"FC1755"]
///渐变开始颜色
#define DEF_START_COLOR @"53184F"
///渐变结束颜色
#define DEF_END_COLOR @"240F23"
///错误色值
#define DEF_ERROR_COLOR @"FC1755"

///聊天输入框颜色
#define CHAT_TEXTVIEW_COLOR [UIColor colorWithHex:@"9B9B9B"]

///搜索框背景色
#define DEF_SEARCH_COLOR [UIColor colorWithRed:83/255.0 green:24/255.0 blue:79/255.0 alpha:0.9]
///导航栏颜色
#define DEF_NAV_COLOR [UIColor colorWithHex:@"FCD049"]
///用户端背景色
#define DEF_CVBG_COLOR [UIColor colorWithHex:@"FFFFFF"]
///紫色
#define DEF_PURPLE_COLOR [UIColor colorWithHex:@"440D41"]
///placeholderColor
#define DEF_PLACEHOLDER_COLOR [UIColor colorWithHex:@"9B9B9B"]
///NavBlur_COLOR
#define DEF_NavBlur_COLOR [UIColor colorWithRed:80/255.0 green:5/255.0 blue:80/255.0 alpha:0.3];

#define kKey_OPEN_UPDATE_GPS @"key_open_update_gps_sw"
#define kMainBannerList @"key_main_banner_list"
//适配iPhone6 字体
#define SYRealValue(value) ((value)/320.0f*ScreenWidth)
#define CESHI_IMAGE @"http://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoZcNUicpL9ic9l7vn7QrPdR6LR0DXicLMzRetXG92pw4lGUYQFDTIa3e2rkWBtzEk5zEFkOm2Eyzgnw/0"
#endif
