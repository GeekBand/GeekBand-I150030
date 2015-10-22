//
//  MRRegisterViewController.m
//  MRan
//
//  Created by 凌空 on 15/10/11.
//  Copyright © 2015年 fharmony. All rights reserved.
//

#import "MRRegisterViewController.h"
#import "MBProgressHUD.h"
#import "MRApiClient.h"
#import "MRApiClient+Requset.h"

@interface MRRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmTextfield;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollviewCtrl;
- (IBAction)registerBtnClick:(UIButton *)sender;
- (IBAction)loginBtnClick:(UIButton *)sender;
- (IBAction)touchScreen:(id)sender;

@end

@implementation MRRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameTextfield.delegate = self;
    self.emailTextfield.delegate = self;
    self.passwordTextfield.delegate = self;
    self.passwordConfirmTextfield.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (IBAction)registerBtnClick:(UIButton *)sender {
    if ([self checkEmailValid] && [self checkPasswordValid] && [self checkUsernameValid]) {
        [self registerHandler];
    }
}

- (BOOL)checkUsernameValid {
    return self.usernameTextfield.text.length != 0;
}

- (BOOL)checkPasswordValid {


    NSString    *regex     = RE_PASSWORD;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:self.passwordConfirmTextfield.text] && [predicate evaluateWithObject:self
            .passwordTextfield.text]) {
        if (![self.passwordTextfield.text isEqualToString:self.passwordConfirmTextfield.text]) {
            [self showMessage:@"两次输入的密码不一致"];
            return NO;
        } else {
            return YES;
        }
    } else {
        [self showMessage:@"请输入6-20位的字母或者数字"];
        return NO;
    }

}

- (IBAction)loginBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)touchScreen:(id)sender {
    for (UIView *view1 in self.view.subviews) {
        if ([view1 isKindOfClass:[UITextField class]]) {
            [(UITextField *) view1 resignFirstResponder];
        }
    }
}

#pragma mark - custom method
- (void)showMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    [hud hide:YES afterDelay:1.5f];
}

- (BOOL)checkEmailValid {
    NSString    *regex     = RE_EMAIL;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self.emailTextfield.text];
}



#pragma mark - models
-(void)registerHandler {
    NSString *username = self.usernameTextfield.text;
    NSString *email = self.emailTextfield.text;
    NSString *password = self.passwordTextfield.text;
    [[MRApiClient sharedClient] RegisterWithUserName:username AndEmail:email
                                         AndPassword:password WithBlock:nil];
    [self dismissViewControllerAnimated:YES completion:nil];

}



#pragma mark - textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [UIView animateWithDuration:0.5f animations:^{
         self.view.frame = CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height);
     }
                     completion:^(BOOL finished) {
                         textField.resignFirstResponder;
                     }];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //todo:offset control
    self.scrollviewCtrl.contentOffset = CGPointMake(0, -32);
    CGFloat yOffset = 174;
    [UIView animateWithDuration:0.5f animations:^{
         self.view.frame = CGRectMake(0, -yOffset, self.view.bounds.size.width, self.view.bounds.size.height);
     }
                     completion:^(BOOL finished) {
                         textField.becomeFirstResponder;
                     }];

}

@end
