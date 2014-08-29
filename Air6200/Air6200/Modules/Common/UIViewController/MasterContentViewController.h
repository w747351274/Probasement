//
//  MasterContentViewController.h
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import <ProService/BaseViewController.h>
#import "MenuView.h"
#import "ContentView.h"

@interface MasterContentViewController : BaseViewController<MenuDelegate>{
    MenuView *menuView;
    UIView *contentView;
}
@property(nonatomic,strong)NSArray *arrController;
@property(nonatomic,strong)NSArray *arrMenu;

-(id)initWithMenu:(NSArray *)arrMenu controller:(NSArray *)arrController;

@end
