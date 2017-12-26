//
//  UIApplication+Info.h
//  category
//
//  Created by liufashi on 16/5/26.
//  Copyright © 2016年 liufashi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Info)

///获取caches文件夹的url
- (NSURL *)lzs_cachesDirectoryURL;

///获取caches文件夹的路径
- (NSString *)lzs_cachesDirectoryPath;

///获取documents文件夹的url
- (NSURL *)lzs_documentsDirectoryURL;

///获取documents文件夹的路径
- (NSString *)lzs_documentsDirectoryPath;

///获取library文件夹的url
- (NSURL *)lzs_libraryDirectoryURL;

///获取library文件夹的路径
- (NSString *)lzs_libraryDirectoryPath;



@end
