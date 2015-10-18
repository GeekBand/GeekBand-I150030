//
// Created by 凌空 on 15/10/17.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import "MRWebsiteViewController.h"


@implementation MRWebsiteViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:self.urlstr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = [UIScreen mainScreen].bounds;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_back"]
                                                                                             imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(pop)];

}

- (void)pop {
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.hidesBottomBarWhenPushed = YES;
}
@end