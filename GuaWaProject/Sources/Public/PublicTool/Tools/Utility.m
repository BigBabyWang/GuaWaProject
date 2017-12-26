//
//  Utility.m
//  youyou
//
//  Created by co5der on 13-5-6.
//  Copyright (c) 2013年 co5der. All rights reserved.
//
#import "Utility.h"
#include <QuartzCore/QuartzCore.h>
#import "AppShareContext.h"
#import "NSString+SSToolkitAdditions.h"
#import <RegexKitLite.h>
#import "LocalCache.h"
#import "BaseController.h"
#import "ApiHelp.h"
#import "MLocationInfo.h"
//#import "DGActivityIndicatorView.h"
#define aMinute 60
#define anHour 3600
#define aDay 86400
#define aMonth 2592000
#define aYear 31536000
#define USERDEF_HELPSHOWED @"local_help_showedlist"

@implementation Utility
DEFINE_SINGLETON_FOR_CLASS(Utility)
- (id)init {
    self = [super init];
    if (self) {
        self.isReachViaWWAN = NO;
        [self initReachability];
    }
    return self;
}
- (NSDateFormatter *)getMDateFormatter
{
    if (_mDateFormatter) {
        self.mDateFormatter = [[NSDateFormatter alloc] init];
    }
    return self.mDateFormatter;
}
-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    self.currentReachabilityStatus = reach.currentReachabilityStatus;
    self.isReachViaWWAN = [reach isReachableViaWWAN];
    if([reach isReachable]) {
        if (0 == reach.currentReachabilityStatus) {
            DLog(@"%s =------%@",__func__, @"当前网络不可用");
            //ShowAlertView(noticeStr);
        } else {
        }
    }
    else {
        DLog(@"%s =------%@",__func__, @"当前网络不可用");
        //NSString *noticeStr = @"当前网络不可用";
        //ShowAlertView(noticeStr);
    }
}
- (void)initReachability {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.qq.com"];
    reach.unreachableBlock = ^(Reachability * reachability) {
        DLog(@"%s =------%@",__func__, @"当前网络不可用");
    };
    self.isReachViaWWAN = [reach isReachableViaWWAN];
    [reach startNotifier];
}
#pragma mark - MBProgressHUD
+ (void)showHUDProgress:(NSString*)text onView:(UIView *) baseView mode:(MBProgressHUDMode)mode
{
    [[Utility sharedUtility] showHUBProgress:text onView:baseView mode:mode];
}
+ (void)changeOrCreateHUDProgress:(NSString*)text onView:(UIView *) baseView mode:(MBProgressHUDMode)mode
{
    Utility *uty = [Utility sharedUtility];
    if (uty.base_hud) {
        uty.base_hud.mode = mode;
        uty.base_hud.labelText = text;
        uty.base_hud.cornerRadius = 3;
        uty.base_hud.margin = 5;
        BOOL isShop = NO;//[AppShareContext sharedAppShareContext].isShopIdentity;
        uty.base_hud.color = [UIColor blackColor];
    } else {
        [uty showHUBProgress:text onView:baseView mode:mode];
    }
}
+ (void)showErrorAndDismiss:(NSString *)text onView:(UIView *) baseView afterDelay:(NSTimeInterval)delay
{
    [Utility changeOrCreateHUDProgress:text onView:baseView mode:MBProgressHUDModeText];
    [Utility hideHUDProgress:YES afterDelay:delay];
}
+ (void)showIndeterminateHUDProgress:(NSString*)text onView:(UIView *) baseView {
    [[Utility sharedUtility] showHUBProgress:text onView:baseView mode:MBProgressHUDModeIndeterminate];
}

- (void)showHUBProgress:(NSString*)text
                 onView:(UIView *) baseView
                   mode:(MBProgressHUDMode)mode {
    if (_base_hud) return;
	_base_hud = [[MBProgressHUD alloc] initWithView:baseView];
    
    _base_hud.removeFromSuperViewOnHide = YES;
    _base_hud.minShowTime = 0.1;
	[baseView addSubview:_base_hud];
	

    _base_hud.mode = mode;
	_base_hud.delegate = self;
	_base_hud.label.text = text;
    _base_hud.label.font = [UIFont systemFontOfSize:12];
    _base_hud.layer.cornerRadius = 3;
    _base_hud.margin = 5;
    _base_hud.minSize = CGSizeMake(80, 80);
//    if (mode == MBProgressHUDModeText) {
        _base_hud.contentColor = [UIColor whiteColor];
        _base_hud.color = [UIColor blackColor];
    _base_hud.color = [_base_hud.color colorWithAlphaComponent:0.8];
//    }
    [_base_hud showAnimated:NO];
}

+ (void)hideHUDProgress:(BOOL)animated {
    [[Utility sharedUtility] hideHUDProgressWithInstance:animated];
}

