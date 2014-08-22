//
//  UITabBarController+Custom.m
//  Pro10788
//
//  Created by WangJiangLei on 12/2/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "UITabBarController+Custom.h"

@implementation UITabBarController (Custom)
+(UITabBarController *)customTabBarWithControllerArrary:(NSArray *)vcArray AndTitleImagesArray:(NSArray *)titleImagesArray{
    
    NSAssert(([vcArray count] == [titleImagesArray count]), @"控制器数量和给出的素材不一致");
    UITabBarController *tabBarController= [[UITabBarController alloc]init];
    tabBarController.viewControllers = vcArray;
    [tabBarController.tabBar.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITabBarItem * item = (UITabBarItem *)obj;
        NSDictionary *dic = [titleImagesArray objectAtIndex:idx];
        NSString *strTitle = [dic objectForKey:KTitle];
        NSAssert([[dic objectForKey:KImageSelected] isKindOfClass:[UIImage class]], @"必须给出图片");
        NSAssert([[dic objectForKey:KImageNomal] isKindOfClass:[UIImage class]], @"必须给出图片");
        UIImage  *imageSelected = [dic objectForKey:KImageSelected];
        UIImage  *imageNomal = [dic objectForKey:KImageNomal];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            item.selectedImage = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.image = [imageNomal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            item.title = strTitle;
            [item setTitleTextAttributes:@{NSForegroundColorAttributeName:ColorNormal} forState:UIControlStateNormal];
            [item setTitleTextAttributes:@{NSForegroundColorAttributeName:ColorPress} forState:UIControlStateSelected];
        }else{
            [item setTitle:strTitle];
            [item setFinishedSelectedImage:imageSelected withFinishedUnselectedImage:imageNomal];
            [item setTitleTextAttributes:@{UITextAttributeTextColor:ColorNormal} forState:UIControlStateNormal];
            [item setTitleTextAttributes:@{UITextAttributeTextColor:ColorPress} forState:UIControlStateSelected];
        }
    }];
    [[tabBarController tabBar] setSelectedImageTintColor:UIColorFromRGB(0xCF00EB)];
    if (!IOS7_OR_LATER) {
        tabBarController.tabBar.backgroundImage = mImageByName(@"bgd");
    }
    return tabBarController;
}
@end
