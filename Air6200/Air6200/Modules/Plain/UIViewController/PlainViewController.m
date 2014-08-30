//
//  PlainViewController.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "PlainViewController.h"


@interface PlainViewController ()

@end

@implementation PlainViewController
const CGFloat listWidth = 370;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// 设定画面元素
- (void)initViews {
    [super initViews];
    plainListView = [[PlainListView alloc]init];
    plainListView.delegate = self;
    [self.view addSubview:plainListView];
    plainContentView = [[PlainContentView alloc]init];
    [self.view addSubview:plainContentView];
    [plainListView layoutLeftInSuperwithSize:CGSizeMake(370, 0)];
    [plainContentView layoutHorizontalNextTo:plainListView];
}

// 设定画面跳转关系
- (void)configureAll{
    //默认页面
    [self selectedPlainUrl:[[NSBundle mainBundle]pathForResource:@"1" ofType:@"html"] ];
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
-(void)selectedPlainUrl:(NSString *)url{
    [plainContentView reloadContent:url];
}
@end