+ (void)hideHUDProgress:(BOOL)animated afterDelay:(NSTimeInterval)delay
{
    [[Utility sharedUtility] hideHUDProgressWithInstance:animated afterDelay:delay];
}
+ (MBProgressHUD *) getCurrentBaseHud
{
    return [[Utility sharedUtility] returnBaseHud];
}
- (MBProgressHUD *) returnBaseHud {
    return _base_hud;
}

- (void)hideHUDProgressWithInstance:(BOOL)animated {
    [_base_hud hide:animated];
}
- (void)hideHUDProgressWithInstance:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [_base_hud hide:animated afterDelay:delay];
}
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)progressHud {
	_base_hud = nil;
}

+ (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
+ (NSInteger) getFileSize:(NSString*) path
{
    NSFileManager * filemanager = [[NSFileManager alloc]init];
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize]) )
            return  [theFileSize intValue];
        else
            return -1;
    }
    else
    {
        return -1;
    }
}

+ (NSString *)formatDateFromNow:(NSDate *)date dateFormat:(NSDateFormatter *)format
{
    NSString *ret = nil;
    if(date) {
        NSTimeInterval timeSinceLastUpdate = [date timeIntervalSinceNow];
        NSInteger timeToDisplay = 0;
        timeSinceLastUpdate *= -1;
        
        if(timeSinceLastUpdate < anHour) {
            timeToDisplay = (NSInteger) (timeSinceLastUpdate / aMinute);
            if (timeToDisplay < 2) {
                ret = [NSString stringWithFormat:@"刚刚"];
            } else {
                ret = [NSString stringWithFormat:@"%ld分钟前",(long)timeToDisplay];
            }
        } else if (timeSinceLastUpdate < aDay) {
            timeToDisplay = (NSInteger) (timeSinceLastUpdate / anHour);
            ret = [NSString stringWithFormat:@"%ld小时前",(long)timeToDisplay];
        } else if (timeSinceLastUpdate < aMonth) {
            timeToDisplay = (NSInteger) (timeSinceLastUpdate / aDay);
            ret = [NSString stringWithFormat:@"%ld天前",(long)timeToDisplay];
        } else { // too long ,show full
            NSDateFormatter *dateFormatter = format;
            if (!format) {
                dateFormatter = [[NSDateFormatter alloc] init];
            }
            [dateFormatter setDateFormat:@"MM月dd日"];
            ret = [dateFormatter stringFromDate:date];
        }
    }
    return ret;
}

//压缩图片
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    //fit size.
//    if (newSize.width > newSize.height) {
//        newSize.height = newSize.width * image.size.height / image.size.width * 1.0f;
//    } else {
//        newSize.width = newSize.height * image.size.width / image.size.height * 1.0f;
//    }
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

+ (BOOL)APiOs5ISupported {
    // containment API is supported on iOS 5 and up
    static BOOL containmentAPISupported;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        containmentAPISupported = ([self respondsToSelector:@selector(willMoveToParentViewController:)] &&
                                   [self respondsToSelector:@selector(didMoveToParentViewController:)] &&
                                   [self respondsToSelector:@selector(transitionFromViewController:toViewController:duration:options:animations:completion:)]);
    });
    
    return containmentAPISupported;
}

+ (id)loadViewOfClass:(Class) clazz {
    @try {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clazz) owner:nil options:nil];
        for (id obj in nib) {
            if([obj isKindOfClass:clazz]) {
                return obj;
            }
        }
        return nil;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

+ (id)loadViewOfNibName:(NSString *)nibName {
    @try {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        for (id obj in nib) {
            return obj;
        }
        return nil;
    }
    @catch (NSException *exception) {
        return nil;
    }
}

+ (BOOL)removeFileBypath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:path error:nil];
}

+ (BOOL) isString:(NSObject *)str lengthLonger:(NSInteger)length
{
    if (str && [str isKindOfClass:[NSString class]]) {
        NSString *st = (NSString *)str;
        return ([st length] > length);
    }
    return NO;
}

+ (NSDate *) getDateFromString:(NSString *)str formatter:(NSDateFormatter *)formatter
{
    //2013-06-20T05:12:04.045Z
    NSString *dateString = nil;
    if ([str hasSuffix:@"Z"]) {
        dateString = [str substringToIndex:[str length] - 1];
        dateString = [dateString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    } else {
        return nil;
    }
    NSDateFormatter *inputFormatter = formatter;
    if (!inputFormatter) {
        inputFormatter = [[NSDateFormatter alloc] init];
    }
    inputFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"]; 
//    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate* inputDate = [inputFormatter dateFromString:dateString];
//    NSLog(@"date = %@", inputDate);
//    
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
//    [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒"];
//    NSString *strs = [outputFormatter stringFromDate:inputDate];
//    NSLog(@"testDate:%@", strs);
    return inputDate;
}
+ (NSDate *) getPreDay:(NSDate *)date
{
    NSTimeInterval timeInt = [date timeIntervalSince1970];
    timeInt -= ONE_DAY_TIME;
    return [NSDate dateWithTimeIntervalSince1970:timeInt];
}
+ (NSDate *) getNexDay:(NSDate *)date
{
    NSTimeInterval timeInt = [date timeIntervalSince1970];
    timeInt += ONE_DAY_TIME;
    return [NSDate dateWithTimeIntervalSince1970:timeInt];
}
+ (NSDate *) getPreMon:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    theComponents.month -= 1;
    DLog(@"da:%@", [calendar dateFromComponents:theComponents]);
    return [calendar dateFromComponents:theComponents];
}
+ (NSDate *) getNexMon:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    theComponents.month += 1;
    DLog(@"da:%@", [calendar dateFromComponents:theComponents]);
    return [calendar dateFromComponents:theComponents];
}
+ (NSDate *) getDayBegin:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *ret = [dateFormatter stringFromDate:date];
    ret = [ret stringByAppendingString:@" 00:00:01"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:ret];
}
+ (NSDate *) getDayEnd:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *ret = [dateFormatter stringFromDate:date];
    ret = [ret stringByAppendingString:@" 23:59:59"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:ret];
}

