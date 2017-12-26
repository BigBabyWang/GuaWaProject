//
//  MyLocationManager.m
//  MatchLive
//
//  Created by xmrk on 16/4/26.
//  Copyright © 2016年 mjBear. All rights reserved.
//

#import "MyLocationManager.h"

@interface MyLocationManager ()

@property (strong,nonatomic) CLGeocoder *geocoder;

@end


static MyLocationManager *instance = nil;

@implementation MyLocationManager

+(MyLocationManager *)sharedInstance
{
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        instance = [[MyLocationManager alloc]init];
    });
    
    return instance;
}

/**
 *  开启定位
 *
 *  @param locateSuccess     定位成功的代码块
 *  @param locateFailed      定位失败的代码块
 *  @param locateUnAvailable 无法定位的代码块
 */
-(void)startLocateWithSuccessBlock:(locateSuccessBlock)locateSuccess andLocateFailedBlock:(locateFailedBlock)locateFailed andLocateUnAvailableBlock:(loacteUnAvailableBlock)locateUnAvailable{
    
    [self.locationManager startUpdatingLocation];
    
    if (locateSuccess) {
        
        self.locateSuccess = locateSuccess;
    }
    
    if (locateFailed) {
        
        self.locateFailed = locateFailed;
    }
    
    if (locateUnAvailable) {
        
        self.locateUnAvailable = locateUnAvailable;
    }
    
    
    
}


//逆编码（由经、纬度，获得具体位置信息）
-(void)getAddressByCoordinate:(CLLocationCoordinate2D) coordinate{
    
    CLLocation *location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    MLocationInfo *locationInfo = [MLocationInfo new];
    //逆编码
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placemark=placemarks[0];
        
        locationInfo.state = placemark.addressDictionary[@"State"];
        locationInfo.city = placemark.addressDictionary[@"City"];
        locationInfo.subLocality = placemark.addressDictionary[@"SubLocality"];
        locationInfo.street = placemark.addressDictionary[@"Street"];
        locationInfo.address = placemark.addressDictionary[@"FormattedAddressLines"][0];
        
        locationInfo.coordinate = coordinate;
        
        if (self.locateSuccess) {
            
            //调用定位成功代码块
            self.locateSuccess(locationInfo);
        }
        
    }];
    
    
}



#pragma mark -- 实现CLLocationManagerDelegate协议内的方法

/**
 *  当定位的权限发生变化时执行该方法
 *
 *  @param manager <#manager description#>
 *  @param status  <#status description#>
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:       //用户未选择过权限
        {
            // 询问用户是否授权使用定位服务
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                //申请使用时获得定位权限
                [_locationManager requestWhenInUseAuthorization];
            }
            
        }
            break;
            
            
            
        case kCLAuthorizationStatusRestricted:          // 无法使用定位服务，该状态用户无法改变
        case kCLAuthorizationStatusDenied:              // 用户拒绝该应用使用定位服务，或是定位服务总开关处于关闭状态
        {
            
            //没有权限，不能完成定位，此处应该调用locateUnAvailable代码块
            
            if (self.locateUnAvailable) {//判断代码块是否有被赋值
                
                self.locateUnAvailable();
                
            }
            
            
        }
            break;
            
            
            /*----------------------下面判断是否需要？？？----------------------------*/
            
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0// 当前系统版本为：iOS 7.0，编译支持的最高版本（<8.0）
        case kCLAuthorizationStatusAuthorized:
        {
            
            //有权限，此处不做操作
            
        }
            break;
            
            
#elif __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0// 当前系统版本为：iOS 8.0及以上，编译支持的最高版本（>=8.0）
        case kCLAuthorizationStatusAuthorizedAlways:    // 用户允许该程序无论何时都可以使用地理信息
        case kCLAuthorizationStatusAuthorizedWhenInUse: // 用户同意程序在可见时使用地理位置
        {
            
            //有权限，此处不做操作
            
        }
            break;
#endif
            
            
        default:
            break;
    }
    
    
}

/**
 *  当位置发生改变时执行（第一次成功定位时也会执行）
 *
 *  @param manager   <#manager description#>
 *  @param locations <#locations description#>
 */
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = locations[0];//获取最新的位置
    
    [self getAddressByCoordinate:location.coordinate];//逆编码获得具体位置信息
    
    [self.locationManager stopUpdatingLocation];
    
    
}

/**
 *  当定位失败时执行
 *
 *  @param manager <#manager description#>
 *  @param error   <#error description#>
 */
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    
    
    //此处应该调用locateFailed代码块
    if (self.locateFailed) {
        
        self.locateFailed();
    }
    
}





#pragma mark -- 懒加载

/**
 *  返回CLLocationManager实例
 *
 *  @return <#return value description#>
 */
-(CLLocationManager*)locationManager{
    
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;//指定当前对象为代理者
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;//使用最好的精度
        
        CLLocationDistance distance=10.0;//10米定位一次
        _locationManager.distanceFilter=distance;
        
        
    }
    
    return _locationManager;
}

/**
 *  返回CLGeocoder实例
 *
 *  @return <#return value description#>
 */
-(CLGeocoder *)geocoder{
    
    if (_geocoder == nil) {
        
        _geocoder = [[CLGeocoder alloc]init];
        
    }
    
    return _geocoder;
}


@end
