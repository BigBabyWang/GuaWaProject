//
//  MUser.m
//  PhoneGame
//
//  Created by co5der on 14-3-4.
//  Copyright (c) 2014年 co5der. All rights reserved.
//

#import "MUser.h"
#import <LKDBHelper.h>

@implementation MUser
+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale systemLocale];
    //dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    //2013-06-20T05:12:04.045Z
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    return dateFormatter;
}

+ (NSDictionary *) modelCustomPropertyMapper {
    return @{
             @"uid":@"id",
             @"accessToken":@"token"
             };
}
- (void)setNilValueForKey:(NSString *)key {
    [self setValue:@0 forKey:key]; // For NSInteger/CGFloat/BOOL
}

//+ (NSValueTransformer *) sexJSONTransformer {
//    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
//                                                                           @"0" : @(MUserSexUnknown),
//                                                                           @"1" : @(MUserSexBoy),
//                                                                           @"2" : @(MUserSexGirl)
//                                                                           }];
//}
//+ (NSValueTransformer *) userqdJSONTransformer {
//    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:@{
//                                                                           @"yes" : @(YES),
//                                                                           @"not" : @(NO)
//                                                                           }];
//}





@end
