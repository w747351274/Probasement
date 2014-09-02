//
//  PlainViewController.m
//  Air6200
//
//  Created by Jianglei Wang on 2014/08/22.
//  Copyright (c) 2014年 Jianglei Wang. All rights reserved.
//

#import "PlainViewController.h"
#import "AppDelegate.h"

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
    
    UIGestureRecognizer *panGestureRecognizer =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    plainContentView = [[PlainContentView alloc]init];
    [plainContentView addGestureRecognizer:panGestureRecognizer];
    [self.view addSubview:plainContentView];
    [self setDefaultLayout];
}
-(void)setDefaultLayout{
    [plainListView layoutLeftInSuperwithSize:CGSizeMake(listWidth, 0)];
    [plainContentView layoutHorizontalNextTo:plainListView];
}
-(void)setContentFull{
    [plainListView layoutFullInSuper];
    [plainContentView layoutFullInSuper];
    isContentFull = YES;
}
-(void)setListFull{
    [plainListView layoutFullInSuper];
    [plainContentView layoutEqualSizeNextTo:plainListView];
    isContentFull = NO;
}
// 设定画面跳转关系
- (void)configureAll{
    //默认页面
    [plainListView showDefaultContent];
    isContentFull = NO;
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
        static float startPoint_X; //记录开始滑动时的 触控位置Y坐标
        float endPoint_X;   //记录结束滑动时的 触控位置Y坐标
        switch (gesture.state)
        {
            case UIGestureRecognizerStateBegan:
            {
                startPoint_X = [gesture locationInView:self.view].x;
            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                endPoint_X   = [gesture locationInView:self.view].x;
                float gPoint = (endPoint_X - startPoint_X);
                [self.view removeConstraints:self.view.constraints];
                [plainListView layoutFullInSuper];
                if (gPoint >= 0) {
                    [plainContentView layoutEqualSize:plainListView withXPoint:gPoint];
                }else{
                    [plainContentView layoutEqualSize:plainListView withXPoint:0];
                }
                [gesture setTranslation:CGPointZero inView:self.view];

            }
                break;
            case UIGestureRecognizerStateEnded:
            {
                endPoint_X   = [gesture locationInView:self.view].x;
                float sizeX =  endPoint_X - startPoint_X;
                [self.view removeConstraints:self.view.constraints];
                if (sizeX >= 80) {
                    [self setListFull];
                    
                }else{
                    [self setContentFull];
                }
                
            }
                break;
            case UIGestureRecognizerStateCancelled:
            {
                [self.view removeConstraints:self.view.constraints];
                [self setContentFull];
            }
                break;
            default:
                break;
        }

    }
}
@end
