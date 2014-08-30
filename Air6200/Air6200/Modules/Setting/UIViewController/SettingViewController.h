//
//  SettingViewController.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/27.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <Proservice/BaseViewController.h>
#import "WebContentView.h"
@interface SettingViewController : BaseViewController<UITextFieldDelegate>{
    UITextField *textfield;
    NSString *currentSite;
}
@property(nonatomic,strong)UIView<ContentViewProtocal> *contentView;
@end
