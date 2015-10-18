//
//  MRMineViewController.m
//  MRan
//
//  Created by 凌空 on 15/10/17.
//  Copyright (c) 2015 fharmony. All rights reserved.
//
#import "MRMineViewController.h"
#import "MRWebsiteViewController.h"
#import "MRUserModel.h"
#import "MRApiClient.h"
#import "MRApiClient+Requset.h"
#import <CoreLocation/CoreLocation.h>
#define WEBSITEURL @"http://www.163.com"
#define ITUNESURL @"https://itunes.apple.com/app/apple-store/id375380948?mt=8"
#define WEIBOURL @"http://weibo.com/"

@interface MRMineViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)changeAvatar:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *avatarImgOutlet;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@end
@implementation MRMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.scrollEnabled = NO;
    self.tableview.backgroundColor = [UIColor whiteColor];
    [self setupBasicInfo];
//    self.navigationController.tabBarController

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)setupBasicInfo {
    if ([MRUserModel instance].username) {
        self.emailLabel.text = [MRUserModel instance].email;
        self.nickNameLabel.text = [MRUserModel instance].username;

    } else {
        self.emailLabel.text = @"请先登录";
        self.nickNameLabel.text = @"请先登录";

    }
    [self getAvatar];

}

- (void)getAvatar {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [documentPath stringByAppendingPathComponent:@"Avatar.png"];
    if ([manager fileExistsAtPath:path]) {
        [self.avatarImgOutlet setImage:[[UIImage imageWithContentsOfFile:path]
                 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              forState:UIControlStateNormal];


    } else {
        [self.avatarImgOutlet setImage:[UIImage imageNamed:@"headimage@2x.png"] forState:UIControlStateNormal];

    }
    self.avatarImgOutlet.clipsToBounds = YES;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]
                                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text  = @"修改昵称";
                    cell.imageView.image = [UIImage imageNamed:@"nickname"];
                    break;
                }
                case 1: {
                    cell.textLabel.text = @"设置头像";
                    cell.imageView.image = [UIImage imageNamed:@"headimage"];
                    break;
                }
                case 2: {
                    cell.textLabel.text = @"注销登录";
                    cell.imageView.image = [UIImage imageNamed:@"signout"];
                    break;
                }
                default:
                    break;
            }
        } else {
            switch (indexPath.row) {
                case 0: {
                    cell.textLabel.text = @"评价我们";
                    cell.imageView.image = [UIImage imageNamed:@"rate"];
                    break;
                }
                case 1: {
                    cell.textLabel.text = @"关注我们";
                    cell.imageView.image = [UIImage imageNamed:@"followus"];
                    break;
                }
                case 2: {
                    cell.textLabel.text = @"官方网站";
                    cell.imageView.image = [UIImage imageNamed:@"homepage"];
                    break;
                }
                default:
                    break;


            }
        }
    }
    return cell;

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                [self modifynickname];
                break;
            }
            case 1: {
                [self setAvatar];
                break;
            }
            case 2: {
                [self logout];
                break;
            }
            default: {
                break;
            }
        }
    } else {
        switch (indexPath.row) {
            case 0: {
                [self comment];
                break;
            }
            case 1: {
                [self followus];
                break;
            }
            case 2: {
                [self redirectWebsite];
                break;
            }
            default: {
                break;
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)redirectWebsite {
    NSString *url = WEBSITEURL;
    MRWebsiteViewController *websiteViewController = [[MRWebsiteViewController alloc] init];
    websiteViewController.urlstr = url;
    [self.navigationController pushViewController:websiteViewController animated:YES];
}

- (void)followus {
    NSString *url = WEIBOURL;
    MRWebsiteViewController *websiteViewController = [[MRWebsiteViewController alloc] init];
    websiteViewController.urlstr = url;
    [self.navigationController pushViewController:websiteViewController animated:YES];
//    [self.navigationController presentViewController:websiteViewController
//                                            animated:YES
//                                          completion:nil];


}

- (void)comment {
    NSString *url = ITUNESURL;
    MRWebsiteViewController *websiteViewController = [[MRWebsiteViewController alloc] init];
    websiteViewController.urlstr = url;
    [self.navigationController pushViewController:websiteViewController animated:YES];

}

- (void)logout {
    [MRUserModel logout];
}

- (void)setAvatar {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerController.delegate = self;
        pickerController.allowsEditing = YES;
        [self presentViewController:pickerController animated:YES
                         completion:nil];
    }

}

- (void)modifynickname {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入您的昵称"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:nil];

    UIAlertAction *cancelAcn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                      handler:nil];
    UIAlertAction *confirmAcn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        [[MRApiClient sharedClient]
                                                                      modifyNicknameWithNickName:alertController.textFields.firstObject.text
                                                                                       WithBlock:^(id o) {
                                                                                           self.nickNameLabel
                                                                                               .text = alertController
                                                                                                   .textFields
                                                                                                   .firstObject.text;
                                                                                       }];
                                                    }];

    [alertController addAction:cancelAcn];
    [alertController addAction:confirmAcn];

    [self presentViewController:alertController
                                            animated:YES
                                          completion:^{

                                          }];
//    [MRApiClient sharedClient]
}

- (IBAction)changeAvatar:(UIButton *)sender {
    [self setAvatar];
}

#pragma mark - imagepicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    // get original image
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    // save image file to document folder with name "Avatar.png"
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [documentPath stringByAppendingPathComponent:@"Avatar.png"];
    [imageData writeToFile:path atomically:NO];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.avatarImgOutlet setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              forState:UIControlStateNormal];
        [[MRApiClient sharedClient] sendAvatarToServer:image WithBlock:^(id o) {
            NSDictionary *dictionary = [o objectForKey:@"data"];
            [MRUserModel instance].avatar = dictionary[@"avatar"];
        }];

    }];
}
@end
