//
//  MasterContentViewController.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "MasterContentViewController.h"
#import "MenuView.h"
#import "ListView.h"
#import "ContentView.h"
@interface MasterContentViewController ()

@end
//设置左边menu的宽度
const CGFloat menuWidth = 60;
const CGFloat listWidth = 370;

@implementation MasterContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// 设定画面元素
- (void)initViews{
    UILabel *label = [UILabel labelWithContent:@"hello air6200"];
    [self.view addSubview:label];
    [label layoutTopInSuperwithSize:CGSizeZero];

    MenuView *menuView = [[MenuView alloc]init];
    [self.view addSubview:menuView];
    [menuView layoutLeftInSuperwithSize:CGSizeMake(menuWidth, 0)];

    ListView *listView = [[ListView alloc]init];
    [self.view addSubview:listView];
    [listView layoutHorizontalNextTo:menuView ofSize:CGSizeMake(listWidth, 0)];
    
    ContentView *contentView = [[ContentView alloc]init];
    [self.view addSubview:contentView];
    [contentView layoutHorizontalNextTo:listView ofSize:CGSizeZero];
}

// 设定画面跳转关系
- (void)configureAll{
    
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
