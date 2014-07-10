//
//  GestureTest.m
//  Pro10788
//
//  Created by WangJiangLei on 17/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "GestureTest.h"
#import <ProService/Category.h>
#import "SectionHeaderButton.h"

@interface GestureTest()
@end

@implementation GestureTest
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)initViews{
    [super initViews];
    NSString * numStr = @"3 2 4 2 3";
    
    UIImage *image = mImageByName(@"shu");
    CGSize sizeFrame = CGSizeMake(image.size.width/10, image.size.height);
    NSArray *arr = [numStr componentsSeparatedByString:@" "];
    UIView *viewNum = [[UIView alloc]initWithFrame:CGRectMake(50, 100, arr.count * sizeFrame.width, sizeFrame.height)];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        int num = [obj intValue];
        CGRect rectFrame = CGRectMake(num *sizeFrame.width, 0, sizeFrame.width, sizeFrame.height);
        
        CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage],rectFrame);
        UIImage *image1 = [UIImage imageWithCGImage:imageRef];
        UIImageView *viewImage = [[UIImageView alloc]initWithFrame:CGRectMake(idx * sizeFrame.width, 0, sizeFrame.width, sizeFrame.height)];
        [viewImage setImage:image1];
        [viewNum addSubview:viewImage];
    }];
    [self.view addSubview:viewNum];

    UIButton *headerButton = [SectionHeaderButton initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.bounds), 56) withTitle:@"ExpandOrCollapse" touchUpInsideBlock:^(SectionHeaderButtonStatus status) {
        NSLog(@"Got Expand");
    }];
    [self.view addSubview:headerButton];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.label = [UILabel labelWithContent:@"Gesture"];
    [self.label sizeToFit];
    self.label.center = self.view.center;
    [self.view addSubview:self.label];
 
    UISwipeGestureRecognizer *swipGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    swipGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    swipGesture.numberOfTouchesRequired = 1;
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(actionRotation:)];
    
    [self.view addGestureRecognizer:rotationGesture];
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    longPressGesture.minimumPressDuration = 1.0f;
    longPressGesture.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:longPressGesture];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gesture{
    CGPoint point1 = [gesture locationOfTouch:0 inView:self.view];
    CGPoint point2 = [gesture locationOfTouch:1 inView:self.view];
    
    CGPoint middPoint = CGPointMake((point1.x +point2.x)/2, (point1.y + point2.y)/2);
    self.label.center = middPoint;

}

-(void)swipeAction:(UISwipeGestureRecognizer *)gesture{
    if (gesture.direction & UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"down");
    }
    if (gesture.direction & UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"up");
    }
    if (gesture.direction & UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"right");
    }
    if (gesture.direction & UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"left");
        GusturePanAndDragViewController *ge = [[GusturePanAndDragViewController alloc]init];
        [self.navigationController pushViewController:ge animated:YES];
    }
}
-(void)actionRotation:(UIRotationGestureRecognizer *)rotator{
    self.label .transform = CGAffineTransformMakeRotation(self.rotationAngleInRadians +rotator.rotation);
    if (rotator.state == UIGestureRecognizerStateEnded) {
        self.rotationAngleInRadians += rotator.rotation;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
