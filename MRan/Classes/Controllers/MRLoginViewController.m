//
//  MRLoginViewController.m
//  MRan
//
//  Created by 凌空 on 15/10/11.
//  Copyright © 2015年 fharmony. All rights reserved.
//

#import "MRLoginViewController.h"
#import "MBProgressHUD.h"
#import "MRApiClient.h"
#import "MRApiClient+Requset.h"
#import "MRRegisterTestViewController.h"
#import "MRRegisterViewController.h"

@interface MRLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
- (IBAction)loginBtnClick:(UIButton *)sender;
- (IBAction)registerBtnClick:(UIButton *)sender;
- (IBAction)touchScreen:(id)sender;

@end

@implementation MRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordTextfield.delegate = self;
    self.emailTextfield.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - actions

- (IBAction)loginBtnClick:(UIButton *)sender {
    if ([self checkEmailValid]&& [self checkPasswordValid]) {
        [self loginHandler];
    } else {
        if (self.passwordTextfield.text.length == 0) {
            [self showMessage:@"请输入密码"];
        } else if (self.emailTextfield.text.length == 0) {
            [self showMessage:@"请输入邮箱"];
        } else if (![self checkEmailValid]) {
            [self showMessage:@"请输入正确的邮箱地址"];
        } else {
            [self showMessage:@"请重新输入"];
        }
    }
}

- (IBAction)registerBtnClick:(UIButton *)sender {
    MRRegisterViewController *registerViewController = (MRRegisterViewController *) [[UIStoryboard storyboardWithName:@"LoginAndRegister"
                                                                                                                           bundle:nil]
                                                                                  instantiateViewControllerWithIdentifier:@"MRRegisterViewController"];
    [self presentViewController:registerViewController animated:YES
                     completion:nil];
}

- (IBAction)touchScreen:(id)sender {
    [self.emailTextfield resignFirstResponder];
    [self.passwordTextfield resignFirstResponder];
}


#pragma mark - custom method
- (BOOL)checkEmailValid {
    NSString *regex = RE_EMAIL;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self.emailTextfield.text];
}

- (BOOL)checkPasswordValid {
    NSString    *regex     = RE_PASSWORD;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self.passwordTextfield.text];
}

- (void)showMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud hide:YES afterDelay:1.5f];
}
#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - model

- (void)loginHandler {
    NSString *email = self.emailTextfield.text;
    NSString *password = self.passwordTextfield.text;
    [[MRApiClient sharedClient] LoginWithEmail:email AndPassword:password
                                     WithBlock:nil];
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
