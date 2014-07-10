//
//  DrawCureView.m
//  Pro10788
//
//  Created by WangJiangLei on 16/4/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "DrawCureView.h"

@implementation DrawCureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self drawACurvedLine];
        [self animateCicleAlongPath];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
//This draws a quadratic bezier curved line right across the screen
- ( void ) drawACurvedLine {
    //Create a bitmap graphics context, you will later get a UIImage from this
    UIGraphicsBeginImageContext(CGSizeMake(320,260));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //Set variables in the context for drawing
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    //Set the start point of your drawing
    CGContextMoveToPoint(ctx, 10, 10);
    //The end point of the line is 310,450 .... i'm also setting a reference point of 10,450
    //A quadratic bezier curve is drawn using these coordinates - experiment and see the results.
    CGContextAddQuadCurveToPoint(ctx, 10, 150, 310, 250);
    //Add another curve, the opposite of the above - finishing back where we started
    CGContextAddQuadCurveToPoint(ctx, 310, 10, 10, 10);
    
    //Draw the line
    CGContextDrawPath(ctx, kCGPathStroke);
    
    //Get a UIImage from the current bitmap context we created at the start and then end the image context
    UIImage *curve = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //With the image, we need a UIImageView
    UIImageView *curveView = [[UIImageView alloc] initWithImage:curve];
    //Set the frame of the view - which is used to position it when we add it to our current UIView
    curveView.frame = CGRectMake(1, 1, 320, 250);
    curveView.backgroundColor = [UIColor clearColor];
    [self addSubview:curveView];
}
- (void) animateCicleAlongPath {
    //Prepare the animation - we use keyframe animation for animations of this complexity
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //Set some variables on the animation
    pathAnimation.calculationMode = kCAAnimationPaced;
    //We want the animation to persist - not so important in this case - but kept for clarity
    //If we animated something from left to right - and we wanted it to stay in the new position,
    //then we would need these parameters
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 5.0;
    //Lets loop continuously for the demonstration
    pathAnimation.repeatCount = 1000;
    
    //Setup the path for the animation - this is very similar as the code the draw the line
    //instead of drawing to the graphics context, instead we draw lines on a CGPathRef
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, 10, 10);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 10, 150, 310, 250);
    CGPathAddQuadCurveToPoint(curvedPath, NULL, 310, 10, 10, 10);
    
    //Now we have the path, we tell the animation we want to use this path - then we release the path
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //We will now draw a circle at the start of the path which we will animate to follow the path
    //We use the same technique as before to draw to a bitmap context and then eventually create
    //a UIImageView which we add to our view
    UIGraphicsBeginImageContext(CGSizeMake(20,20));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //Set context variables
    CGContextSetLineWidth(ctx, 1.5);
    CGContextSetFillColorWithColor(ctx, [UIColor greenColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    //Draw a circle - and paint it with a different outline (white) and fill color (green)
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, 18, 18));
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(1, 1, 20, 20);
    [self addSubview:circleView];
    
    //Add the animation to the circleView - once you add the animation to the layer, the animation starts
    [circleView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
}

@end
