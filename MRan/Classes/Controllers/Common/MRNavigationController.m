//
// Created by 凌空 on 15/10/12.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import "MRNavigationController.h"


@implementation MRNavigationController {

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBasicAppearence];
}

- (void)setBasicAppearence {

    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.barTintColor = UIColorFromRGB(COLOR_MAIN_FOREGROUND);
    NSMutableDictionary *titleAttribute = [NSMutableDictionary dictionary];
    titleAttribute[NSForegroundColorAttributeName] = UIColorFromRGB(COLOR_MAIN_WHITE);
    navigationBar.titleTextAttributes = titleAttribute;

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];

    if (self.view.subviews.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIImage *backImg = [UIImage imageNamed:@"ic_back@2x.png"];
        [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                                                            initWithImage:backImg
                                                                                    style:UIBarButtonItemStylePlain
                                                                                   target:self
                                                                                   action:@selector(popView)];

    }
}

- (void)popView {

    [self popViewControllerAnimated:YES];

}
@end