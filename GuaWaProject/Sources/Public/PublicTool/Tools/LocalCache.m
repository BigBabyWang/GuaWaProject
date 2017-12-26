//
//  LocalCache.m
//  youyou
//
//  Created by co5der on 13-5-21.
//  Copyright (c) 2013年 co5der. All rights reserved.
//

#import "LocalCache.h"

@interface LocalCache()
+ (NSString *)localCacheDirectory;
+ (NSString *)getImagePath:(NSURLRequest *)request;
@end
@implementation LocalCache

#pragma mark -

static inline NSString * AFImageCacheKeyFromURLRequest(NSURLRequest *request) {
    return [[request URL] absoluteString];
}

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request {
    switch ([request cachePolicy]) {
        case NSURLRequestReloadIgnoringCacheData:
        case NSURLRequestReloadIgnoringLocalAndRemoteCacheData:
            return nil;
        default:
            break;
    }
    UIImage *img = [self objectForKey:AFImageCacheKeyFromURLRequest(request)];
    if (img) {
#ifdef _DEBUG_INFO
        NSLog(@"load image from ram. ");
#endif
        return img;
    }
#ifdef _USE_LOCAL_CACHE
    NSString *imgCachePath = [[[self class] localCacheDirectory] stringByAppendingPathComponent:[[self class] getImagePath:request]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imgCachePath]) {
        if ([imgCachePath hasSuffix:@".dmf"]) {
            img = (UIImage *)[NSData dataWithContentsOfFile:imgCachePath];
        } else {
            img = [UIImage imageWithContentsOfFile:imgCachePath];
        }
        [self setObject:img forKey:AFImageCacheKeyFromURLRequest(request)];
#ifdef _DEBUG_INFO
        NSLog(@"add to ram: [%d:%d] ",self.totalCostLimit,self.countLimit);
        NSLog(@"load image from disk. imgCachePath:%@", imgCachePath);

#endif
        return img;
    }
#endif
    return nil;
}

- (NSString *) getImageFilePath:(NSURL *)url
{
    NSString *imgCachePath = [[[self class] localCacheDirectory] stringByAppendingPathComponent:[[self class] getImagePath:[NSURLRequest requestWithURL:url]]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imgCachePath]) {
        return imgCachePath;
    }
    return nil;
}

- (NSString *) getDImageFilePath:(NSURL *)url
{
    NSString *imgCachePath = [[[self class] localDownImageDirectory] stringByAppendingPathComponent:[[self class] getImagePath:[NSURLRequest requestWithURL:url]]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imgCachePath]) {
        return imgCachePath;
    }
    return nil;
}

- (BOOL) delCacheImageByPath:(NSURL *)url
{
    NSString *pth = [self getImageFilePath:url];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL ret = [fileManager removeItemAtPath:pth error:&error];
    return ret;
}

- (BOOL) delDownImageFileByPath:(NSURL *)url
{
    NSString *pth = [self getDImageFilePath:url];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL ret = [fileManager removeItemAtPath:pth error:&error];
    return ret;
}
- (NSString *)saveDownImage:(UIImage *)image
           forRequest:(NSURLRequest *)request
{
    if (image && request) {
        NSString *targetPath = [[[self class] localDownImageDirectory] stringByAppendingPathComponent:[[self class] getImagePath:request]];
        NSError *error = nil;
//        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        NSData *data = UIImagePNGRepresentation(image);
        targetPath = [targetPath stringByAppendingString:@".png"];
        [data writeToFile:targetPath options:NSDataWritingFileProtectionComplete error:&error];
        DLog(@"cache image targetPath:%@ error:%@", targetPath, [error description]);
        return targetPath;
    }
    return nil;
}
- (NSString *) getDownImageFilePath:(NSURL *)url
{
    NSString *imgCachePath = [[[self class] localDownImageDirectory] stringByAppendingPathComponent:[[self class] getImagePath:[NSURLRequest requestWithURL:url]]];
    imgCachePath = [imgCachePath stringByAppendingString:@".png"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imgCachePath]) {
        return imgCachePath;
    }
    return nil;
}

- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request
{
    if (image && request) {
        [self setObject:image forKey:AFImageCacheKeyFromURLRequest(request)];
#ifdef _DEBUG_INFO
        NSLog(@"add to ram: [%d:%d] ",self.totalCostLimit,self.countLimit);
#endif
#ifdef _USE_LOCAL_CACHE
        NSString *targetPath = [[[self class] localCacheDirectory] stringByAppendingPathComponent:[[self class] getImagePath:request]];
        NSError *error = nil;
        NSData *data = nil;
        if ([targetPath hasSuffix:@".dmf"] && [image isKindOfClass:[NSData class]]) {
            data = (NSData *)image;
        } else if([image isKindOfClass:[UIImage class]]){
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        [data writeToFile:targetPath options:NSDataWritingFileProtectionComplete error:&error];
//        //if (!error) {
//            NSLog(@"cache image targetPath:%@ error:%@", targetPath, [error description]);
//        //}
#endif
    }
}

+ (void) cleanRamCache
{
    NSLog(@"%s",__func__);
    [[[self class] af_sharedImageCache] removeAllObjects];
}

+ (void) cleanCache
{
    [[[self class] af_sharedImageCache] removeAllObjects];
    //rm db.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    if (cachesPath) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        cachesPath = [cachesPath stringByAppendingPathComponent:[infoDictionary objectForKey:@"CFBundleIdentifier"]];
        [[self class] rmDirFiles:cachesPath];
    }
}

+ (BOOL) rmDirFiles:(NSString *)dir
{
    BOOL ret = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:dir error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        ret = [fileManager removeItemAtPath:[dir stringByAppendingPathComponent:filename] error:NULL];
    }
    return ret;
}

+ (NSString *) cacheSizeCalulate
{
    NSString *dir = [[self class] localCacheDirectory];
    long totalSize = [[LocalCache af_sharedImageCache] fileSizeForDir:dir];
    totalSize += [[SDImageCache sharedImageCache] getSize];
    const unsigned int Mbytes = 1024*1024 ;   //字节数，如果想获取KB就1024，MB就1024*1024
    const unsigned int Kbytes = 1024;
    
    NSString *retStr = nil;
    if (totalSize > Mbytes) {
        retStr = [NSString stringWithFormat:@"%.2fMB",(1.0 *totalSize/Mbytes)];
    } else {
        retStr = [NSString stringWithFormat:@"%.2fKB",(1.0 *totalSize/Kbytes)];
    }
    return retStr;
}

+ (BOOL) cleanDiskCache
{
    BOOL ret = NO;
    ret = [[self class] rmDirFiles:[[self class] localCacheDirectory]];
    [[self class] cleanCache];
    return ret;
}

+ (NSString *)localCacheDirectory
{
    static NSString *_localCacheDirectory = nil;
    static dispatch_once_t _oncePredicate;
    dispatch_once(&_oncePredicate, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        if (0 < [cachesPath length]) {
            _localCacheDirectory = [cachesPath stringByAppendingPathComponent:CACHE_DIR_NAME];
        }
        
        BOOL isDirectory = NO;
        BOOL pathExist = [[NSFileManager defaultManager] fileExistsAtPath:_localCacheDirectory isDirectory:&isDirectory];
        if (!pathExist) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:_localCacheDirectory withIntermediateDirectories:YES attributes:nil error:&error];
            NSLog(@"create cache directory %@", _localCacheDirectory);
        }
    });
    
    return _localCacheDirectory;
}

+ (NSString *)localDownImageDirectory
{
    static NSString *_localDownImageDirectory = nil;
    static dispatch_once_t _oncePredicate1;
    dispatch_once(&_oncePredicate1, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachesPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        if (0 < [cachesPath length]) {
            _localDownImageDirectory = [cachesPath stringByAppendingPathComponent:@"JYImageDown"];
        }
        
        BOOL isDirectory = NO;
        BOOL pathExist = [[NSFileManager defaultManager] fileExistsAtPath:_localDownImageDirectory isDirectory:&isDirectory];
        if (!pathExist) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:_localDownImageDirectory withIntermediateDirectories:YES attributes:nil error:&error];
            NSLog(@"create down directory %@", _localDownImageDirectory);
        }
    });
    
    return _localDownImageDirectory;
}

+ (NSString *)getImagePath:(NSURLRequest *)request
{
    NSString *retPath = AFImageCacheKeyFromURLRequest(request);
    retPath = [retPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    retPath = [retPath stringByReplacingOccurrencesOfString:@"://" withString:@"_"];
    retPath = [retPath stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    //DLog(@"cache path:\n  %@  --> \n  %@",AFImageCacheKeyFromURLRequest(request),
    //     retPath);
    return retPath;
}

+ (LocalCache *)af_sharedImageCache {
    static LocalCache *_af_imageCache = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _af_imageCache = [[LocalCache alloc] init];
        _af_imageCache.countLimit = 100;
        _af_imageCache.totalCostLimit = 10240;
    });
    
    return _af_imageCache;
}

- (long)fileSizeForDir:(NSString*)path
{
    long size = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic = [fileManager attributesOfItemAtPath:fullPath error:nil];
            size += fileAttributeDic.fileSize;
        }
        else
        {
            size += [self fileSizeForDir:fullPath];
        }
    }
    return size;
}
@end
