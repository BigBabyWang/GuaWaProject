//
//  MLocationInfo.m
//  MatchLive
//
//  Created by xmrk on 16/4/26.
//  Copyright © 2016年 mjBear. All rights reserved.
//

#import "MLocationInfo.h"

@implementation MLocationInfo
-(id)initWithLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude{
    if (self = [super init]) {
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}
-(void)reLocation:(MLocationInfoGeocoder)locationGeocoder{
    //地址赋值
    CLLocation *location = [[CLLocation alloc]initWithLatitude:self.latitude longitude:self.longitude];
    
    //逆编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placemark=placemarks[0];
        self.state = placemark.addressDictionary[@"State"];
        self.street = placemark.addressDictionary[@"Thoroughfare"];
        self.city = placemark.addressDictionary[@"City"];
        self.subLocality = placemark.addressDictionary[@"SubLocality"];
        self.Country = placemark.addressDictionary[@"Country"];
        self.FormattedAddressLines = placemark.addressDictionary[@"FormattedAddressLines"];
        self.Name = placemark.addressDictionary[@"Name"];
        locationGeocoder(self);
    }];

}

@end
