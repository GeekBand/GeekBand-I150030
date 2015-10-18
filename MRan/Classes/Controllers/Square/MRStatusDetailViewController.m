//
// Created by 凌空 on 15/10/18.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRStatusDetailViewController.h"
#import "MRStatus.h"
#import "UIImageView+WebCache.h"

@interface MRStatusDetailViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollviewOutlet;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation MRStatusDetailViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusLabel.text = self.status.addr;
    self.locationLabel.text = [NSString stringWithFormat:@"距离您有%.1f米", [self.status.distanceInMeters doubleValue]];
    self.scrollviewOutlet.contentSize = CGSizeMake(self.status.picData.count * [UIScreen mainScreen].bounds.size.width,
                                                   212);
    for (int i = 0; i < self.status.picData.count; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:self.status.picData[(NSUInteger) i][@"pic_link"]];
        imageView.frame = CGRectMake(i * [UIScreen mainScreen].bounds.size.width, 0,
                                     [UIScreen mainScreen].bounds.size.width, 212);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollviewOutlet addSubview:imageView];

    }
    self.avatarImageView.image = [UIImage imageNamed:@"headimage"];
    self.usernameLabel.text = @"the Name";
    UIAlertView *alertView = [[UIAlertView alloc]
                                           initWithTitle:@"大部分人没有上传头像,或传了本地头像,还是不弄了,会报错" message:nil
                                                delegate:self
                                       cancelButtonTitle:nil
                                       otherButtonTitles:@"确定",nil];
    [alertView show];

}
@end