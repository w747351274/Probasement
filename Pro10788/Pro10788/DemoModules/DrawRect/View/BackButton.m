//
//  BackButton.m
//  Pro10788
//
//  Created by WangJiangLei on 6/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "BackButton.h"

@implementation BackButton
static const CGFloat angle = 15;//距离最左面的角度大小
static const CGFloat fontsize = 16;//字体大小
static const NSString *stringBack = @"返回"; //文字内容
static const CGFloat radius = 5; //半径
#define StrokeColor [UIColor blackColor] //边框颜色
#define FillColor   [UIColor orangeColor]//填充颜色
#define FontColor [UIColor whiteColor] //文字颜色
#define HeightLightColor  [UIColor redColor]
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGFloat width = self.frame.size.width;
    CGFloat pY = self.frame.size.height/2;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, StrokeColor.CGColor);
    CGContextSetFillColorWithColor(context, FillColor.CGColor);

    CGContextSetLineWidth(context, 1);
    //起始点
    CGContextMoveToPoint(context, 2, pY);
    //第一条曲线
    CGContextAddQuadCurveToPoint(context, angle - 6,  2 , angle, 2);
    //正上方的直线
    CGContextAddLineToPoint(context,width - 10 - 2, 2);
    //右上方圆弧
    CGContextAddArc(context, width - radius -2, radius +2, radius, M_PI +M_PI_2, M_PI *2, 0);
    //右面垂直线
    CGContextAddLineToPoint(context,width -2, pY *2 -10 -radius);
    //右下方的圆弧
    CGContextAddArc(context, width - radius - 2, pY *2 - radius - 2, radius, 0, M_PI_2, 0);
    //正下方的水平线
    CGContextAddLineToPoint(context, angle, pY *2 - 2);
    //最后的曲线
    CGContextAddQuadCurveToPoint(context, angle - 6, 2*pY -2 , 2, pY);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextStrokePath(context);
    
    switch (self.state) {
        case UIControlStateNormal:
            CGContextSetFillColorWithColor(context, FontColor.CGColor);
            
            break;
            
        case UIControlStateHighlighted:
            CGContextSetFillColorWithColor(context, HeightLightColor.CGColor);

            break;
        default:
           CGContextSetFillColorWithColor(context, FontColor.CGColor);
        break;
    }
    [stringBack drawAtPoint:ccp(angle   , pY - fontsize /2 -2) withFont:[UIFont systemFontOfSize:fontsize]];
    
}
- (void)sendActionsForControlEvents:(UIControlEvents)controlEvents{
    NSLog(@"action");
}
@end
