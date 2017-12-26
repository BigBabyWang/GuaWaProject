//
//  LocalCache.h
//  youyou
//
//  Created by co5der on 13-5-21.
//  Copyright (c) 2013年 co5der. All rights reserved.
//

#import <Foundation/Foundation.h>
#define _USE_LOCAL_CACHE
//#define _DEBUG_INFO
@interface LocalCache : NSCache
- (UIImage *)cachedImageForRequest:(NSURLRequest *)request;
- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request;
- (NSString *) getImageFilePath:(NSURL *)url; //if not exist return nil
- (BOOL) delCacheImageByPath:(NSURL *)url;

- (NSString *)saveDownImage:(UIImage *)image
        forRequest:(NSURLRequest *)request;
- (NSString *) getDownImageFilePath:(NSURL *)url; //if not exist return nil
- (BOOL) delDownImageFileByPath:(NSURL *)url;

+ (BOOL) cleanDiskCache;
+ (void) cleanCache;
+ (void) cleanRamCache;

+ (NSString *) cacheSizeCalulate;

+ (LocalCache *)af_sharedImageCache;
@end
