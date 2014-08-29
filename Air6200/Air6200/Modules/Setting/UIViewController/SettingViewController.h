//
//  SettingViewController.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <Proservice/BaseViewController.h>
#import "ContentView.h"
@interface SettingViewController : BaseViewController<UITextFieldDelegate>{
    ContentView *content;
    UITextField *textfield;
    NSString *currentSite;
}

@end
