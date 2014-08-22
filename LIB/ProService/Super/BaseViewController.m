//
//  BaseViewController.m
//  CardMaster
//
//  Created by Lyner on 13-7-9.
//  Copyright (c) 2013年 GL. All rights reserved.
//

#import "BaseViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface BaseViewController ()
@end

@implementation BaseViewController

// 初始化共通设置,比如背景图,导航栏风格等
- (void)initViews
{
    // 大的背景图
    if (mSystemVersion.floatValue >= 7) {
    }
    [self addKeyboardNotification];
    tapRecognizer = [[UITapGestureRecognizer alloc] init];
    tapRecognizer.delegate = self;
    [self addTapCloseListenToView:self.view];
}

////////////////////////////////////////////////////////////
// UIGestureRecognizerDelegate methods

#pragma mark UIGestureRecognizerDelegate methods

/**
 现象，view的tapGesture挡住了手势，所以对这个手势进行判断，并执行操作，如果要使用这个手势事件调用给tapBlock 赋值即可
 **/
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    BOOL result ;
    if ([gestureRecognizer isEqual:tapRecognizer]) {
        if (self.tapBlock) {
            self.tapBlock();
        }
        [self closeKeyboard:touch];
        result = NO;
    }else{
        result = YES;
    }
    return result;
}
- (void)configureAll
{
}

- (void)goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initViews];
    [self configureAll];
    if (IOS7_OR_LATER) {
        //ios7 pushviewcontroller 透明效果不好的bug
        self.view.backgroundColor = [UIColor whiteColor];
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }else{
        self.navigationController.navigationBar.tintColor = UIColorFromRGB(0xf1f1f1);
    }
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showWaiting:(NSString *)text withView:(UIView *)view {
    if (hud) {
        hud = nil;
    }
    hud = [[MBProgressHUD alloc] initWithView:view];
    [self.view addSubview:hud];
    hud.labelText = text;
    [hud show:YES];
}

- (void)showWaiting:(NSString *)text {
    if (hud == nil) {
        [self showWaiting:text withView:self.view];
    }
}

- (void)showHttpWaiting
{
    [self showWaiting:NSLocalizedString(@"Waiting", nil)];
}
- (void)hideWaiting {
    [hud hide:YES];
    hud = nil;
}

- (void)addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChanged:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillHide:)
                                                name:UIKeyboardWillHideNotification
                                              object:nil];
}

- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Keyboard Notification
- (void)keyboardWillChanged:(NSNotification *)note
{
    // 取得键盘弹出动画的相关信息
    NSValue *objectDuration   = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *objectCurve      = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *objectFrameBegin = [note.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *objectFrameEnd   = [note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSUInteger animationCurve = 0;
    double animationDuration  = 0.0f;
    CGRect keyboardEndRect    = CGRectZero;
    CGRect keyboardStartRect  = CGRectZero;
    
    [objectCurve getValue:&animationCurve];
    [objectDuration getValue:&animationDuration];
    [objectFrameBegin getValue:&keyboardStartRect];
    [objectFrameEnd getValue:&keyboardEndRect];
    
    // 让按键和键盘执行相同的动画,并弹出.
    [UIView beginAnimations:@"addMyButtonAnimation" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    // 真正要做的事情在这里
    if (self.openKeyboardBlock) {
        self.openKeyboardBlock(keyboardEndRect.size.height);
    }
    
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    // 取得键盘弹出动画的相关信息
    NSValue *objectDuration     = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *objectCurve        = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue *objectFrameBegin   = [note.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *objectFrameEnd     = [note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    NSUInteger animationCurve = 0;
    double animationDuration  = 0.0f;
    CGRect keyboardEndRect    = CGRectZero;
    CGRect keyboardStartRect  = CGRectZero;
    
    [objectCurve getValue:&animationCurve];
    [objectDuration getValue:&animationDuration];
    [objectFrameBegin getValue:&keyboardStartRect];
    [objectFrameEnd getValue:&keyboardEndRect];
    
    // 让按键和键盘执行相同的动画,并弹出.
    [UIView beginAnimations:@"addMyButtonAnimation" context:NULL];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:(UIViewAnimationCurve)animationCurve];
    // 真正要做的事情在这里
    if (self.closeKeyboardBlock) {
        self.closeKeyboardBlock(keyboardEndRect.size.height);
    }
    
    [UIView commitAnimations];
}

- (void)addTapCloseListenToView:(UIView *)view
{
    [view addGestureRecognizer:tapRecognizer];
}
- (void)closeKeyboard:(id)sender
{
    [self.view endEditing:YES];
}
@end
