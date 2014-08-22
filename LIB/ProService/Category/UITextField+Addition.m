//
//  UITextField+Addition.m
//  Pro10788
//
//  Created by WangJiangLei on 13/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "UITextField+Addition.h"

@implementation UITextField (Addition)

+ (UITextField *) textFieldWithPlaceholder:(NSString *)paramPlaceholder{
    UITextField *result = [[UITextField alloc] init];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    result.borderStyle = UITextBorderStyleRoundedRect;
    result.placeholder = paramPlaceholder;
    return result;
}
@end
