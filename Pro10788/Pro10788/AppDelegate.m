//
//  AppDelegate.m
//  Pro10788
//
//  Created by 江磊 on 1/26/14.
//  Copyright (c) 2014 江磊. All rights reserved.
//

#import "AppDelegate.h"
#import "M1ViewController.h"
#import "M2ViewController.h"
#import "M3ViewController.h"
#import "GestureTest.h"
#import "BlockTestViewController.h"
#import "DrawViewController.h"
#import <ProService/UncaughtExceptionHandler.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    InstallUncaughtExceptionHandler();
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    M1ViewController *m1 = [[M1ViewController alloc]init];
    M2ViewController *m2 = [[M2ViewController alloc]init];
    M3ViewController *m3 = [[M3ViewController alloc]init];
    GestureTest *gv = [[GestureTest alloc]init];
    BlockTestViewController *bv = [[BlockTestViewController alloc]init];
    DrawViewController *drawController = [[DrawViewController alloc]init];
    UINavigationController *n1 = [[UINavigationController alloc]initWithRootViewController:m1];
    n1.navigationBar.translucent = NO;
    UINavigationController *n2 = [[UINavigationController alloc]initWithRootViewController:m2];
    n2.navigationBar.translucent = NO;
    UINavigationController *n3 = [[UINavigationController alloc]initWithRootViewController:m3];
    n3.navigationBar.translucent = NO;
    UINavigationController *ng = [[UINavigationController alloc]initWithRootViewController:gv];
    ng.navigationBar.translucent = NO;
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:bv];
    nv.navigationBar.translucent = NO;
    UINavigationController *nd = [[UINavigationController alloc]initWithRootViewController:drawController];
    nd.navigationBar.translucent = NO;
    
    NSArray * arrController = @[nd,n2,n3,ng,nv,n1];
    NSArray *arrTitleImageArray = @[TabItem(@"draw", UIResourceBundleImage(@"conversation_press"),UIResourceBundleImage(@"conversation")),
                                   TabItem(@"MM2", UIResourceBundleImage(@"setting_press"),
                                           UIResourceBundleImage(@"setting")),
                                   TabItem(@"MM3", UIResourceBundleImage(@"trends_press"),
                                           UIResourceBundleImage(@"trends")),
                                   TabItem(@"Gesture",UIResourceBundleImage(@"conversation_press"),
                                           UIResourceBundleImage(@"conversation")),
                                   TabItem(@"Block", UIResourceBundleImage(@"trends_press"),
                                           UIResourceBundleImage(@"trends")),
                                   TabItem(@"MM1", UIResourceBundleImage(@"trends_press"),
                                           UIResourceBundleImage(@"trends"))];
    
    self.tab = [UITabBarController customTabBarWithControllerArrary:arrController
                                                AndTitleImagesArray:arrTitleImageArray];
    [self.tab setSelectedIndex:3];
    self.window.rootViewController = self.tab;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
@end