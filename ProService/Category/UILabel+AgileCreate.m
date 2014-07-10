//
//  UILabel+AgileCreate.m
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "UILabel+AgileCreate.h"

@implementation UILabel (AgileCreate)
+(UILabel *)labelWithContent:(NSString *)str{
    UILabel *label = [[UILabel alloc]init];
    [label setText:str];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [label sizeToFit];
    [label.layer setShadowColor:[UIColor whiteColor].CGColor];
    return label;
}
 
@end
