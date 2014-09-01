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
    [self setDefaultLayout];
}
-(void)setDefaultLayout{
    [plainListView layoutLeftInSuperwithSize:CGSizeMake(360, 0)];
    [plainContentView layoutHorizontalNextTo:plainListView];
}
-(void)setContentFull{
    [plainListView layoutFullInSuper];
    [plainContentView layoutFullInSuper];
}
// 设定画面跳转关系
- (void)configureAll{
    //默认页面
    [plainListView showDefaultContent];
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

-(void)selectedPlainUrl:(NSString *)url{
    if (!isOrientationIsLandscape()) {
        [self.view removeConstraints:self.view.constraints];
        [self setContentFull];
        isContentFull = YES;
    }
    [plainContentView reloadContent:url];

}
-(void)orientationDidChange:(BOOL)isOrientationIsLandscape{
    [self.view removeConstraints:self.view.constraints];
    if (isOrientationIsLandscape) {
        NSLog(@"isOrientationIsLandscape");
        [self setDefaultLayout];
    }else{
        NSLog(@"not OrientationIsLandscape");
        if (isContentFull) {
            [self setContentFull];
        }else{
            [plainListView layoutFullInSuper];
            [plainContentView layoutEqualSizeNextTo:plainListView];
        }
    }
}
@end
