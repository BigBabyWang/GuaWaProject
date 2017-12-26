//
//  UITextField+Placeholder.m
//  BuDeJie
//
//  Created by 罗壮燊 on 16/1/7.
//  Copyright © 2016年 lzs. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>

@implementation UITextField (Placeholder)


+ (void)load
{
    //获取自定义的方法
    Method lzs_setPlaceholderMethod = class_getInstanceMethod(self, @selector(lzs_setPlaceholder:));
    //获取系统的set方法
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    //交换两个方法的实现
    method_exchangeImplementations(lzs_setPlaceholderMethod, setPlaceholderMethod);
}

- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //添加一个属性，保存设置的颜色 => _placeholderColor = placeholderColor
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UILabel *label = [self valueForKeyPath:@"placeholderLabel"];
    label.textColor = placeholderColor;
    
}


- (void)lzs_setPlaceholder:(NSString *)placeholder
{
    [self lzs_setPlaceholder:placeholder];
    UIColor *textColor = objc_getAssociatedObject(self, @"placeholderColor");
    [self setPlaceholderColor:textColor];
}

@end
