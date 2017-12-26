//
//  U-ADplus.m
//  yijiaqin
//
//  Created by 木炎 on 2017/12/13.
//  Copyright © 2017年 木炎. All rights reserved.
//
#import <AdSupport/ASIdentifierManager.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "OpenUDID.h"
#include <arpa/inet.h>
#include <ifaddrs.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "U_ADplus.h"

@implementation U_ADplus
+ (void)requestTrackWithAppkey:(NSString *)appkey
{
    if (!appkey || ![appkey length])
    {
        return;
    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGSize size_screen = rect_screen.size;
    
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    
    CGFloat width = size_screen.width*scale_screen;
    CGFloat height = size_screen.height*scale_screen;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ASIdentifierManager *asIM = [[ASIdentifierManager alloc] init];
        NSString *idfa = [asIM.advertisingIdentifier UUIDString];
        NSString *idfv = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSString *openudid = [OpenUDID value];
        NSString *mac = [self macString];
        NSString *os = @"ios";
        NSString *os_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *resolution = [NSString stringWithFormat:@"%d*%d",(int)height,(int)width];
        NSString *accessString = [self accessString];
        NSString *accessSubType = [self accessSubType];
        NSString *network_operater = [[self carrierString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        // NSString *utdid = [UTDevice utdid];
        
        size_t size;
        // Set 'oldp' parameter to NULL to get the size of the data
        // returned so we can allocate appropriate amount of space
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        // Allocate the space to store name
        char *name = malloc(size);
        // Get the platform name
        sysctlbyname("hw.machine", name, &size, NULL, 0);
        // Place name into a string
        NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        // Done with this
        free(name);
        machine=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                      (CFStringRef)machine,
                                                                                      NULL,
                                                                                      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                      kCFStringEncodingUTF8));
        mac=(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                  (CFStringRef)mac,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8));
        NSString *requestURL = [[NSString alloc] initWithFormat:@"https://ar.umeng.com/stat.htm?ak=%@&device_name=%@&idfa=%@&openudid=%@&idfv=%@&mac=%@&os=%@&os_version=%@&resolution=%@&access=%@&access_subtype=%@&carrier=%@",appkey,machine,idfa,openudid,idfv,mac,os,os_version,resolution,accessString,accessSubType,network_operater];
        
        NSError *error = nil;
        NSHTTPURLResponse *response = nil;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (responseData)
        {
            //
            // NSLog(@"ok");
        }
    });
}



+ (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

+ (NSString *)accessString {
    
    if ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"]) {
        return @"WiFi";
    }
    
    if ([[self deviceModelString] isEqualToString:@"x86_64"]) {
        return @"WiFi";
    }
    
    if ([[self deviceModelString] isEqualToString:@"i386"]) {
        return @"WiFi";
    }
    
    
    BOOL success;
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    NSMutableArray *netArray = [[NSMutableArray alloc] init];
    
    success = getifaddrs(&addrs) == 0;
    if (success)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            // the second test keeps from picking up the loopback address
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                [netArray addObject:name];
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    
    if ([netArray containsObject:@"en0"]) {
        return @"WiFi";
    } else if ([netArray count] > 0 && ![netArray containsObject:@"en0"]) {
        return @"2G/3G";
    } else {
        return @"";
    }
}

+ (NSString *)carrierString {
    NSString *bundlePath = @"/System/Library/Frameworks/CoreTelephony.framework";
    NSBundle *telephonyNetworkInfoBundle = [NSBundle bundleWithPath:bundlePath];
    
    if (telephonyNetworkInfoBundle == nil) {
        return @"";
    } else{
        CTTelephonyNetworkInfo *netInfo = [[NSClassFromString(@"CTTelephonyNetworkInfo") alloc] init];
        if (netInfo == nil) {
            return @"";
            
        }else{
            CTCarrier *carrier = [netInfo subscriberCellularProvider];
            if (carrier.carrierName) {
                return carrier.carrierName;
            }
            return @"";
        }
        
    }
}
+ (NSString *)deviceModelString {
    size_t size;
    
    // Set 'oldp' parameter to NULL to get the size of the data
    // returned so we can allocate appropriate amount of space
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    // Allocate the space to store name
    char *name = malloc(size);
    
    // Get the platform name
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    // Place name into a string
    NSString *machine = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    
    // Done with this
    free(name);
    
    return machine;
}

+ (NSString *)accessSubType
{
    NSString *accessSubType = @"";
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    if ([telephonyInfo respondsToSelector:@selector(currentRadioAccessTechnology)])
    {
        NSString *radioAccess = telephonyInfo.currentRadioAccessTechnology;
        if (![radioAccess isEqualToString:@""] && radioAccess!=nil)
        {
            if ([radioAccess hasPrefix:@"CTRadioAccessTechnology"])
            {
                accessSubType = [radioAccess substringFromIndex:23];
            }
            else
            {
                accessSubType = radioAccess;
            }
        }
    }
    return accessSubType;
}
@end
