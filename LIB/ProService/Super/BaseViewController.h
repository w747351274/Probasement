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

static inline bool isOrientationIsLandscape() {
    return UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
}

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
// 设定画面元素
- (void)initViews;
// 设定画面跳转关系
- (void)configureAll;

- (void)showHttpWaiting;
- (void)showWaiting:(NSString *)text;
- (void)showWaiting:(NSString *)text withView:(UIView *)view;
- (void)hideWaiting;

// 为参数view 加入tap 关闭键盘的事件效果
- (void)addTapCloseListenToView:(UIView *)view;
- (void)orientationDidChange:(BOOL)isOrientationIsLandscape;
@end