+ (NSDate *) getTodayBeginDate:(NSDateFormatter *)formatter;
{
    NSDate *dateNow = [NSDate date]; //now
    NSDateFormatter *dateFormatter = formatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *nowStr = [dateFormatter stringFromDate:dateNow];
    NSArray *array = [nowStr componentsSeparatedByString:@":"];
    NSTimeInterval tmp = 0.0f;
    if ([array count] == 3) {
        tmp = [[array objectAtIndex:0] intValue] * 60 *60;
        tmp += [[array objectAtIndex:1] intValue] * 60;
        tmp += [[array objectAtIndex:2] intValue];
    }
    return [NSDate dateWithTimeIntervalSinceNow:-tmp];
}
+ (NSString *) formatDateS:(NSTimeInterval)date_timeInterval
{
    if (date_timeInterval < 1) {
        return @"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *ret = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:date_timeInterval]];
    return ret;
}
+ (NSString *) formatDateST:(NSTimeInterval)date_timeInterval
{
    if (date_timeInterval < 1) {
        return @"";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *ret = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:date_timeInterval]];
    return ret;
}
+ (NSString *) formatDate:(NSTimeInterval)date_timeInterval formatter:(NSDateFormatter *)formatter
{
    NSString *ret = @"";
    if (date_timeInterval < 1) {
        return ret;
    }
    NSDateFormatter *dateFormatter = formatter;
    
    NSInteger timeToDisplay = 0;
    NSDate *showDate = [NSDate dateWithTimeIntervalSince1970:date_timeInterval];
    NSTimeInterval timeSinceLastUpdate = -1 * [showDate timeIntervalSinceNow];
    
    if(timeSinceLastUpdate < anHour) {
        timeToDisplay = (NSInteger) (timeSinceLastUpdate / aMinute);
        if (timeToDisplay < 2) {
            ret = [NSString stringWithFormat:@"刚刚"];
        } else {
            ret = [NSString stringWithFormat:@"%ld分钟前",(long)timeToDisplay];
        }
    } else if (timeSinceLastUpdate < aDay) {
        timeToDisplay = (NSInteger) (timeSinceLastUpdate / anHour);
        ret = [NSString stringWithFormat:@"%ld小时前",(long)timeToDisplay];
        
    } else if (timeSinceLastUpdate < aMonth) {
        timeToDisplay = (NSInteger) (timeSinceLastUpdate / aDay);
        ret = [NSString stringWithFormat:@"%ld天前",(long)timeToDisplay];
        
    } else { // too long ,show full
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
        }
        [dateFormatter setDateFormat:@"yyyy.MM.dd"];
        ret = [dateFormatter stringFromDate:showDate];
    }
    return ret;
}

+ (NSString *) formatBirthday:(double)date_timeInterval formatter:(NSDateFormatter *)formatter
{
    NSDateFormatter *dateFormatter = formatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    }
    NSDate *birth = [NSDate dateWithTimeIntervalSince1970:date_timeInterval];
    
    return [dateFormatter stringFromDate:birth];
}

