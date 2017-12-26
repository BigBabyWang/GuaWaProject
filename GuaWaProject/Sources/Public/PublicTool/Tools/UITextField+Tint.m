//
//  UITextField+Tint.m
//  MatchLive
//
//  Created by liufashi on 16/7/2.
//  Copyright © 2016年 mjBear. All rights reserved.
//

#import "UITextField+Tint.h"
#import <objc/runtime.h>
@implementation UITextField (Tint)

+ (void)load
{
    
    Method awakeFromNib = class_getInstanceMethod([self class], @selector(awakeFromNib));
    Method ml_awakeFromNibMethod = class_getInstanceMethod([self class], @selector(ml_awakeFromNib));
    method_exchangeImplementations(awakeFromNib, ml_awakeFromNibMethod);
    
    Method initWithFrame = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method ml_initWithFrame = class_getInstanceMethod([self class], @selector(ml_initWithFrame:));
    method_exchangeImplementations(initWithFrame, ml_initWithFrame);
}

- (void)ml_awakeFromNib
{
    if ([self isKindOfClass:[UITextField class]]) {
        [self ml_awakeFromNib];
        self.tintColor = [UIColor whiteColor];
        self.textColor = [UIColor whiteColor];
    }
}

- (instancetype)ml_initWithFrame:(CGRect)frame
{
    if ([self isKindOfClass:[UITextField class]]) {
        
        UITextField *textfield = [self ml_initWithFrame:frame];
        textfield.tintColor = [UIColor whiteColor];
        self.textColor = [UIColor whiteColor];
        return textfield;
    }
    
    return [self ml_initWithFrame:frame];
}




@end
