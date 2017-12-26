//
//  NSString+URLTool.m
//  XXVoice
//
//  Created by tulip on 14-8-29.
//  Copyright (c) 2014年 dmfive. All rights reserved.
//

#import "NSString+URLTool.h"

@implementation NSString (URLTool)
- (NSURL *)getURLInstance
{
    if ([Utility isString:self lengthLonger:0]) {
        if (![self hasPrefix:@"http://"]) {
            NSString *path = [NSString stringWithFormat:@"http://%@/%@",API_HOST,self];
            return [NSURL URLWithString:path];
        }
        return [NSURL URLWithString:self];
    }
    return nil;
}
@end
