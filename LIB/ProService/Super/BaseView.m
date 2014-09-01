//
//  BaseView.m
//  Pro10788
//
//  Created by WangJiangLei on 14/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (void)initViews{
    if (IOS7_OR_LATER) {
        //ios7 pushviewcontroller 透明效果不好的bug
        self.backgroundColor = [UIColor whiteColor];
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initViews];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)showWaiting:(NSString *)text withView:(UIView *)view {
    if (hud) {
        hud = nil;
    }
    hud = [[MBProgressHUD alloc] initWithView:view];
    [self addSubview:hud];
    hud.labelText = text;
    [hud show:YES];
}

- (void)showWaiting:(NSString *)text {
    if (hud == nil) {
        [self showWaiting:text withView:self];
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

@end