+ (NSString *) formatDateBy:(NSString *)format date:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];;
    NSDate *dateN = date;
    if (!dateN) {
        dateN = [NSDate date];
    }
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:dateN];
}
+ (NSString *) formatHumanDate:(NSDate *)date
{
    NSString *retStr = @"";
    if(!date)
    {
        return retStr;
    }
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit |
    NSSecondCalendarUnit | NSDayCalendarUnit
    | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSInteger Hour = dateComponent.hour;
    NSString *rv = @"";
    if (Hour >= 0 && Hour < 6) {
        rv=@"凌晨";
    } else if (Hour > 5 && Hour < 13) {
        rv=@"早上";
    } else if (Hour > 12 && Hour < 18) {
        rv=@"下午";
    } else {
        rv=@"晚上";
    }
    rv = [rv stringByAppendingFormat:@"%2ld:%2ld",(long)dateComponent.hour, (long)dateComponent.minute];
    NSDate *todayBegin = [Utility getTodayBeginDate:nil];
    NSTimeInterval timeSinceLastUpdate = -1 * [date timeIntervalSinceDate:todayBegin];
    
    NSInteger timeToDisplay = (NSInteger) (timeSinceLastUpdate / aDay);
    if(timeSinceLastUpdate < 0)
    {
        return [NSString stringWithFormat:@"今天 %@",rv];
    }
    if(timeToDisplay == 0)
    {
        return [NSString stringWithFormat:@"昨天 %@",rv];
    }
    if(timeToDisplay == 1)
    {
        return [NSString stringWithFormat:@"前天 %@",rv];
    }
    
    if(timeSinceLastUpdate < aYear)
    {
        return [NSString stringWithFormat:@"%2ld月%2ld日 %@",(long)dateComponent.month, (long)dateComponent.day,rv];
    }
    else {
        return [NSString stringWithFormat:@"%2ld年%2ld月%2ld日 %@",
                (long)dateComponent.year,(long)dateComponent.month, (long)dateComponent.day,rv];
    }
}

+ (NSDate *) getDateFromString:(NSString *)str format:(NSString *)format
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    inputFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    [inputFormatter setDateFormat:format];
    NSDate* inputDate = [inputFormatter dateFromString:str];
    return inputDate;
}

+ (NSInteger) getIntValueFromObj:(NSObject *)data
{
    NSInteger ret = 0;
    if (data && [data isKindOfClass:[NSString class]]) {
        ret = [(NSString *)data intValue];
    } else if (data && [data isKindOfClass:[NSNumber class]]) {
        ret = [(NSNumber *)data intValue];
    }
    return ret;
}


+ (double) getDoubleValueFromObj:(NSDictionary *)dict key:(NSObject *)key def:(double)def
{
    double ret = def;
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSNumber *value = [dict objectForKey:key];
        if (value && ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])) {
            ret = [value doubleValue];
        }
    }
    return ret;
}

+ (NSString *) getStrFromObj:(NSDictionary *)dict key:(NSObject *)key def:(NSString *)def
{
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        id value = [dict objectForKey:key];
        if (value && [value isKindOfClass:[NSString class]]) {
            NSString *ret = (NSString *)value;
            return ret;
        }
    }
    return def;
}

+ (void) setCircleBorder:(UIView *)v borderWidth:(NSInteger) width
{
    CGRect frame = v.frame;
    //set circle border
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    // Give the layer the same bounds as your image view
    [circleLayer setBounds:CGRectMake(0.0f, 0.0f, frame.size.width,
                                      frame.size.height)];
    // Position the circle anywhere you like, but this will center it
    // In the parent layer, which will be your image view's root layer
    [circleLayer setPosition:CGPointMake(40, 40)];
    // Create a circle path.
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    //        CGMutablePathRef patdh =  CGPathCreateMutable();
    //        CGPathAddEllipseInRect(patdh, nil, CGRectMake(0.0f, 0.0f, 70.0f, 70.0f));
    // Set the path on the layer
    [circleLayer setPath:[path CGPath]];
    
    // Add the sublayer to the image view's layer tree
    //[[imgView layer] addSublayer:circleLayer];
    [[v layer] setMask:circleLayer];
    
    CAShapeLayer *borderCircleLayer = [CAShapeLayer layer];
    borderCircleLayer.bounds = circleLayer.bounds;
    borderCircleLayer.position = circleLayer.position;
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    [borderCircleLayer setPath:[borderPath CGPath]];
    [borderCircleLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
    [borderCircleLayer setFillColor:[[UIColor clearColor] CGColor]];
    [borderCircleLayer setLineWidth:0];
    [[v layer] addSublayer:borderCircleLayer];
}

+(NSInteger) getStringCount:(NSString*)string
{
    NSInteger length = [string length];
    int currentStringSize=0;
    for (int i=0; i<length; i++) {
        NSString *subString  = [string substringWithRange:NSMakeRange( i, 1)] ;
        NSData *_temp = [subString dataUsingEncoding:NSUTF8StringEncoding];
        currentStringSize += [_temp length];
    }
    return currentStringSize;
}

+ (NSString *) formatDistance:(double)distance
{
    if (distance < 0) {
        return [NSString stringWithFormat:@"未知位置"];
    } else if (distance < 1000) {
        return [NSString stringWithFormat:@"%0.0fm",distance];
    } else if (distance > 100000) {
        return [NSString stringWithFormat:@"%0.0fkm",distance/1000];
    } else {
        return [NSString stringWithFormat:@"%0.2fkm",distance/1000];
    }
}

+ (NSArray *) getInsertPaths:(NSInteger)oldCnt addCount:(NSInteger)count
{
    if (count < 1) {
        return nil;
    }
    NSMutableArray *pathList = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i< count; i ++) {
        [pathList addObject:[NSIndexPath indexPathForRow:i+oldCnt-count inSection:0]];
    }
    return pathList;
}
+ (CATransition*)AnimationLayer:(NSString *)type
{
    return [[self class] AnimationLayer:type subType:kCATransitionFromLeft];
}
+ (CATransition*)AnimationLayer:(NSString *)type subType:(NSString *)subType
{
    CATransition *transition = [CATransition animation]; //定义过度动画
    transition.duration = 1; //持续时间
    transition.type = type;   //动画样式
    transition.subtype = subType;  //方向
    
    return transition;
}
+ (void)setCircleRadius:(UIView *)view borderColor:(UIColor *)color
{
    CALayer *lay = [view layer];
    lay.cornerRadius = view.frame.size.width/2.0;
    lay.masksToBounds = YES;
    if (color) {
        lay.borderWidth = 1.5;
        lay.borderColor = color.CGColor;
    }
}
+ (void)setButtonRadius:(UIView *)view borderColor:(UIColor *)color
{
    CALayer *lay = [view layer];
    lay.cornerRadius = 3;
    lay.masksToBounds = YES;
    if (color) {
        lay.borderWidth = 1.0;
        lay.borderColor = color.CGColor;
    }
}

