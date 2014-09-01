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
    AppDelegate *delegate =[UIApplication sharedApplication].delegate;
    if (!isOrientationIsLandscape()) {
        static float startPoint_X; //记录开始滑动时的 触控位置Y坐标
        float endPoint_X;   //记录结束滑动时的 触控位置Y坐标
        static float viewPoint_X;  //记录开始滑动时的 视图位置Y坐标
        
        switch (gesture.state)
        {
            case UIGestureRecognizerStateBegan:
            {
                startPoint_X = [gesture locationInView:delegate.window].x;
                
                NSLog(@"\n\n========开始滑动");
                NSLog(@"起始点的Y坐标为：%f",startPoint_X);
                NSLog(@"视图的起始坐标为：%f",viewPoint_X);
            }
                break;
            case UIGestureRecognizerStateChanged:
            {
                endPoint_X   = [gesture locationInView:delegate.window].x;
                float gPoint = viewPoint_X + (endPoint_X - startPoint_X);
                plainContentView.frame = CGRectMake(0, gPoint, 320, 568);// gPoint;
                [gesture setTranslation:CGPointZero inView:delegate.window];
                
                NSLog(@"\n\n=========持续滑动");
                NSLog(@"视图的坐标调整后为：%f",gPoint);
                NSLog(@"滑动的的距离为： %f",endPoint_X - startPoint_X);
                
            }
                break;
            case UIGestureRecognizerStateEnded:
            {
                NSLog(@"\n\n=========结束滑动");
                
                CGRect rect = plainContentView.frame;
                
                NSLog(@"view Y === %f",plainContentView.frame.origin.x);
                
            }
                break;
            case UIGestureRecognizerStateCancelled:
            {
                NSLog(@"====oh NO===滑动被取消了");
                
                /*********************************************
                 * 不排除有，pan事件被中断的可能，处理同stateEnded *
                 *********************************************/
                
            }
                break;
            default:
                break;
        }

    }
}
@end
