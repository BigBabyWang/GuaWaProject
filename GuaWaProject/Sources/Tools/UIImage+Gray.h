//
//  UIImage+Gray.h
//  MatchLive
//
//  Created by liufashi on 16/6/13.
//  Copyright © 2016年 mjBear. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Gray)

///灰白图片
+ (instancetype)grayImageWithImageNamed:(NSString *)imageName;
+ (instancetype)grayImageWithImage:(UIImage *)image;

- (UIImage *)convertToGrayscale;
- (void)converToGrayCompleteBlock:(void (^)(UIImage *image))completeBlock;
@end
