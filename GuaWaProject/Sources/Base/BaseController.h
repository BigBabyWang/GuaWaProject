//
//  BaseController.h
//  JYApp
//
//  Created by tulip on 14-4-11.
//  Copyright (c) 2014年 co5der. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessEngine.h"
#import "MHelp.h"
@class TabBarView;
/**
 * Controller 基类，实现一些公用的操作或保存公用的对象
 */
@class SDCycleScrollView;

typedef enum {
    doPopType_Pop = 0,
    doPopType_PopToRoot,
    doPopType_PopToController,
}doPopType; //映射

@interface BaseController : UIViewController
@property (nonatomic, strong) UIImageView *bg_nav;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *leftButton;
@property (nonatomic, weak) UIVisualEffectView *blurView;
@property(nonatomic,weak)UIButton *rightThirdButton;
@property (nonatomic, weak) UIButton *centerButton;
@property (nonatomic, weak) UIButton *rightButton;
@property (nonatomic, strong) UIImageView *base_bg;
@property (nonatomic, strong)TabBarView * tabbarView;
@property (nonatomic, strong) BusinessEngine *busEngine;
@property (nonatomic, weak) IBOutlet UIScrollView *bContentScroll;
@property(nonatomic,assign)doPopType popType;
@property(nonatomic,weak)UIViewController *popController;
///默认tableview 
@property (nonatomic, weak) IBOutlet UITableView *bMainTable;

@property (nonatomic, assign) CGFloat bContentHeight;
@property (nonatomic, assign) CGFloat bKeyBoardHeight;
@property (atomic, assign) BOOL isAppearing;//当前View是否正显示
@property (strong, nonatomic) MHelpList *helpList;

- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame;

- (UIView *) getCommNavTopView:(NSString *)title numButton:(NSInteger)numButton;
- (UIView *)getTabbar:(NSInteger)index;
- (IBAction) hideKeyBoard:(UIButton *)sender;
- (IBAction) doPopControl; //执行navigation pop
//- (void) setRightButton:(NSString *)title action:(SEL)action;
//- (void) setBackButton:(SEL)action;
- (void) hideRightMenu;
//- (IBAction) goMainControl:(id)sender;
//- (IBAction) goLoginControl:(id)sender;
- (IBAction) dismissControl;//for modal
- (void)popToViewControllerOfClass:(Class)clazz animated:(BOOL)animated;
- (void)releaseCycleScroll:(SDCycleScrollView *)scroll;
- (void)goWalletHelp;//钱包页帮助
- (void)setHelpBtn;
-(void)commin:(NSInteger)eva_id andPoint:(NSInteger)point completion:(void(^)())block;
- (CAGradientLayer *)changeBackColor:(NSString *)starColor andEndColor:(NSString *)endColor;
- (void)keyboardWillShow:(NSNotification *)aNotification;
- (void)keyboardWillHide:(NSNotification *)aNotification;
- (void)openUserInteractionEnabled:(UIButton *)button;
- (void)closeUserInteractionEnabled:(UIButton *)button;




@end
