//
//  DrawTestView.m
//  Pro10788
//
//  Created by WangJiangLei on 15/4/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "DrawTestView.h"
#import <QuartzCore/QuartzCore.h>

@implementation DrawTestView
@synthesize strContent;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
//        UILabel *label = [UILabel labelWithContent:@"draw"];
//        
//        [self addSubview:label];
//        [label layoutTopInSuperwithSize:CGSizeMake(0, 0)];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 50, 50);
    CGContextAddLineToPoint(context, 200, 300);
    CGContextAddEllipseInRect(context, CGRectMake(50, 50, 100, 200));
   
    CGContextAddArc(context, 150, 300, 120, 0, M_PI , 0);
    CGContextAddArc(context, 150 - 60, 300 - 60, 30 , M_PI, M_PI + M_PI, 0);
    CGContextAddArc(context, 150 + 60, 300 - 60, 30 , M_PI, M_PI + M_PI, 0);
    
    
    CGContextAddLineToPoint(context, 150 + 120, 300);
    
    CGContextAddArc(context, 150 - 60, 300 - 60, 15 , 0, M_PI + M_PI, 0);
    CGContextAddArc(context, 150 + 60, 300 - 60, 15 , 0, M_PI + M_PI, 0);

    CGContextAddRect(context, CGRectMake(150 - 5/2, 300 - 5/2, 5, 5));
    CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 1, [UIColor redColor].CGColor);

    
    CGContextSetRGBStrokeColor(context,201.0/255 ,210.0/255.0 , 190.0/255.0 ,1.0);

    CGContextSetLineWidth(context, 5);
    CGRect rects[] = {CGRectMake(300, 400, 20, 20),CGRectMake(300, 440, 20, 20),CGRectMake(300, 480, 20, 20),CGRectMake(300, 520, 20, 20),CGRectMake(340, 480, 20, 20),CGRectMake(380, 480, 20, 20)};
    CGContextAddRects(context, rects,sizeof(rects)/sizeof(rects[0]));
    CGContextAddQuadCurveToPoint(context, 600, 600, 400, 200);

    CGContextClosePath(context);

    CGContextSetRGBFillColor(context, 221.0/255 ,100.0/255.0 , 00.0/255.0 ,0.3);
    CGContextDrawPath(context, kCGPathFill);
    CGContextStrokePath(context);

}
@end
