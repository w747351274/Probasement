//
//  UIResourceTools.h
//  XMPPClient
//
//  Created by zhihuiguan on 14-4-10.
//  Copyright (c) 2014年 zhihuiguan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UIResourceMainColor [UIResourceTools mainColor]
#define UIResourceImage(name) [UIResourceTools imageNamed:(name)]


CG_INLINE UIImage * UIResourceBundleImage(NSString *name)
{
    NSString *strPath = [NSString stringWithFormat:@"default.bundle/image/%@.png",name];
    UIImage *image = [UIImage imageNamed:strPath];
    return image;
}

@interface UIResourceTools : NSObject

+(UIColor *)mainColor;

+(UIImage *)imageNamed:(NSString *)name;

+(UIColor *)titleColor;

+(UIStatusBarStyle)statusBarStyle;

+(UIStatusBarStyle)loginStatusBarStyle;

+(UIColor *)tabBarTextSelectedColor;

+(UIColor *)tabBarTextNormalColor;

+(UIColor *)naviBarButtonTitleColor;

+(UIColor *)imagePickerColor;

+(UIColor *)segmentColor;

+(void)setSegmentStyle;

+(UIColor *)switchColor;

+(UIColor *)pureButtonColor;

+(UIColor *)inputElementTextColor;
@end
