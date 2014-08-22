//
//  UITabBarController+Custom.h
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ColorPress UIColorFromRGB(0xD417ED)
#define ColorNormal UIColorFromRGB(0x989898)

#define KTitle @"title"
#define KImageSelected @"imageSelected"
#define KImageNomal @"imageNomal"

#define TabItem(title,selecteedImage,nomalImage) \
@ {KTitle : title, KImageSelected : selecteedImage, KImageNomal : nomalImage}

@interface UITabBarController (Custom)

+(UITabBarController *)customTabBarWithControllerArrary:(NSArray *)vcArray AndTitleImagesArray:(NSArray *)titleImagesArray;

@end
