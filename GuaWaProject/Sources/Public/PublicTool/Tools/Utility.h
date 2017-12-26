//
//  Utility.h
//  youyou
//
//  Created by co5der on 13-5-6.
//  Copyright (c) 2013年 co5der. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <Reachability.h>
#import <MBProgressHUD.h>

@class BaseController;
@class MLocationInfo;
@class MSysMsg;
//some Animation Type
#define LKView_Anima_RippleEffect @"rippleEffect" //滴水效果
// some sub type
#define LKView_AnimaSubType_FromTop kCATransitionFromTop //从上方进入
#define LKView_AnimaSubType_FromBottom kCATransitionFromBottom //从下方进入
#define LKView_AnimaSubType_FromLeft kCATransitionFromLeft  //从左边进入
#define LKView_AnimaSubType_FromRight kCATransitionFromRight //从右边进入

// 是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 是否模拟器
//#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)

@interface Utility : NSObject <MBProgressHUDDelegate>
@property (nonatomic, strong) MBProgressHUD *base_hud;
@property (nonatomic, assign) NetworkStatus currentReachabilityStatus;
@property (nonatomic, strong) NSDateFormatter *mDateFormatter;
@property (atomic, assign) BOOL isReachViaWWAN;

DEFINE_SINGLETON_FOR_HEADER(Utility)
//for MBProgress HUD show.
+ (void)showHUDProgress:(NSString*)text onView:(UIView *) baseView mode:(MBProgressHUDMode)mode;
+ (void)showIndeterminateHUDProgress:(NSString*)text onView:(UIView *) baseView;
+ (void)changeOrCreateHUDProgress:(NSString*)text onView:(UIView *) baseView mode:(MBProgressHUDMode)mode;
+ (void)hideHUDProgress:(BOOL)animated;
+ (void)hideHUDProgress:(BOOL)animated afterDelay:(NSTimeInterval)delay;
+ (void)showErrorAndDismiss:(NSString *)text onView:(UIView *) baseView afterDelay:(NSTimeInterval)delay;
+ (MBProgressHUD *) getCurrentBaseHud;

+ (AppDelegate *)appDelegate;
+ (NSInteger) getFileSize:(NSString*) path;
+ (NSString *)formatDateFromNow:(NSDate *)date dateFormat:(NSDateFormatter *)format;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (BOOL)APiOs5ISupported;
+ (id)loadViewOfClass:(Class) clazz;
+ (id)loadViewOfNibName:(NSString *)nibName;

+ (BOOL) removeFileBypath:(NSString *)path;
+ (BOOL) isString:(NSObject *)str lengthLonger:(NSInteger)length;
+ (NSDate *) getDateFromString:(NSString *)str formatter:(NSDateFormatter *)formatter;
+ (NSDate *) getDayBegin:(NSDate *)date;
+ (NSDate *) getDayEnd:(NSDate *)date;
+ (NSDate *) getTodayBeginDate:(NSDateFormatter *)formatter;
+ (NSString *) formatDateS:(NSTimeInterval)date_timeInterval;
+ (NSString *) formatDateST:(NSTimeInterval)date_timeInterval;
+ (NSString *) formatDate:(NSTimeInterval)date_timeInterval formatter:(NSDateFormatter *)formatter;
+ (NSString *) formatBirthday:(NSTimeInterval)date_timeInterval formatter:(NSDateFormatter *)formatter;
+ (NSString *) formatDateBy:(NSString *)format date:(NSDate *)date;
+ (NSString *) formatHumanDate:(NSDate *)date;
+ (NSString *) formatBirthday:(double)bir;
+ (NSString *)timeFormattedHour:(double)totalSeconds;
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
+ (NSDate *) getDateFromString:(NSString *)str format:(NSString *)format;
+ (NSInteger) getIntValueFromObj:(NSObject *)data;
+ (NSString *) getStrFromObj:(NSDictionary *)dict key:(NSObject *)key def:(NSString *)def;
+ (double) getDoubleValueFromObj:(NSDictionary *)dict key:(NSObject *)key def:(double)def;

+ (void) setCircleBorder:(UIView *)v borderWidth:(NSInteger) width;

+ (NSInteger) getStringCount:(NSString*)string;

+ (NSString *) formatDistance:(double)distance;

+ (NSArray *) getInsertPaths:(NSInteger)oldCnt addCount:(NSInteger)count;

+ (void)showHelpView:(UIView *)inView delegate:(id)del imgStr:(NSString *)imgPath;
+ (void)hideHelpView:(UIView *)inView helpView:(UIView *)help;

