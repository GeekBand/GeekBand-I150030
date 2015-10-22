//
// Created by 凌空 on 15/10/12.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <MJExtension/NSObject+MJProperty.h>
#import "MRRegisterTestViewController.h"
#import "AFNetworking.h"
#import "PureLayout.h"
#import "MRUserModel.h"
#import "MBProgressHUD.h"

@implementation MRRegisterTestViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"gogogog" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button autoCenterInSuperview];


}

- (void)click:(id)sender {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"username"] = @"f1223fxx12scea11f2an";
    param[@"email"] = @"hu1dj322sffs11@163.com";
    param[@"password"] = @"1312221";
//    param[@"gbid"] = @"GeekBand-I150003";


    [MRUserModel loginWithData:param success:^(MRUserModel *user) {
         [MRUserModel saveAccountInfo:user];
         NSLog(@"%@", user.loginReturnMessage);
     }
                          fail:^(NSError *requestError) {
                              NSLog(@"%@",requestError.localizedDescription);
                          }];
//    [MRUserModel registerWithData:param success:^(MRUserModel *user) {
//         [MRUserModel saveAccountInfo:user];
//
//     }
//                             fail:^(NSError *requestError) {
//                                 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view
//                                                                           animated:YES];
//                                 //todo:请求失败的情况
//                                 hud.labelText = requestError.localizedDescription;
//                                 hud.mode = MBProgressHUDModeText;
//                                 [hud hide:YES afterDelay:1.5f];
//
//                             }];


}
@end