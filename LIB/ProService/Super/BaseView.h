//
//  BaseView.h
//  Pro10788
//
//  Created by WangJiangLei on 14/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BaseView : UIView{
    MBProgressHUD *hud;
}

- (void)showHttpWaiting;
- (void)showWaiting:(NSString *)text;
- (void)showWaiting:(NSString *)text withView:(UIView *)view;
- (void)hideWaiting;
@end
