//
//  BubbleView.m
//  Pro10788
//
//  Created by WangJiangLei on 16/4/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "BubbleView.h"

@implementation BubbleView
@synthesize strContent;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        if (self.width <80) {
            self.width = 80;
        }
        if (self.height <60) {
            self.height = 60;
        }
        self.animationStatus = KAnimation;
        [self addObserver:self forKeyPath:@"self.animationStatus" options:NSKeyValueObservingOptionNew context:(__bridge void *)(self)];
        [self beginAnimation];
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == (__bridge void *)(self)) {
        if ([keyPath  isEqualToString: @"self.animationStatus"]) {
            switch (self.animationStatus) {
                case KStop:
                {
                    [self setNeedsDisplay];
                    [imgView.layer removeAnimationForKey:@"moveTheSquare"];
                    imgView.hidden = YES;
                }
                    break;
                case KAnimation:
                {
                    [self setNeedsDisplay];
                    [imgView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
                    
                    imgView.hidden = NO;
                }
                    break;
                    
                default:
                    break;
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    //反转
//    CGContextTranslateCTM(context, self.width, 0.0);
//    CGContextScaleCTM(context, -1.0, 1.0);
    
    CGFloat radius = 15;
    CGFloat x = 7;
    CGFloat y = self.frame.size.height - radius - 5 ;

    CGFloat height =self.height - 2*radius - 13 ;
    CGFloat width = self.width - 3*radius - 18 ;
    CGContextMoveToPoint(context, x ,y);
    //左面一条线
    CGContextAddLineToPoint(context, x, y- height);
    //左上面的1/4圆形
    CGContextAddArc(context, x + radius, y - height , radius, M_PI,M_PI + M_PI_2, 0);
    //上面一条线
    CGContextAddLineToPoint(context, x + radius + width, y - height - radius);
    //右上方第一道曲线 经过两个点 计算公式
    CGContextAddQuadCurveToPoint(context,
                                 x + radius + width + radius/4 + 2 , y - height - radius ,
                                 x + radius + width + radius/4 + radius/2, y - height - radius + 10);
    //右上方第二道曲线
    CGContextAddQuadCurveToPoint(context,
                                 x + radius + width + 10 + 15 + (radius -15), y - height - radius + 10 + 5 - 18,
                                 x + radius + width + 10 + 15 + radius, y - height - radius + 10 + 5 - 19);
    //右上方第三道曲线
    CGContextAddQuadCurveToPoint(context,
                                 x + 2*radius + width + 5, y - height + radius -27 ,
                                 x + 2*radius + width, y - height + radius );
    //右面的一条垂直曲线
    CGContextAddLineToPoint(context, x + 2 * radius + width , y);
    //右下方的1/4圆
    CGContextAddArc(context, x + radius + width  , y , radius, 0,  M_PI_2, 0);
    //最下方的一条线
    CGContextAddLineToPoint(context, x + radius, y + radius);
    //左下方的圆形
    CGContextAddArc(context, x + radius , y , radius, M_PI_2,  M_PI, 0);
    
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);

    //这个方法和上面的一样
//    CGContextSetRGBFillColor(context, 121.0/255 ,200.0/255.0 , 00.0/255.0 ,0.3);
    if (self.animationStatus ==KAnimation) {
        
        CGContextSetStrokeColorWithColor(context, [UIColor lightTextColor].CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0, 0),2, [UIColor lightGrayColor].CGColor);
        CGContextDrawPath(context, kCGPathFillStroke);
    }else{
        CGContextDrawPath(context, kCGPathFill);
    }

    CGContextStrokePath(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0),0, [UIColor lightGrayColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);

    [self.strContent drawInRect:CGRectMake(radius, radius , self.width - 2*radius -18 , self.height - 2*radius) withFont:[UIFont systemFontOfSize:14] lineBreakMode:NSLineBreakByCharWrapping];
}
-(void)beginAnimation{
    UIGraphicsBeginImageContext(CGSizeMake(20, 20));
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 0.5);
    CGContextSetFillColorWithColor(context, [UIColor lightTextColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 10, [UIColor lightTextColor].CGColor);
    CGContextAddEllipseInRect(context, CGRectMake(5, 5, 10, 10));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    imgView = [[UIImageView alloc]initWithImage:image];
    [imgView setFrame:CGRectMake(0, 0, 10, 10)];
    //addanimation
    //Prepare the animation - we use keyframe animation for animations of this complexity
    pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationCubicPaced;
    //We want the animation to p`ersist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 5.0;
    //Lets loop continuously for the demonstration
    pathAnimation.repeatCount = MAXFLOAT;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    CGFloat radius = 15;
    CGFloat x = 7;
    CGFloat y = self.height - radius - 5 ;
    
    if (self.height < radius) {
        self.height = radius;
    }
    
    CGFloat height =self.height - 2*radius - 13 ;
    CGFloat width = self.width - 3*radius - 18 ;
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    
    //    CGPathMoveToPoint(curvedPath, NULL, 110, 160);
     CGPathMoveToPoint(curvedPath,NULL, x ,y);
    //左面一条线
    CGPathAddLineToPoint(curvedPath,NULL, x, y - height);
//    //左上面的1/4圆形
     CGPathAddArc(curvedPath,NULL, x + radius, y - height , radius, M_PI,M_PI + M_PI_2, 0);
    //上面一条线
    CGPathAddLineToPoint(curvedPath,NULL, x + radius + width, y - height - radius);
    //右上方第一道曲线 经过两个点 计算公式
    CGPathAddQuadCurveToPoint(curvedPath,NULL,
                              x + radius + width + radius/4 + 2 , y - height - radius ,
                              x + radius + width + radius/4 + radius/2, y - height - radius + 10);
    //右上方第二道曲线
    CGPathAddQuadCurveToPoint(curvedPath,NULL,
                              x + radius + width + 10 + 15 + (radius -15), y - height - radius + 10 + 5 - 18,
                              x + radius + width + 10 + 15 + radius, y - height - radius + 10 + 5 - 19);
    //右上方第三道曲线
    CGPathAddQuadCurveToPoint(curvedPath,NULL,
                              x + 2*radius + width + 5, y - height + radius -27 ,
                              x + 2*radius + width, y - height + radius );
    //右面的一条垂直曲线
    CGPathAddLineToPoint(curvedPath,NULL, x + 2 * radius + width , y);
    //右下方的1/4圆
    CGPathAddArc(curvedPath,NULL, x + radius + width  , y , radius, 0,  M_PI_2, 0);
    //最下方的一条线
    CGPathAddLineToPoint(curvedPath,NULL, x + radius, y + radius);
    //左下方的圆形
    CGPathAddArc(curvedPath,NULL, x + radius , y , radius, M_PI_2,  M_PI, 0);
    
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    [imgView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];

    [self addSubview:imgView];
}
@end
