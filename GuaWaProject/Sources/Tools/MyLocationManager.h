//
//  MyLocationManager.h
//  MatchLive
//
//  Created by xmrk on 16/4/26.
//  Copyright © 2016年 mjBear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MLocationInfo.h"

typedef void(^locateSuccessBlock)(MLocationInfo *);
typedef void(^locateFailedBlock)();
typedef void(^loacteUnAvailableBlock)();

@interface MyLocationManager : NSObject
<
  CLLocationManagerDelegate
>

@property (strong,nonatomic) locateSuccessBlock locateSuccess;
@property (strong,nonatomic) locateFailedBlock locateFailed;
@property (strong,nonatomic) loacteUnAvailableBlock locateUnAvailable;

@property (strong,nonatomic) CLLocationManager *locationManager;

//单例
+(MyLocationManager *)sharedInstance;

/**
 *  开启定位
 *
 *  @param locateSuccess     定位成功的代码块
 *  @param locateFailed      定位失败的代码块
 *  @param locateUnAvailable 无法定位的代码块
 */
-(void)startLocateWithSuccessBlock:(locateSuccessBlock)locateSuccess andLocateFailedBlock:(locateFailedBlock)locateFailed andLocateUnAvailableBlock:(loacteUnAvailableBlock)locateUnAvailable;

@end
