//
//  UtilsMacro.h
//  PhoneGame
//
//  Created by co5der on 14-3-4.
//  Copyright (c) 2014年 co5der. All rights reserved.
//

#ifndef PhoneGame_UtilsMacro_h
#define PhoneGame_UtilsMacro_h

//打印DEBUG log
#ifdef DEBUG
#    define DLog(...) NSLog(__VA_ARGS__)
#else
#    define DLog(...) /* */
#endif
//nil默认 @""
#define NilWithEMP(p) (p?p:@"")
#define StringWithEmp(p) ([NSString stringWithFormat:@"%@",(!p || [p isKindOfClass:[NSNull class]])?@"":p])
#define StringWithInterger(p) ([NSString stringWithFormat:@"%ld",(long)p])
//weak self for block
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define RK_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define RK_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

//整型转NSString
#define NSStringFromInt(intValue) [NSString stringWithFormat:@"%ld",(long)intValue]
#define StringEmpDef(p) (p?[NSString stringWithFormat:@"%@",p]:@"")
//hud 显示文字错误提示
//MBProgressHUD show in BaseView
#define HUDBASEVIEW self.navigationController.view
#define SHOWHUDERR(str) {[Utility showErrorAndDismiss:str onView:HUDBASEVIEW afterDelay:1.5];}
#define SHOWHUDLONGSTR(msg) {\
[Utility showErrorAndDismiss:@"" onView:HUDBASEVIEW afterDelay:2];\
MBProgressHUD *pv = [Utility getCurrentBaseHud];\
pv.detailsLabelText = msg;\
}
#define SHOWHUDLOAD(str) {[Utility showIndeterminateHUDProgress:str onView:HUDBASEVIEW];}
#define CHANGETXT(str) {[Utility changeOrCreateHUDProgress:str onView:HUDBASEVIEW mode:MBProgressHUDModeText];}
#define HIDEHUD(animated) {[Utility hideHUDProgress:animated];}
//网络错误提示
#define ERROR_NET {\
if(!self.isAppearing) return; \
@try {\
SHOWHUDERR(@"网络不给力");\
} @catch (NSException *exception) {\
NSLog(@"%@",exception);\
}\
}
//push ViewControl
#define PUSH_CONTROL(className) {\
    className *gc = [[className alloc] init];\
    gc.hidesBottomBarWhenPushed = YES;\
    [self.navigationController pushViewController:gc animated:YES];\
}

#define DMPUSH_CONTROL(className) {\
className *gc = [[className alloc] init];\
gc.hidesBottomBarWhenPushed = YES;\
[self dmPush:gc animated:YES];\
}


// 是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 是否模拟器
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)

//ARC单例
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#define DATE_FORMAT                 @"yyyy-MM-dd"
#define DATE_FORMAT_MONTH_DAY       @"MM-dd"
#define SHORT_TIME_FORMAT           @"HH:mm"
#define SHORT_DATETIME_FORMAT       @"yyyy-MM-dd HH:mm"
#define DATETIME_FORMAT             @"yyyy-MM-dd HH:mm:ss"
#define WEEK_FORMAT                 @"cc"
#define TIME_FORMAT                 @"HH:mm:ss"
#define ONE_DAY_TIME                (24*60*60)
#define ONE_HOUR_TIME               (60*60)
#define PAY_TYPE_ONLINE             @"1" //1在线  //提现
#define PAY_TYPE_OFFLINE            @"2" //2到付  //充值
#define PAY_TYPE_ALL                @"0" //全部
#define MAINCOLOR                   @"E5302C" //app主色调-暗红
#define BGCOLOR                     @"dedede" //app主背景颜色—浅灰
#define LINECOLOR                   @"dadada" //app线颜色
#define BTN_HOME_GREENCOLOR         @"3ec776" //app绿色
#define BTN_HOME_PURITYCOLOR        @"f68a42" //app澄色
#define BTN_HOME_GRAYCOLOR          @"d2d2d2" //app灰色
#define BTN_HOME_BLUECOLOR          @"4ea9eb" //app蓝色
#define LBLUECOLOR                  @"19D7FF" //app浅蓝色
#define YELLOWCOLOR                 @"F5A623" //app土黄色
#define LIGHTGreenCOLOR             @"50E3C2" //app浅绿色

#define LAB_REDCOLOR [UIColor colorWithRed:252.0/255.0 green:26/255.0 blue:96/255.0 alpha:1.0]

//屏幕宽度
#define ScreenWidth             [[UIScreen mainScreen] bounds].size.width
//屏幕高度
#define ScreenHeight            [[UIScreen mainScreen] bounds].size.height
//进度条高度
#define PRO_TOP_HEIGHT 2.8
//底部按钮高度
#define PRO_BOTTON_HEIGHT 56.0f

//应用程序窗口size
#define WindowSize              ( [UIScreen mainScreen].applicationFrame.size )
//应用程序窗口宽度
#define WindowWidth             ( [UIScreen mainScreen].applicationFrame.size.width )
//应用程序窗口高度
#define WindowHeight            ( [UIScreen mainScreen].applicationFrame.size.height )
#define SWIDTH ( [UIScreen mainScreen].applicationFrame.size.height )
#define SHEIGHT ([UIScreen mainScreen].applicationFrame.size.height )
//导航栏高度
#define NavigationBarHeight     ( self.navigationController.navigationBar.frame.size.height )
#define STATUS_TAB_HEIGHT 20.0f

//判断是否iPhone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isSmallHeight ([[UIScreen mainScreen] currentMode].size.height < 1000 ? YES : NO)

//判断是否ios6以上
#define ios6After   ( ([[[UIDevice currentDevice] systemVersion] compare:@"6.0"] ==  NSOrderedAscending) ?  NO : YES )
#define ios7After   ( ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] ==  NSOrderedAscending) ?  NO : YES )

//判断是否iPhone5，4英寸屏
#define isPhone5 (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) )

//安全释放内存
#define SAFE_RELEASE(p) { [p release]; p = nil; }

//去除空格换行符
#define TRIMSTR(p) ([p stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]])

//本地化字符串
#define TEXT(key) (NSLocalizedString(key, nil))
#define REG_SYMBOL @"㩭"

#define CELL_HEIGHT ScreenWidth*1080/1108.0f
#define HEADER_IMAGE_HEIGHT 20.0f

#define PROPERTY_KEY       @"property_key"
#define PLACEHOLDER_KEY    @"placeholder_key"

//快速照片
#define SystemQuickImage(image)  [UIImage imageNamed:image]
#define COLOR(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#endif
