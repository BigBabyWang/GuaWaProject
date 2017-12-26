//
//  XMRKTransition.m
//  Animation
//
//  Created by xmrk3 on 16/1/13.
//  Copyright © 2016年 xmrk3. All rights reserved.
//

#import "XMRKTransition.h"

@implementation XMRKTransition

+(void)viewTransition:(UIView *)view
     andAnimationTime:(NSTimeInterval)animationTime
     andAnimationType:(NSString *)animationType
  andAnimationSubtype:(NSString *)animationSubtype
      andAnimationkey:(NSString *)animationKey{
    
    CATransition *transition = [CATransition animation];
    [transition setDuration:animationTime];///动画持续时间
    [transition setType:animationType];///动画类型
    /*
     kCATransitionFade淡出
     kCATransitionMoveIn覆盖原图
     kCATransitionPush推出
     kCATransitionReveal底部显出来
     使用@“”
     pageCurl   向上翻一页
     pageUnCurl 向下翻一页
     rippleEffect 滴水效果
     suckEffect 收缩效果，如一块布被抽走
     cube 立方体效果
     oglFlip 上下翻转效果
     */
    /* 过渡方向
     fromLeft
     fromRight
     fromBottom
     fromTop
     */
     
    
    [transition setSubtype: kCATransitionFromLeft];///动画方向
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];//动画开始和结束时间的快慢
    [view.layer addAnimation:transition forKey:animationKey];//动画的key
}

+(void)viewTransition:(UIView *)view
     andAnimationTime:(NSTimeInterval)animationTime
andAnimationDirection:(NSString *)animationDirection
     andAnimationType:(NSString *)animationType
  andAnimationSubtype:(NSString *)animationSubtype
      andAnimationkey:(NSString *)animationKey{
    //kCATransitionFromLeft
    CATransition *transition = [CATransition animation];
    [transition setDuration:animationTime];///动画持续时间
    [transition setType:animationType];///动画类型
    /*
     kCATransitionFade淡出
     kCATransitionMoveIn覆盖原图
     kCATransitionPush推出
     kCATransitionReveal底部显出来
     使用@“”
     pageCurl   向上翻一页
     pageUnCurl 向下翻一页
     rippleEffect 滴水效果
     suckEffect 收缩效果，如一块布被抽走
     cube 立方体效果
     oglFlip 上下翻转效果
     */
    /* 过渡方向
     fromLeft
     fromRight
     fromBottom
     fromTop
     */
    
    
    [transition setSubtype:animationDirection];///动画方向
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];//动画开始和结束时间的快慢
    [view.layer addAnimation:transition forKey:animationKey];//动画的key
}

@end
