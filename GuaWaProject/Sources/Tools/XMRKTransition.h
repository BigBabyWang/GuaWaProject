//
//  XMRKTransition.h
//  Animation
//
//  Created by xmrk3 on 16/1/13.
//  Copyright © 2016年 xmrk3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define XMRKTransitionPageCurl @"pageCurl"          ///向上翻一页
#define XMRKTransitionPageUnCurl @"pageUnCurl"        ///向下翻一页
#define XMRKTransitionRippleEffect @"rippleEffect"      ///滴水效果
#define XMRKTransitionSuckEffect @"suckEffect"        ///收缩效果，如一块布被抽走
#define XMRKTransitionCube @"cube"              ///立方体效果
#define XMRKTransitionOglFlip @"oglFlip"           ///上下翻转效果

#define XMRKTransitionfromLeft @"fromLeft"      ///过渡方向
#define XMRKTransitionfromRight @"fromRight"
#define XMRKTransitionfromBottom @"fromBottom"
#define XMRKTransitionfromTop @"fromTop"

@interface XMRKTransition : NSObject

+(void)viewTransition:(UIView *)view
     andAnimationTime:(NSTimeInterval)animationTime
     andAnimationType:(NSString *)animationType
  andAnimationSubtype:(NSString *)animationSubtype
      andAnimationkey:(NSString *)animationKey;


///animationDirection : kCATransitionFromRight
+(void)viewTransition:(UIView *)view
     andAnimationTime:(NSTimeInterval)animationTime
andAnimationDirection:(NSString *)animationDirection
     andAnimationType:(NSString *)animationType
  andAnimationSubtype:(NSString *)animationSubtype
      andAnimationkey:(NSString *)animationKey;

@end
