//
//  GusturePanAndDragViewController.m
//  Pro10788
//
//  Created by WangJiangLei on 17/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "GusturePanAndDragViewController.h"

@interface GusturePanAndDragViewController ()

@end

@implementation GusturePanAndDragViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    UILabel *label = [UILabel labelWithContent:@"panDrage"];
    [label setCenter:ccp(100, 100)];
    [self.view addSubview:label];
    UIView *viewBlack = [[UIView alloc]init];
    [viewBlack setBackgroundColor:[UIColor red:100/255 green:125/225 blue:2220/225 alpha:0.3]];
    [viewBlack setFrame:CGRectMake( 200/2 + 10, V_BOT_Y(label) +10, 200, 200)];
    [self.view addSubview:viewBlack];
//    [viewBlack layoutVerticalNextTo:label ofSize:CGSizeMake(200, 200)];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 1;
     [self.view addGestureRecognizer:panGesture];
    
    UIPinchGestureRecognizer *pintch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePintch:)];
    
    [viewBlack addGestureRecognizer:pintch];
}
-(void)handlePintch:(UIPinchGestureRecognizer *)paramSender{
    if (paramSender.state == UIGestureRecognizerStateEnded) {
        self.currentScale = paramSender.scale;
    }else if(paramSender.state == UIGestureRecognizerStateBegan && self.currentScale != 0.0f){
        paramSender.scale = self.currentScale;
    }
    if (paramSender.scale != NAN && paramSender.scale != 0.0f) {
        paramSender.view.transform = CGAffineTransformMakeScale(paramSender.scale, paramSender.scale);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)handlePanGesture:(UIPanGestureRecognizer *)paramSender{
    if (paramSender.state != UIGestureRecognizerStateFailed
        && paramSender.state != UIGestureRecognizerStateEnded) {
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
    }
}
@end
