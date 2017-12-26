//
//  PublicEngine.h
//  JYApp
//
//  Created by co5der on 14-3-7.
//  Copyright (c) 2014年 co5der. All rights reserved.
//

#import "MKNetworkEngine.h"
@interface PublicEngine : MKNetworkEngine
-(id) initWithDefaultSettings;
/**
 * 需要initHostName
 */

/**
 *根据用户id，获取用户头像
 */
-(MKNetworkOperation*) getHeaderPhotoByUID:(NSString*) uID
                         completionHandler:(MKNKImageBlock)completion
                              errorHandler:(MKNKErrorBlock) errorBlock;

-(MKNetworkOperation*) downFile:(NSString*) url
              completionHandler:(MKNKResponseBlock)completion
                   errorHandler:(MKNKErrorBlock) errorBlock;

@end