+ (void)setViewRadius:(UIView *)view borderColor:(UIColor *)color CornerRadius:(CGFloat)cornerRadius
{
    CALayer *lay = [view layer];
    lay.cornerRadius = cornerRadius;
    lay.masksToBounds = YES;
    if (color) {
        lay.borderWidth = 1.0;
        lay.borderColor = color.CGColor;
    }
}

+ (void)removeAllSubView:(UIView*) view {
    for (UIView* subview in view.subviews) {
        if ([subview.subviews count]) {
            [self removeAllSubView:subview];
        }
        [subview removeFromSuperview];
    }
}

+ (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    BOOL ret = NO;
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        ret = YES;
    }
    
    return ret;
    
//    NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
//    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
//    return [phoneTest evaluateWithObject:mobileNum];
}

+ (NSInteger) getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *dateComponent = [calendar components:NSYearCalendarUnit fromDate:now];
    return [dateComponent year];
}


+(void) setFirstLaunch:(NSString *)buildID
{
    if (!buildID) {
        return;
    }
    [AppShareContext sharedAppShareContext].buildIdStr = [NSString stringWithFormat:@"%@",buildID];
    
    NSUserDefaults *local = [NSUserDefaults standardUserDefaults];
    if (![buildID isEqualToString:[local stringForKey:@"everLaunched"]]) {
        [local setObject:[NSString stringWithFormat:@"%@",buildID] forKey:@"everLaunched"];
        [local setBool:YES forKey:@"firstLaunch"];
        [local setObject:[NSArray array] forKey:USERDEF_HELPSHOWED];
    }
    else {
        [local setBool:NO forKey:@"firstLaunch"];
    }
    [local synchronize];
}
/**
 * 是否第一次启动
 */
+(BOOL) isFirstLaunch
{
    NSUserDefaults *local = [NSUserDefaults standardUserDefaults];
    return [local boolForKey:@"firstLaunch"];
}
+(BOOL) isFirstLaunch:(NSString *)imageStr
{
    NSUserDefaults *local = [NSUserDefaults standardUserDefaults];
    NSArray *helpShowedList = [local objectForKey:USERDEF_HELPSHOWED];
    BOOL ret = YES;
    for (NSString *str in helpShowedList) {
        if ([str isEqualToString:imageStr]) {
            ret = NO;
            break;
        }
    }
    if (ret) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:helpShowedList];
        [arr addObject:imageStr];
        [local setObject:arr forKey:USERDEF_HELPSHOWED];
        [local synchronize];
    }
    return ret;
}
+ (NSString *) formatBirthday:(double)bir
{
    if (bir == 0) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:bir];
    NSString *confromTimespStr = [formatter stringFromDate:date];
    
    return confromTimespStr;
}
+ (NSString *)getChatBgFromLocal
{
    AppShareContext *app = [AppShareContext sharedAppShareContext];
    if (app.chatBgPath) {
        return app.chatBgPath;
    }
    NSUserDefaults *local = [NSUserDefaults standardUserDefaults];
    app.chatBgPath = [local objectForKey:LOCAL_CHATBG_PATH];
    return app.chatBgPath;
}

