//
//  AppDelegate.h
//  MRan
//
//  Created by 凌空 on 15/10/10.
//  Copyright © 2015年 fharmony. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRUserModel;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MRUserModel *user;
@end

