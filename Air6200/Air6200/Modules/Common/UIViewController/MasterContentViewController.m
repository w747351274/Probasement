//
//  MasterContentViewController.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "MasterContentViewController.h"

@interface MasterContentViewController ()

@end
//设置左边menu的宽度
const CGFloat menuWidth = 60;

@implementation MasterContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithMenu:(NSArray *)arrMenu controller:(NSArray *)arrController{
    
    self = [super init];
    if (self) {
        // Custom initialization
        self.arrController = arrController;
        self.arrMenu = arrMenu;
    }
    return self;
}
// 设定画面元素
- (void)initViews{

    menuView = [[MenuView alloc]initWithMenu:self.arrMenu];
    menuView.menuDelegate = self;
    [self.view addSubview:menuView];
    [menuView layoutLeftInSuperwithSize:CGSizeMake(menuWidth, menuWidth*[self.arrMenu count])];
    [menuView  setSelectedIndex:0];
}

-(void)indexChanged:(NSUInteger)index{
    
    NSAssert([self.arrMenu count] == [self.arrController count], @"menu and the controller should be equal");
    if (contentView) {
        [contentView removeFromSuperview];
        contentView = nil;
    }
    UIViewController *controller = self.arrController[index];
    contentView = controller.view;
    [self.view addSubview:contentView];
    [contentView layoutHorizontalNextTo:menuView ofSize:CGSizeZero];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
