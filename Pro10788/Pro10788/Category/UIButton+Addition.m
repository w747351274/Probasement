//
//  UIButton+Addition.m
//  TWApp
//
//  Created by line0 on 13-7-11.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "UIButton+Addition.h"

@implementation UIButton (Addition)

+ (UIButton *)buttonWithNImage:(UIImage *)nimage pImage:(UIImage *)pImage delegate:(id)del selector:(SEL)sel
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:nimage forState:UIControlStateNormal];
    [btn setImage:pImage forState:UIControlStateHighlighted];
    [btn addTarget:del action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return btn;
}

+ (UIButton *)buttonWithNormalImage:(UIImage *)image andTitle:(NSString*)title width:(CGFloat)aWidth height:(CGFloat)aHeight target:(id)aTarget selector:(SEL)aSelector{
    //    UIImage *img = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0 )];
    UIImage *img = [image stretchableImageWithLeftCapWidth:image.size.width/2.0 topCapHeight:image.size.height/2.0];
    
    UIFont *font = [UIFont boldSystemFontOfSize:13];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(0, 0, aWidth, aHeight);
    
    [btn addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
 
+ (UIButton *)buttonWithStr:(NSString *)strTitle
{
    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [customButton setTitle:strTitle forState:UIControlStateNormal];
    [customButton setTitle:strTitle forState:UIControlStateHighlighted];
    [customButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [customButton.titleLabel setFont:[UIFont systemFontOfSize:FontSizeOfButton]];
    [customButton setBackgroundColor:UIColorFromRGB(ColorButtonBackground)];
    
    customButton.layer.cornerRadius = 5;
    [customButton sizeToFit];
    [customButton setHeight:FontSizeOfButton * 1.618];
    [customButton setWidth:customButton.width + FontSizeOfButton* 0.618];
    return customButton;
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)t target:(id)tgt action:(SEL)a
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
 
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:15.0]];
    [button setTitleColor:UIColorFromRGB(ColorButtonBackground) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(ColorButtonBackground) forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor colorWithWhite:1.0 alpha:0.7] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [[button titleLabel] setShadowOffset:CGSizeMake(0.0, 1.0)];
    
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = [t sizeWithFont:[UIFont boldSystemFontOfSize:12.0]].width + 24.0;
 
    [button setFrame:buttonFrame];
 
    [button setTitle:t forState:UIControlStateNormal];
    
    [button addTarget:tgt action:a forControlEvents:UIControlEventTouchUpInside];
    
    [button sizeToFit];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return buttonItem;
}

@end
