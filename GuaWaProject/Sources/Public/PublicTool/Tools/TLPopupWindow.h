//
//  TLPopupWindow.h
//  popupWindow
//
//  Created by 余天龙 on 16/4/26.
//  Copyright © 2016年 YuTianLong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, operationType) {
    
    operationTypeTopUpCompleted ,           //充值成功
    operationTypeTopUpFailure ,             //充值失败
};

@interface TLPopupWindow : UIView

//点击外部，是否隐藏，默认NO
@property (nonatomic, assign) BOOL hideWhenTapOutside;

/**
 *  显示 / 隐藏
 *
 *  @param animated 是否动画， 默认YES
 */

- (void)show:(BOOL)animated;

- (void)dismiss;

/**
 *  描述
 *  地址选择器
 */

- (instancetype)initWithPickerViewcompleteBlock:(void (^)(NSString *pro, NSString *city, NSString *region))completeBlock;

/**
 *  描述
 *
 *  @param operationType 操作类型
 *  @param content       如果是操作成功，传 钱数 ； 如果操作失败， 传 原因。
 */

- (instancetype)initWithOperationType:(operationType)operationType
                              content:(NSString *)content;


/**
 *  描述
 *
 *  @param title     设置价格
 *  @param content   为菜品选择什么样的...
 *  @param introduce 价格和销售状态小贴士...
 *
 */

- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content
                    introduce:(NSString *)introduce;

/**
 *  描述
 *
 *  @param title         确认摄影服务申请
 *  @param content       如果摄影师接受了...
 *  @param completeBlock 提交回调
 *
 */

- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content
                completeBlock:(void (^)())completeBlock;


/**
 *  支付成功 弹窗
 *
 *  @param completed 分享红包 回调
 *
 */

- (instancetype)initCompleteBlock:(void (^)())completed;

/**
 *  基于webView 显示的弹窗
 *
 *  @param url url地址
 *
 */

- (instancetype)initWithURL:(NSURL *)url;

/**
 *  自定义UIView
 */

- (instancetype)initWithCustomView:(UIView *)customView;

///推荐邀请弹窗配置UIView
- (instancetype)initWithRecommendOrInvideView:(UIView *)customView;

@end
