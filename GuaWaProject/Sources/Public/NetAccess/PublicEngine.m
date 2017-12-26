//
//  PublicEngine.m
//  JYApp
//
//  Created by co5der on 14-3-7.
//  Copyright (c) 2014年 co5der. All rights reserved.
//

#import "PublicEngine.h"
#import "AppShareContext.h"
#import "ApiHelp.h"
#import "MResult.h"
@implementation PublicEngine
-(id) initWithDefaultSettings {
    if(self = [super initWithHostName:API_HOST
                   customHeaderFields:@{
                                        @"x-client-identifier" : @"iOS"
                                        }]){
        
    }
    return self;
}
//over write cache dir.
-(NSString*) cacheDirectoryName {
    static NSString *cacheDirectoryName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        documentsDirectory = [documentsDirectory stringByAppendingPathComponent:CACHE_DIR_NAME];
        cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:MKNETWORKCACHE_DEFAULT_DIRECTORY];
    });
    return cacheDirectoryName;
}

-(MKNetworkOperation*) getHeaderPhotoByUID:(NSString*) uID
                    completionHandler:(MKNKImageBlock) completion
                         errorHandler:(MKNKErrorBlock) errorBlock
{
    //host = www.jyeoo.com, www.jyeoo.com/api/photo/
    NSString *path = [NSString stringWithFormat:@"api/photo/%@",uID];
    MKNetworkOperation *op = [self operationWithPath:path];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         if(completedOperation.responseImage) {
             completion(completedOperation.responseImage,
                        [NSURL URLWithString:completedOperation.url], NO);
         }
     } errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         errorBlock(error);
     }];
    [self enqueueOperation:op];
    return op;
}
-(MKNetworkOperation*) downFile:(NSString*) url
              completionHandler:(MKNKResponseBlock) completion
                   errorHandler:(MKNKErrorBlock) errorBlock
{
    NSRange hostRange = [url rangeOfString:API_HOST];
    if (hostRange.length > 0) {
        url = [url substringFromIndex:(hostRange.length+hostRange.location)];
    }
    MKNetworkOperation *op = [self operationWithPath:url];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         completion(completedOperation);
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         errorBlock(error);
     }];
    [self enqueueOperation:op];
    return op;
}

@end