+ (CATransition*)AnimationLayer:(NSString *)type;
+ (CATransition*)AnimationLayer:(NSString *)type subType:(NSString *)subType;

+ (void)setCircleRadius:(UIView *)view borderColor:(UIColor *)color;
+ (void)setButtonRadius:(UIView *)view borderColor:(UIColor *)color;
+ (void)setViewRadius:(UIView *)view borderColor:(UIColor *)color CornerRadius:(CGFloat)cornerRadius;
+ (void) removeAllSubView:(UIView*) view;

+ (BOOL) validateEmail: (NSString *) candidate;
+ (BOOL) isMobileNumber:(NSString *)mobileNum;

+ (NSInteger)getYear;
+ (NSString*)deviceName:(NSString *)deviceString;

+ (NSArray *) splitEx:(NSString *)inputStr regStr:(NSString *)regStr;
+ (NSString *) replaceImageFrom:(NSString *)html srcList:(NSMutableArray *)arr rowIndx:(NSInteger)row;
+ (NSString *) addHttpUrl:(NSString *)url;
+ (NSString *) rmHttpUrl:(NSString *)url;

+(NSString *)trimStr:(NSString *)str;
/**
 * 设置第一次启动
 */
+(void) setFirstLaunch:(NSString *)buildID;
/**
 * 是否第一次启动
 */
+(BOOL) isFirstLaunch;
+(BOOL) isFirstLaunch:(NSString *)imageStr;
+(NSString *)getChatBgFromLocal;

//创建导航栏按钮纯文字
+ (void)setNavigationBarItemWithController:(UIViewController *) conroller
                                 withTitle:(NSString *) title
                                    action:(SEL)action
                                      left:(BOOL)left;

//显示圆形头像
+(void)setViewRaduis:(UIView *)view;
//轮播图地址数组
+(NSMutableArray *)bannerHttpArr:(NSArray *)arr;
//获取lab高度
+ (CGFloat)heightForCellWithText:(NSString *)contentText fontSize:(CGFloat)labelFont labelWidth:(CGFloat)labelWidth;
+(UITableViewCell *)getTableviewCell:(id)sender;
+(UIView *)getViewFromTableview:(id)object;
//根据vip等级返回图片
+(UIImage *)gradeGetImg:(long int)vip;
//加载图片
+(void)setImageView:(UIImageView *)imageView andUrl:(NSString *)url;
+ (NSString *)toJson:(NSObject *)obj;
+(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool;

//识别银行卡的合法性
+ (BOOL) isValidCreditNumber:(NSString*)cardNum;
//身份证识别
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo;
//获取手机密文
+ (NSString *)getSecretMobile:(NSString *)mobile;
//日期
+ (NSString *)timeFormatted:(double)totalSeconds;
/**
 *  @return 6月5日 18：00
 */
+ (NSString *)timeFormattedForMonthAndDay:(double)totalSeconds;
//获取字符串后四位
+ (NSString *)getLastFourString:(NSString *)string;
//判断是否包含表情
+ (BOOL)stringContainsEmoji:(NSString *)string;
//判断是否为中文
+ (BOOL)isChinese:(NSString *)string;
//判断是否为英文
+ (BOOL)isEnglish:(NSString *)string;
//返回手机格式
+ (NSString *)returnMobile:(NSString *)string;

+(CGFloat)headerViewHeightWithTitle:(NSString *)title andDesc:(NSString *)desc andNormalHeight:(CGFloat)retHeight;

+(NSAttributedString *)getHtmlString:(NSString *)str;
+ (UIViewController *)getCurrentVC;
//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color;
//正则去除html标签 take 表示取前几个字
+ (NSString *) html2String:(NSString *)input take:(NSInteger)take;
+ (void)sendMessageToShop:(MSysMsg *)msg status:(NSInteger)status;
+ (void)sendMessageYaoQi:(MSysMsg *)msg status:(NSInteger)status;
+ (void)sendMessageWithJoin:(MSysMsg *)msg status:(NSInteger)status;

+ (NSTimeInterval)getTimeNowWithZone;
+ (NSInteger)getUserUnreadMessageNum;
+ (NSInteger)getShopUnreadMessageNum;
+ (BOOL)isHTTPEnable;//检测应用网络权限
+ (UIImage *)fixOrientation:(UIImage *)aImage;
+ (UIImage *)resizableImageWithImage:(UIImage *)image;
+ (UIFont *)getFont:(NSInteger)fontSize;
//设置返回按钮背景图
+ (void)resizableImageWithBackBtn:(UIButton *)backBtn andTitle:(NSString *)title;

@end
