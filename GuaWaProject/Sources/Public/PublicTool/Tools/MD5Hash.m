//
//  MD5Hash.m
//  luguome_narc
//
//  Created by tulip on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MD5Hash.h"

@implementation MD5Hash
+ (NSString*) md5:(NSString *)str
{
    const char * cStr =[str UTF8String];
//    unsigned char result[32];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
/*    32byte
    return[NSString stringWithFormat:
           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15],
           result[16], result[17], result[18], result[19],
           result[20], result[21], result[22], result[23],
           result[24], result[25], result[26], result[27],
           result[28], result[29], result[30], result[31]
           ];
 */
    return[NSString stringWithFormat:
           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15]
           ];
}

+ (NSString *) multiMD5:(NSString *)str offset:(NSUInteger )offSet
{
    //return [str stringByAppendingString:@"xxxx"];
    //not competed yet
    //NSLog(@"str:%@, offset:%d",str,offSet);
    NSString * str_md5 = [self md5:str];
    NSString * sub_md5 = [str_md5 substringFromIndex:(offSet > 30 ? 30 : offSet)];
    //NSLog(@"md5:%@,subMd5:%@,append:%@",str_md5,sub_md5,[str_md5 stringByAppendingString:sub_md5]);
    return [self md5:[str_md5 stringByAppendingString:sub_md5]];
}

@end
