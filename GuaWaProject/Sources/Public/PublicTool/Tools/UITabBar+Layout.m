//
//  UITabBar+Layout.m
//  MatchLive
//
//  Created by liufashi on 16/7/6.
//  Copyright © 2016年 mjBear. All rights reserved.
//

#import "UITabBar+Layout.h"
@implementation UITabBar (Layout)

+ (void)load
{
    
    Method awakeFromNib = class_getInstanceMethod([self class], @selector(layoutSubviews));
    Method ml_awakeFromNibMethod = class_getInstanceMethod([self class], @selector(ml_layoutSubviews));
    method_exchangeImplementations(awakeFromNib, ml_awakeFromNibMethod);
    
}

- (void)ml_layoutSubviews
{
    [self ml_layoutSubviews];
    
//    self.backgroundColor = DEF_USER_COLOR;
    UITabBar *tabBar = self;
    CGFloat btnW = tabBar.frame.size.width / (tabBar.items.count + 1);
    CGFloat btnH = tabBar.frame.size.height;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    // 调整子控件位置 UITabBarButton
    int i = 0;
    for (UIControl *tabBarButton in tabBar.subviews) {
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        if (i == 4) {
            i += 1;
        }
        
        btnX = i * btnW;
        
        if (self.tag == 1001) {
            // 调整子控件位置
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        } 
        
      
        i++;
    }
}



@end
