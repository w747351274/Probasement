//
//  SectionHeaderButton.m
//  Pro10788
//
//  Created by WangJiangLei on 8/7/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "SectionHeaderButton.h"

@implementation SectionHeaderButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+ (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title touchUpInsideBlock:(touchUpInsideBlock_t)touchUpInside
{
    SectionHeaderButton *tempSectionHeadedrButton = [[SectionHeaderButton alloc]initWithFrame:frame];
    // Initialization code
    [tempSectionHeadedrButton setTitle:title forState:UIControlStateNormal];
    [tempSectionHeadedrButton setTitle:title forState:UIControlStateHighlighted];
    tempSectionHeadedrButton->touchUpInsideBlock = touchUpInside;
    [tempSectionHeadedrButton addTarget:tempSectionHeadedrButton action:@selector(actionTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    return tempSectionHeadedrButton;
}
-(void)actionTouchUpInside:(SectionHeaderButton *)btn{
    if (touchUpInsideBlock) {
        touchUpInsideBlock(self.status);
    }
}
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddRect(context, self.bounds);
    CGContextSetStrokeColorWithColor(context, [UIColor lightTextColor].CGColor);
    CGContextSetLineWidth(context, 0.3);
    switch (self.state) {
        case UIControlStateNormal:
            CGContextSetFillColorWithColor(context, [UIResourceTools pureButtonColor].CGColor);
            break;
            
        case UIControlStateHighlighted:
            CGContextSetFillColorWithColor(context, [UIResourceTools pureButtonColor].CGColor);
            
            break;
        default:
            CGContextSetFillColorWithColor(context, [UIColor brownColor].CGColor);
            break;
    }
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextStrokePath(context);
    
    CGSize size = [strNomalTitle sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(320, 25) lineBreakMode:NSLineBreakByCharWrapping];
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    [strNomalTitle drawAtPoint:CGPointMake(15, (CGRectGetHeight(self.bounds) -size.height)/2) withFont:[UIFont systemFontOfSize:15]];
    CGFloat arrowHeigt = CGRectGetHeight(self.bounds) - CGRectGetHeight(self.bounds)/5;
    CGFloat arrowWidth =CGRectGetHeight(self.bounds)/2.5;
    if (self.status == SectionHeaderCollapse) {
        [[UIBezierPath customBezierPathOfArrowSymbolWithRect:CGRectMake (CGRectGetWidth(self.bounds) - arrowHeigt,
                                                                         (CGRectGetHeight(self.bounds) - arrowHeigt)/2,
                                                                         arrowWidth,
                                                                         arrowHeigt)
                                                       scale:1 thick:3 direction:kUIBezierPathArrowDirectionRight] fill];
    }else{
        [[UIBezierPath customBezierPathOfArrowSymbolWithRect:CGRectMake (CGRectGetWidth(self.bounds) - arrowHeigt - arrowHeigt/4,
                                                                        (CGRectGetHeight(self.bounds) - arrowWidth)/2,
                                                                        arrowHeigt,
                                                                        arrowWidth)
                                                       scale:1 thick:3 direction:kUIBezierPathArrowDirectionDown] fill];
    }
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    switch (state) {
        case UIControlStateNormal:
            strNomalTitle = title;
            break;
        case UIControlStateHighlighted:
            strHighlightedTitle = title;
        default:
            break;
    }
}
//完成一个点击事件时触发的方法,来自继承类UIControl
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(self.status == SectionHeaderExpand){
        self.status = SectionHeaderCollapse;
    }else{
        self.status = SectionHeaderExpand;
    }
    [self setNeedsDisplay];
}
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
    return YES;
}
@end
