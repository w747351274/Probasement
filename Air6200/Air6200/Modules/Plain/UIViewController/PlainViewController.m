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
    
    UIGestureRecognizer *panGestureRecognizer =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    plainContentView = [[PlainContentView alloc]init];
    [plainContentView addGestureRecognizer:panGestureRecognizer];
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
-(void)setListFull{
    [plainListView layoutFullInSuper];
    [plainContentView layoutEqualSizeNextTo:plainListView];
    
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
        [UIView animateWithDuration:1 animations:^{
            [self setContentFull];
        } completion:^(BOOL finished) {
        }];
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
            [self setListFull];
        }
    }
}
/**
 *  滑动手势 事件
 *
 *  @param gesture pan手势
 */
- (void)panHandle:(UIPanGestureRecognizer *)gesture
{
    if (!isOrientationIsLandscape()) {
        [UIView animateWithDuration:1 animations:^{
            [self.view removeConstraints:self.view.constraints];
            [self setListFull];
        } completion:^(BOOL finished) {
        }];
    }
}
@end
