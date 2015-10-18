//
//  AppDelegate.m
//  MRan
//
//  Created by 凌空 on 15/10/10.
//  Copyright © 2015年 fharmony. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "MRLoginViewController.h"
#import "MRRegisterViewController.h"
#import "MRRegisterTestViewController.h"
#import "MRUserModel.h"
#import "MRNavigationController.h"
#import "MRSquareViewController.h"
#import "MRMineViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

//    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MRSquareViewController *squareViewController = (MRSquareViewController *) [[UIStoryboard storyboardWithName:@"Square"
                                                                                                         bundle:nil]
                                                                                             instantiateInitialViewController];
    squareViewController.title = @"附近1000米";
    UITabBarItem *squareItem = [[UITabBarItem alloc]
                                        initWithTitle:@"广场" image:[[UIImage imageNamed:@"square"]
                                                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                    selectedImage:[[UIImage imageNamed:@"square_selected"]
                                                                            imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    squareViewController.tabBarItem = squareItem;
    MRMineViewController *mineViewController = (MRMineViewController *) [[UIStoryboard storyboardWithName:@"Mine"
                                                                                                   bundle:nil]
                instantiateViewControllerWithIdentifier:@"MRMineViewController"];
    mineViewController.title = @"我的";
    UITabBarItem *mineItem = [[UITabBarItem alloc]
                                            initWithTitle:@"我的" image:[[UIImage imageNamed:@"my"]
                                                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                        selectedImage:[[UIImage imageNamed:@"my_selected"]
                                                                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    mineViewController.tabBarItem = mineItem;
    UINavigationController *squareNav = [[UINavigationController alloc]
                                                                 initWithRootViewController:squareViewController];
    UINavigationController *mineNav = [[UINavigationController alloc]
                                                               initWithRootViewController:mineViewController];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[squareNav, mineNav];

    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = UIColorFromRGB(COLOR_MAIN_FOREGROUND);
    NSMutableDictionary *titleAttribute = [NSMutableDictionary dictionary];
    titleAttribute[NSForegroundColorAttributeName] = UIColorFromRGB(COLOR_MAIN_WHITE);
    navigationBar.titleTextAttributes = titleAttribute;

    self.window.rootViewController = tabBarController;
    MRLoginViewController *loginViewController = (MRLoginViewController *) [[UIStoryboard storyboardWithName:@"LoginAndRegister"
                                                                                                      bundle:nil]
                                                                    instantiateViewControllerWithIdentifier:@"MRLoginViewController"];

//    [self.window.rootViewController presentViewController:loginViewController
//                                                 animated:YES
//                                               completion:nil];
//    [self.window.rootViewController presentViewController:loginViewController
//                                                               animated:YES
//                                                             completion:nil];
    [self.window makeKeyAndVisible];
    return YES;
}




@end