+ (NSString*)deviceName:(NSString *)deviceString
{
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5(GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C(GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C(GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S(GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S(GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"4th Generation iPad";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

+ (NSArray *) splitEx:(NSString *)inputStr regStr:(NSString *)regStr
{
    NSRange searchRange = ((NSRange){.location=0UL, .length=NSUIntegerMax});
    NSMutableArray *retArr = [NSMutableArray arrayWithCapacity:20];
    NSArray *list = [inputStr componentsMatchedByRegex:regStr options:RKLCaseless range:searchRange capture:0UL error:NULL];
    NSRange matchRange;
    NSRange preMatchRange = NSMakeRange(0, 0);
    NSRange range = NSMakeRange(0, 0);
    for (int i = 0; i < list.count; i++) {
        NSString *matchStr = [list objectAtIndex:i];
        
        searchRange.location = range.location;
        searchRange.length = inputStr.length - range.location;
        matchRange = [inputStr rangeOfRegex:matchStr inRange:searchRange];
        
        if (preMatchRange.length < 1) { //first match.
            range.length = matchRange.location;
        } else {
            range.length = matchRange.location - (preMatchRange.location + preMatchRange.length);
        }
        [retArr addObject:[inputStr substringWithRange:range]];
        
        NSString *imgStr = REG_SYMBOL;
        imgStr = [imgStr stringByAppendingString:matchStr];
        [retArr addObject:imgStr];
        
        range.location = matchRange.location+matchStr.length;
        preMatchRange = matchRange;
    }
    if (range.location < inputStr.length) {
        [retArr addObject:[inputStr substringFromIndex:range.location]];
    }
    return retArr;
}
+ (NSString *) replaceImageFrom:(NSString *)html srcList:(NSMutableArray *)arr rowIndx:(NSInteger)row
{
    NSString *retStr = @"";
    if (!html || html.length < 1) {
        return retStr;
    }
    NSString *htmlStr = html;
    NSArray *list = [self.class splitEx:htmlStr regStr:@"@img@([^@])*@img@"];
    if(list.count < 1)
    {
        return htmlStr;
    }
    for (NSString *str in list) {
        if (![str hasPrefix:REG_SYMBOL]) {
            retStr = [retStr stringByAppendingString:str];
            continue;
        }
        //<img>
        NSString *src = [str substringFromIndex:1];
        src = [src stringByReplacingOccurrencesOfString:@"@img@" withString:@""];
        src = [Utility addHttpUrl:src];
        //get from down cache.
        NSString *path = [[LocalCache af_sharedImageCache] getDownImageFilePath:[NSURL URLWithString:src]];
        if (!path) {
            //try cache dir
            path = [[LocalCache af_sharedImageCache] getImageFilePath:[NSURL URLWithString:src]];
        }
        if (path) {
            retStr = [retStr stringByAppendingFormat:@" <_image>%@</_image> ",path];
            continue;
        }
        //bbs.shangx.... .png
        if (arr && src) {
            NSDictionary *d = @{
                                @"bsrc": src,
                                @"md5":[src MD5Sum],
                                @"row":@(row)
                                };
            [arr addObject:d];
        }
        retStr = [retStr stringByAppendingString:@" <_image>ic_gonghui.png</_image> "];
    }
    return retStr;
}

+ (NSString *) addHttpUrl:(NSString *)url
{
    if (![url hasPrefix:@"http"] && url) {
        return [@"http://" stringByAppendingString:url];
    }
    return url;
}
+ (NSString *) rmHttpUrl:(NSString *)url
{
    return [url stringByReplacingOccurrencesOfString:@"http://" withString:@""];
}
+(NSString *)trimStr:(NSString *)str
{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [str stringByTrimmingCharactersInSet:whitespace];
}
+(NSString *)fomatColorFromHex:(NSInteger)hex
{
    NSString *ret = [NSString stringWithFormat:@"#%06lx",(long)hex];
    DLog(@"hex:%@",ret);
    return ret;
}


+ (void)setNavigationBarItemWithController:(UIViewController *) conroller
                                 withTitle:(NSString *) title
                                    action:(SEL)action
                                      left:(BOOL)left {
    UIBarButtonItem *bItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:conroller action:action];
    if (left) {
        conroller.navigationItem.leftBarButtonItem = bItem;
    }
    else {
        conroller.navigationItem.rightBarButtonItem = bItem;
    }
}
//显示圆形头像
+(void)setViewRaduis:(UIView *)view{
    //设置头像圆形
    [view.layer setCornerRadius:CGRectGetHeight([view bounds]) / 2];
    view.layer.masksToBounds = YES;
    //然后再给图层添加一个有色的边框，类似qq空间头像那样
    //    self.ImgView.layer.borderWidth = 5;
    //    self.ImgView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
}



//获取lab高度
+ (CGFloat)heightForCellWithText:(NSString *)contentText fontSize:(CGFloat)labelFont labelWidth:(CGFloat)labelWidth
{
    CGFloat titleHeight;
    if ([contentText isEqualToString:@""]) {
        return 0.0f;
    }
    if ([contentText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:contentText
                                                                             attributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:labelFont]}];
        CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(labelWidth, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        titleHeight = ceilf(rect.size.height);
    }
    else
    {
        titleHeight = [contentText sizeWithFont:[UIFont systemFontOfSize:labelFont]
                              constrainedToSize:CGSizeMake(labelWidth, CGFLOAT_MAX)
                                  lineBreakMode:NSLineBreakByWordWrapping].height;
    }
    
    return titleHeight;
}

+(UITableViewCell *)getTableviewCell:(id)sender{
    
    UITableViewCell * cell = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
        cell = (UITableViewCell *)[[[sender superview] superview] superview];
    }else{
        cell = (UITableViewCell *)[[sender superview] superview];
    }
    return cell;
}

+(UIView *)getViewFromTableview:(id)object{
    UIView * view = nil;
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0) {
//        view = (UIView *)[[object superview] superview];
//    }else{
//        view = (UIView *)[object superview];
//    }
    view = (UIView *)[object superview];
    return view;
}


//根据vip等级返回图片
+(UIImage *)gradeGetImg:(long int)vip{
    UIImage *img;
    switch (vip) {
        case 0:
            img=[UIImage imageNamed:@"yonghudengji0"];
            break;
        case 1:
            img=[UIImage imageNamed:@"v1"];
            break;
        case 2:
            img=[UIImage imageNamed:@"v2"];
            break;
        case 3:
            img=[UIImage imageNamed:@"v3"];
            break;
        case 4:
            img=[UIImage imageNamed:@"v4"];
            break;
        case 5:
            img=[UIImage imageNamed:@"v5"];
            break;
        default:
            break;
    }
    
    return img;
}
+(void)setImageView:(UIImageView *)imageView andUrl:(NSString *)url{
    [imageView sd_setImageWithURL:[url getURLInstance] placeholderImage:DEF_MOREN_IMG];
}

+ (NSString *)toJson:(NSObject *)obj
{
    NSError *error;
    NSData *dat = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    if (dat && !error) {
        NSString *ret = [[NSString alloc] initWithData:dat encoding:NSUTF8StringEncoding];
        ret = [ret stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        return ret;
    } else {
        return nil;
    }
}
+(UIImage*)getSubImage:(UIImage *)image mCGRect:(CGRect)mCGRect centerBool:(BOOL)centerBool
{
    
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    
    
    float imgwidth = image.size.width;
    float imgheight = image.size.height;
    float viewwidth = mCGRect.size.width;
    float viewheight = mCGRect.size.height;
    CGRect rect = mCGRect;
    if(centerBool)
        rect = CGRectMake((imgwidth-viewwidth)/2, (imgheight-viewheight)/2, viewwidth, viewheight);
    else{
        if (viewheight < viewwidth) {
            if (imgwidth <= imgheight) {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }else {
                float width = viewwidth*imgheight/viewheight;
                float x = (imgwidth - width)/2 ;
                if (x > 0) {
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
                }
            }
        }else {
            if (imgwidth <= imgheight) {
                float height = viewheight*imgwidth/viewwidth;
                if (height < imgheight) {
                    rect = CGRectMake(0, 64, imgwidth, height);
                }else {
                    rect = CGRectMake(0, 64, viewwidth*imgheight/viewheight, imgheight);
                }
            }else {
                float width = viewwidth*imgheight/viewheight;
                if (width < imgwidth) {
                    float x = (imgwidth - width)/2 ;
                    rect = CGRectMake(x, 0, width, imgheight);
                }else {
                    rect = CGRectMake(0, 0, imgwidth, imgheight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 64, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+ (BOOL) isValidCreditNumber:(NSString*)cardNum{
    if ([cardNum isEqualToString:@""]) {
        return NO;
    }
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNum length];
    int lastNum = [[cardNum substringFromIndex:cardNoLength-1] intValue];
    
    cardNum = [cardNum substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNum substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal >= 10)
                    tmpVal -= 9;
                    evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal >= 10)
                    tmpVal -= 9;
                    evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else{
        return NO;
    }

}

#pragma mark - 身份证识别
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray *codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary *checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    NSScanner *scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    for (int i =0; i<17; i++) {
        sumValue += [[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    NSString *strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    
    return  NO;
}

+ (NSString *)getSecretMobile:(NSString *)mobile
{
    NSString *str = mobile;
    //字符串的截取
    NSString *string = [mobile substringWithRange:NSMakeRange(3,4)];
    //字符串的替换
    str = [str stringByReplacingOccurrencesOfString:string withString:@"****"];
    return str;
}

+ (NSString *)timeFormatted:(double)totalSeconds
{
    if (totalSeconds == 0) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd  HH:mm"];
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:totalSeconds];
    NSString *confromTimespStr = [formatter stringFromDate:date];
    
    return confromTimespStr;
    
}

+ (NSString *)timeFormattedHour:(double)totalSeconds
{
    if (totalSeconds == 0) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:totalSeconds];
    NSString *confromTimespStr = [formatter stringFromDate:date];
    
    return confromTimespStr;
    
}

+ (NSString *)timeFormattedForMonthAndDay:(double)totalSeconds
{
    if (totalSeconds == 0) {
        return nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日  HH:mm"];
    NSDate  *date = [NSDate dateWithTimeIntervalSince1970:totalSeconds];
    NSString *confromTimespStr = [formatter stringFromDate:date];
    
    return confromTimespStr;
    
}

//获取字符串后四位
+ (NSString *)getLastFourString:(NSString *)string{
    if (string.length < 4) {
        return @"";
    }
    NSInteger index = string.length;
    NSString *newString = [string substringFromIndex:(index-4)];
    return newString;
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (BOOL)isChinese:(NSString *)string
{
    BOOL ret = NO;
    for (int i = 0; i < string.length; i ++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [string substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            ret = YES;
        }else if (strlen(cString) == 1){
            ret = NO;
        }
    }
    
    return ret;
    
}

+ (BOOL)isEnglish:(NSString *)string
{
    BOOL ret = NO;
    NSString *regex = @"^[A-Za-z]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    string = [string stringByReplacingOccurrencesOfString:@" "withString:@""];
    if ([pred evaluateWithObject:string]){
        ret = YES;
    }
    
    return ret;
    
}

+(CGFloat)headerViewHeightWithTitle:(NSString *)title andDesc:(NSString *)desc andNormalHeight:(CGFloat)retHeight;
{
    CGSize titleMaxSize = CGSizeMake(ScreenWidth-30-12, 10000.0f);
    CGSize titleDetailsLabelSize = RK_MULTILINE_TEXTSIZE(title, [UIFont systemFontOfSize:13.0f], titleMaxSize, NSLineBreakByTruncatingTail);
    
    CGSize descMaxSize = CGSizeMake(ScreenWidth-34-60-24-8, 10000.0f);
    CGSize descDetailsLabelSize = RK_MULTILINE_TEXTSIZE(desc, [UIFont systemFontOfSize:13.0f], descMaxSize, NSLineBreakByTruncatingTail);
    
    
    if ((titleDetailsLabelSize.height + descDetailsLabelSize.height +100) > 145) {
        retHeight = (titleDetailsLabelSize.height + descDetailsLabelSize.height +100);
    }
    return retHeight;
    
}

+(NSAttributedString *)getHtmlString:(NSString *)str{
    NSString *htmlString = str;
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                                   options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                                        documentAttributes:nil
                                                                     error:nil];
    return attrStr;
}
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
//返回手机格式
+ (NSString *)returnMobile:(NSString *)string
{
    if (!string.length) {
        return @"";
    }
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    NSMutableString *temString = [NSMutableString stringWithString:string];
    [temString insertString:@" "atIndex:0];
    string = temString;
    
    NSString *newString =@"";
    while (string.length > 0){
        NSString *subString = [string substringToIndex:MIN(string.length,4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length ==4){
            newString = [newString stringByAppendingString:@" "];
        }
        string = [string substringFromIndex:MIN(string.length,4)];
    }
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    return newString;
    
}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (NSString *) html2String:(NSString *)input take:(NSInteger)take
{
    NSString *rv = input;
    NSRange rng = [rv rangeOfString:@"<body>"];
    if (rng.length > 0) {
        rv = [rv substringFromIndex:rng.location];
    }
    rv = [rv stringByReplacingOccurrencesOfRegex:@"</?[!a-z][^<]*?>" withString:@""];
    rv = [rv stringByReplacingOccurrencesOfRegex:@"&nbsp;" withString:@" "];
    rv = [rv stringByReplacingOccurrencesOfRegex:@"\n" withString:@""];
    rv = [rv stringByReplacingOccurrencesOfRegex:@"\t" withString:@""];
    if (take > 0) {
        take = MIN(take, rv.length);
        rv = [rv substringToIndex:take];
    }
    
    return rv;
}


+ (NSTimeInterval)getTimeNowWithZone{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *currentDte = [date  dateByAddingTimeInterval:interval];
    NSTimeInterval send_time = [currentDte timeIntervalSince1970];
    return send_time;
}





+ (BOOL)isHTTPEnable {
    if([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending){
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        return [[[infoDict objectForKey:@"NSAppTransportSecurity"] objectForKey:@"NSAllowsArbitraryLoads"] boolValue];
    }
    return YES;
}
+ (void)alterToUpdata:(BOOL)isStrong memo:(NSString *)memo url:(NSString *)url{
    
}
+ (UIImage *)fixOrientation:(UIImage *)aImage{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}
+ (UIFont *)getFont:(NSInteger)fontSize{
    UIFont * font = [UIFont fontWithName:@"FZY4K--GBK1-0" size:fontSize];
    return font;
}

+ (void)resizableImageWithBackBtn:(UIButton *)backBtn andTitle:(NSString *)title{
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"biaotou"];
    // 加载图片
    UIImage *image_HL = [UIImage imageNamed:@"biaotou_xuanzhong"];
    NSString * btnTitle = @"        ";
    btnTitle = [btnTitle stringByAppendingString:title];
    btnTitle = [btnTitle stringByAppendingString:@" "];
    
    [backBtn setTitle:btnTitle forState:(UIControlStateNormal)];
    // 设置按钮的背景图片
    [backBtn setBackgroundImage:[Utility resizableImageWithImage:image] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[Utility resizableImageWithImage:image_HL] forState:UIControlStateHighlighted];
}
+ (UIImage *)resizableImageWithImage:(UIImage *)image{
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    return newImage;
}

@end
