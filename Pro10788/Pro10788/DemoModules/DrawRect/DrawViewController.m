//
//  DrawViewController.m
//  Pro10788
//
//  Created by WangJiangLei on 15/4/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawTestView.h"
#import "DrawCureView.h"
#import <QuartzCore/QuartzCore.h> 
#import "BackButton.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

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
    bubbleView = [[BubbleView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    [bubbleView setCenter:ccp(100, 280)];
    bubbleView.strContent = @"BUG #1250 在会话页面中接受两张以上图片或者视频后，点击会话查看，最后一条能成功收到，其他的在图片上显示“0%”，点击提示:文件不存在文件不存在文件不存在文件不存在文件不存在文件不存在文件不存在";
    [self.view addSubview:bubbleView];

    DrawCureView *cuv = [[DrawCureView alloc]initWithFrame:CGRectMake(20, 20, 60, 60)];
    [self.view addSubview:cuv];
    [self drawRound];
    fv = [[FillWordColor alloc]initWithFrame:CGRectMake(10, 10, 20, 300)];
    fv.degree = 0;
    [self.view addSubview:fv];
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(stopAnimation) userInfo:nil repeats:YES];
    
    ShapeView *shape = [[ShapeView alloc]initWithFrame:CGRectMake(10+60, 10, 170, 200)];

    [self.view addSubview:shape];
    UIImageView *imgView = [[UIImageView alloc]init];
    [imgView setFrame:CGRectMake(0, 0, 100, 100)];
    [imgView setCenter:ccp(200, 200)];
    UIEdgeInsets ed = {20.0f, 20.0f, 20.0f, 20.0f};
    [imgView setImage:[[UIImage imageNamed:@"sanji.png"]resizableImageWithCapInsets:ed resizingMode:UIImageResizingModeTile]];
    [self.view addSubview:imgView];

    BerzierTest *ber = [[BerzierTest alloc]initWithFrame:CGRectMake(10, 30, 15, 20)];
    [self.view addSubview:ber];
    BackButton *button = [[BackButton alloc]initWithFrame:CGRectMake(120, 120,70, 37)];
    [button setTitle:@"回去" forState:UIControlStateNormal];
        [button setTitle:@"回去" forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(showMessage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)showMessage:(id)sender{

    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"button"
                                                 message:@"button"
                                                delegate:nil
                                       cancelButtonTitle:@"ko"
                                       otherButtonTitles:@"OK", nil];
    [av show];
}
-(void)stopAnimation{

        if(fv.degree <100){
            fv.degree ++;
        }else{
            fv.degree = 0;
        }

//    iconImg.layer.transform = CATransform3DMakeRotation(fv.degree * 2 * M_PI/100, 0, 1, 0);
    iconImg.layer.affineTransform = CGAffineTransformMakeRotation(fv.degree*2*M_PI/100);
    if(bubbleView.animationStatus ==KAnimation){
        bubbleView.animationStatus =KStop;
    }else{
        bubbleView.animationStatus = KAnimation;
    }
}
-(void)configureAll{
    [super configureAll];
    bg bgtest = 0;
    
    bgtest |= bg1;
    NSLog(@"bgtest1-%d",bgtest);
    bgtest |= bg2;
    NSLog(@"bgtest2-%d",bgtest);
    bgtest |= bg3;
    NSLog(@"bgtest3-%d",bgtest);
    bgtest |= bg4;
    NSLog(@"bgtest4-%d",bgtest);
    bgtest |= bg5;
    NSLog(@"bgtest5-%d",bgtest);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.titleView = [UILabel labelWithContent:@"DrawAnimition"];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
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
    //Pass the selected object to the new view controller.
}
*/
-(void)drawRound{
    iconImg = [[UIImageView alloc]initWithImage:mImageByName(@"sanji")];
    
    [iconImg sizeToFit];
    CGFloat radius = iconImg.width < iconImg.height ? iconImg.width/2:iconImg.height/2;

    iconImg.layer.cornerRadius = radius;
    [iconImg.layer setMasksToBounds:YES];
    iconImg.center = ccp(110, 160);
    
    
    UIGraphicsBeginImageContext(CGSizeMake(14, 14));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetShouldAntialias(context, true);
    CGContextSetLineWidth(context, 1.5);
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 2, [UIColor redColor].CGColor);
    CGContextAddEllipseInRect(context, CGRectMake(2, 2, 10, 10));
    CGContextDrawPath(context, kCGPathFillStroke);
 
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageView *imgView = [[UIImageView alloc]initWithImage:image];
    [imgView setFrame:CGRectMake(0, 0, 7, 7)];
    //addanimation
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to p`ersist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 1.0;
    //Lets loop continuously for the demonstration
    pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    //    CGPathMoveToPoint(curvedPath, NULL, 110, 160);
    CGPathAddEllipseInRect(curvedPath,NULL, CGRectMake(V_X(iconImg)
                                                         ,V_Y(iconImg), radius*2, radius*2));
    
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    [imgView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];

    [self.view addSubview:imgView];
    [self.view addSubview:iconImg];
}
@end
