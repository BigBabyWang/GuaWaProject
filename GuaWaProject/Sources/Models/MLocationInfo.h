//
//  MLocationInfo.h
//  MatchLive
//
//  Created by xmrk on 16/4/26.
//  Copyright © 2016年 mjBear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class MLocationInfo;
typedef void (^MLocationInfoGeocoder)(MLocationInfo * locationInfo);

@interface MLocationInfo : NSObject

@property (copy,nonatomic) NSString *state;
@property (copy,nonatomic) NSString *city;
@property (copy,nonatomic) NSString *subLocality;
@property (copy,nonatomic) NSString *street;
@property (copy,nonatomic) NSString *address;
@property (assign,nonatomic) CLLocationCoordinate2D coordinate;



@property(nonatomic,assign)CGFloat latitude;
@property(nonatomic,assign)CGFloat longitude;
@property (copy,nonatomic) NSString *Country;
@property (copy,nonatomic) NSString *FormattedAddressLines;
@property (copy,nonatomic) NSString *Name;

-(id)initWithLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude;
-(void)reLocation:(MLocationInfoGeocoder)locationGeocoder;


@end
