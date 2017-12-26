//
//  MD5Hash.h
//  luguome_narc
//
//  Created by tulip on 12-6-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#define MULTIMD5_OFFSET 20

@interface MD5Hash : NSObject {
    
}
//return 32 byte md5
+ (NSString *) md5:(NSString*)str;

//md5(md5(password) & Right(md5(password),8))
+ (NSString *) multiMD5:(NSString *)str offset:(NSUInteger) offSet;

@end
