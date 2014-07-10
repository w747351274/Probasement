//
//  FillWordColor.m
//  Pro10788
//
//  Created by WangJiangLei on 17/4/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "FillWordColor.h"

@implementation FillWordColor

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        [self addObserver:self forKeyPath:@"self.degree" options:NSKeyValueObservingOptionNew context:(__bridge void *)(self)];
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == (__bridge void *)(self)) {
        if ([keyPath isEqualToString:@"self.degree"]) {
            [self setNeedsDisplay];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//    CGFloat colors[] =
//    {
//        204.0/ 255.0, 224.0/ 255.0, 244.0/ 255.0, 1.00,
//        29.0/ 255.0, 156.0/ 255.0, 215.0/ 255.0, 1.00,
//        0.0/ 255.0,  50.0/ 255.0, 126.0/ 255.0, 1.00,
//    };

    CGFloat colors[] =
    {
   204.0/ 255.0, 224.0/ 255.0, 244.0/ 255.0, 1.00,
          0.0/ 255.0,  50.0/ 255.0, 126.0/ 255.0, 1.00,
   
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    CGContextDrawLinearGradient(context, gradient,CGPointMake(0.0,0.0) ,
                                CGPointMake(0.0,self.height* self.degree/100),kCGGradientDrawsBeforeStartLocation);

    //Arrows
    int arrowSize = self.height* self.degree/100 - 40;
    int xmargin = 20;
    int ymargin = 18;
    //    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.width - (xmargin+arrowSize/1.5), ymargin);
    CGContextAddLineToPoint(context,self.width - xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,self.width - (xmargin+arrowSize/1.5), ymargin + arrowSize);
    CGContextAddLineToPoint(context,self.width - (xmargin+arrowSize/1.5), ymargin);
    
    CGContextSetFillColorWithColor(context,
                                   [UIColor blueColor].CGColor);
    CGContextFillPath(context);
    
    
    
//    
//    UIImage*image= [UIImage imageNamed:@"sanji"];
//    CGImageRef imageRef = CGImageRetain(image.CGImage);
//    
//    CGContextDrawImage(context,  CGRectMake(10.0,10, 90.0, 90.0),imageRef);
    
    CGContextStrokePath(context);
    CGContextFillPath(context);
    
}
 
@end
