//
//  XMRKPushTransition.m
//  Animation
//
//  Created by xmrk3 on 16/1/12.
//  Copyright © 2016年 xmrk3. All rights reserved.
//

#import "XMRKPushTransition.h"
//push
@implementation XMRKPushTransition


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.8f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //此处进行动画处理
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toVC];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    toVC.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height);//设置动画偏移
    [[transitionContext containerView] addSubview:toVC.view];
    
    CGRect aaafinalFrameForVC = [transitionContext finalFrameForViewController:fromVC];
//    CGRect aaabounds = [[UIScreen mainScreen] bounds];
    fromVC.view.frame = CGRectOffset(aaafinalFrameForVC, 0, 0);//设置动画偏移
    [[transitionContext containerView] addSubview:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear animations:^{
        fromVC.view.alpha = 0.8;
        fromVC.view.frame = aaafinalFrameForVC;
        toVC.view.frame = finalFrameForVC;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        fromVC.view.alpha = 1.0;
    }];

}
@end

//pop
@implementation XMRKPopTransition
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrameForVc = [transitionContext finalFrameForViewController:toVc];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    toVc.view.frame = CGRectOffset(finalFrameForVc, 0, -bounds.size.height);//设置动画偏移
    
    [[transitionContext containerView] addSubview:toVc.view];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.view.alpha = 0.8;
                         toVc.view.frame = finalFrameForVc;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         fromVc.view.alpha = 1.0;
                     }];
}
@end