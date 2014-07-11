//
//  UIResourceTools.m
//  XMPPClient
//
//  Created by zhihuiguan on 14-4-10.
//  Copyright (c) 2014年 zhihuiguan. All rights reserved.
//

#import "UIResourceTools.h"

@implementation UIResourceTools

+(UIColor *)mainColor
{
    static UIColor *mainColor = nil;
    if (!mainColor) {
        mainColor =[UIColor redColor];
    }
    return mainColor;
}

+(UIImage *)imageNamed:(NSString *)name
{
    return [UIImage imageNamed:name];
}

+(UIColor*)titleColor{
    return [UIColor whiteColor];
}

+(UIStatusBarStyle)statusBarStyle{
    return UIStatusBarStyleBlackOpaque;
}

+(UIStatusBarStyle)loginStatusBarStyle{
    return UIStatusBarStyleDefault;
}
+(UIColor *)tabBarTextSelectedColor{
    return [UIColor whiteColor];
}

+(UIColor *)tabBarTextNormalColor{
    return UIColorFromRGB(0x989898);
}

+(UIColor *)naviBarButtonTitleColor{
    return [UIColor whiteColor];
}

+(UIColor *)imagePickerColor{
    return [UIColor blackColor];
}

+(UIColor *)segmentColor{
    UIColor *color = [UIColor colorWithRed:60/255 green:60/255 blue:60/255 alpha:0.6];
    return color;
}
+(void)setSegmentStyle{
 
    [[UISegmentedControl appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]} forState:UIControlStateSelected];

    [UISegmentedControl appearance].tintColor = [UIColor lightGrayColor];
    [UISegmentedControl appearance].backgroundColor = [UIColor clearColor];

}
+(UIColor *)switchColor{
//    UIColor *color = [UIColor colorWithRed:60/255 green:60/255 blue:60/255 alpha:0.6];
//    return color;
    return nil;
}
+(UIColor *)pureButtonColor{
    UIColor *color = UIColorFromRGB(0x99CA37);
    return color;

}
+(UIColor *)inputElementTextColor{
    UIColor *blackColor = [UIColor blackColor];
    return blackColor;
}
@end
