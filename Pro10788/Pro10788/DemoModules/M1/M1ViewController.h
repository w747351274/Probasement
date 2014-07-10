//
//  M1ViewController.h
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactCoreDataStorage.h"
@interface M1ViewController : BaseViewController{
    UITextField *textFieldName;
    UITextField *textFieldEmail;
    UITextField *textFieldAge;
    UILabel *labelCount;
}
@property(nonatomic,strong)ContactCoreDataStorage *dataStorage;
@end
