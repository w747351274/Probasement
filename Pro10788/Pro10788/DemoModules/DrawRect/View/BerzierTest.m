//
//  BerzierTest.m
//  Pro10788
//
//  Created by WangJiangLei on 23/4/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "BerzierTest.h"

@implementation BerzierTest

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor blackColor] setFill];
    [[UIBezierPath customBezierPathOfArrowSymbolWithRect:CGRectMake(0, 0, self.width, self.height) scale:1 thick:5 direction:kUIBezierPathArrowDirectionRight] fill];
}


@end