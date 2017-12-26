//
//  UITextView+Tint.m
//  MatchLive
//
//  Created by liufashi on 16/7/2.
//  Copyright © 2016年 mjBear. All rights reserved.
//

#import "UITextView+Tint.h"

@implementation UITextView (Tint)

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
    if ([self isKindOfClass:[UITextView class]]) {
        [self ml_awakeFromNib];
        self.tintColor = [UIColor whiteColor];
        self.textColor = [UIColor whiteColor];
    }
}

- (instancetype)ml_initWithFrame:(CGRect)frame
{
    if ([self isKindOfClass:[UITextView class]]) {
        
        UITextView *textView = [self ml_initWithFrame:frame];
        textView.tintColor = [UIColor whiteColor];
        textView.textColor = [UIColor whiteColor];
        return textView;
    }
    
    return [self ml_initWithFrame:frame];
}

@end
