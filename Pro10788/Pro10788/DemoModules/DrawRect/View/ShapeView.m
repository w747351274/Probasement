//
//  ShapeView.m
//  Pro10788
//
//  Created by 江磊 on 4/19/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGFloat x = 200/2 + 30/2,y = 200 ;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, x , 0 );
        CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    //苹果柄
    CGContextAddQuadCurveToPoint(context, x - 30, 15, x - 30, 50);
    CGContextAddQuadCurveToPoint(context, x , 35, x , 0);

    //height 60

    CGContextMoveToPoint(context , x - 30, 50 + 10);
    //第一道曲线
    CGContextAddQuadCurveToPoint(context, (x )/2 , 40, 30 , 50 + 10);
    //第二道曲线
    CGContextAddQuadCurveToPoint(context, - 25 , (y + 15)/2,  (x - 55)/2 , y - 20);
    //左下角的曲线
    CGContextAddQuadCurveToPoint(context,  (x - 10)/2 , y+10, x - 30, y - 10);
    //右下角
    CGContextAddQuadCurveToPoint(context, 200 -( x - 30), y + 10 , 200 - x/2 , y - 20);
    //右方曲线
    CGContextAddQuadCurveToPoint(context,200 - x/2 +20  , (y -40), 200 - x/2 + 25 , (y - 60));
    CGContextAddQuadCurveToPoint(context, 200 - x/2 + 45 - 80, (y + 15)/2,200 - (x - 45)/2 , 50 + 20);
 
    //最后一道曲线
    CGContextAddQuadCurveToPoint(context,200 -  (x )/2 , 40, x - 30, 50 + 10);

    CGContextDrawPath(context, kCGPathFill);
        CGContextStrokePath(context);
}
@end
