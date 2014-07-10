//
//  BaseViewController.h
//  CardMaster
//
//  Created by Lyner on 13-7-9.
//  Copyright (c) 2013年 GL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define kSpaceOfInputField 10

typedef void(^KeyboardBlock)(CGFloat);
typedef void(^tapBlock_t)(void);

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate>
{
    MBProgressHUD *hud;
    UITapGestureRecognizer * tapRecognizer;
}

@property (strong, nonatomic) UILabel * navigationBarTitle;
// 打开键盘/关闭键盘时要做的动作
@property (nonatomic, copy) KeyboardBlock openKeyboardBlock;
@property (nonatomic, copy) KeyboardBlock closeKeyboardBlock;
@property (nonatomic, copy) tapBlock_t tapBlock;
/** 旋转角度无关的屏幕宽度 */
@property (readonly) CGFloat screenWidth;
/** 旋转角度无关的屏幕高度 */
@property (readonly) CGFloat screenHeight;

// 设定画面元素
- (void)initViews;
// 设定画面跳转关系
- (void)configureAll;
// popViewController的回调
- (void)goback:(id)sender;

- (void)showHttpWaiting;
- (void)showWaiting:(NSString *)text;
- (void)showWaiting:(NSString *)text withView:(UIView *)view;
- (void)hideWaiting;

// 是否打左侧的返回简单, 为了支持首页点进来的场合
- (void)showBackArrowBtn:(BOOL)showit;

- (void)addKeyboardNotification;

- (void)removeKeyboardNotification;

// 为参数view 加入tap 关闭键盘的事件效果
- (void)addTapCloseListenToView:(UIView *)view;


/** 屏高 */
- (CGFloat)screenWidth;

/** 屏宽 */
- (CGFloat)screenHeight;

/** 设备当前是否为竖屏 */
- (BOOL)isPortraitOrientation;

/** 屏幕旋转后重新布局子View */
- (void)updateSubviews;

@end
