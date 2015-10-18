//
// Created by 凌空 on 15/10/13.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MRSquareViewController.h"
#import "MRUserModel.h"
#import "MRApiClient.h"
#import "MRApiClient+Requset.h"
#import "MJRefresh.h"
#import "MRStatus.h"
#import "PicWithCell.h"
#import "MRPicData.h"
#import "UIImageView+WebCache.h"
#import "MRStatusDetailViewController.h"
#import "MRLoginViewController.h"

@interface MRSquareViewController ()<UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic, strong) CLLocationManager *mgr;
@property(nonatomic, strong) NSArray *dataList;
@end

@implementation MRSquareViewController {

}
-(CLLocationManager *)mgr{
    if (!_mgr) {
        self.mgr = [[CLLocationManager alloc]init];
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    MRLoginViewController *loginViewController = (MRLoginViewController *) [[UIStoryboard storyboardWithName:@"LoginAndRegister"
                                                                                                      bundle:nil]
                                                                                          instantiateViewControllerWithIdentifier:@"MRLoginViewController"];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"token"]) {
        [self presentViewController:loginViewController animated:YES
                         completion:nil];
    }


    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined) {
        [self.mgr requestAlwaysAuthorization];
    }

    [self setupGeoAuth];

    [self.tableView registerNib:[UINib nibWithNibName:@"PicWithCell" bundle:nil]
         forCellReuseIdentifier:@"PicContainCell"];
//    [self.tableView registerClass:[PicWithCell class] forCellReuseIdentifier:@"PicContainCell"];
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"refresh!");
        self.tableView.footer.hidden = YES;
    }];

    UIButton *takePic = [UIButton buttonWithType:UIButtonTypeCustom];
    [takePic setImage:[[UIImage imageNamed:@"publish"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    takePic.frame = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5f -22, [UIScreen mainScreen].bounds.size.height-64, 45, 45);

    [self.navigationController.tabBarController.view addSubview:takePic];
    [takePic addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];

}

- (void)takePhoto {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerController.delegate = self;
        pickerController.allowsEditing = YES;
        [self presentViewController:pickerController animated:YES
                         completion:nil];

    } else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                               initWithTitle:@"请安装照相机" message:nil delegate:self
                                           cancelButtonTitle:nil
                                           otherButtonTitles:@"确定", nil];

        [alertView show];

    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)setupGeoAuth {
    self.mgr.delegate        = self;
    self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
    self.mgr.distanceFilter  = 10;
    self.mgr.distanceFilter = 1000;
    [self.mgr startUpdatingLocation];
}

// press add button to send image
- (void)addImageToSend {

}


#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 184;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"PicContainCell";
    PicWithCell *cell = (PicWithCell *) [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PicWithCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];


    }
    MRStatus *status = self.dataList[(NSUInteger) indexPath.row];
    cell.locationTitle.text = status.addr;
    cell.distanceDisplay.text = [NSString stringWithFormat:@"%.1f 米",status.distanceInMeters.doubleValue];
    NSMutableArray *picDataList = [NSMutableArray array];
    for (int i = 0; i < status.picData.count; ++i) {
        [picDataList addObject:status.picData[(NSUInteger) i][@"pic_link"]];
    }
    cell.scrollviewOutlet.contentSize = CGSizeMake(picDataList.count * 168, 120);
    for (int j = 0; j < picDataList.count; ++j) {
        UIImageView *imageView = [[UIImageView alloc] init];

        [imageView sd_setImageWithURL:[NSURL URLWithString:picDataList[(NSUInteger) j]]];
        imageView.frame = CGRectMake( 168 * j,20, 160, 120);
        [cell.scrollviewOutlet addSubview:imageView];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MRStatusDetailViewController *detailViewController = (MRStatusDetailViewController *) [[UIStoryboard storyboardWithName:@"MRStatusDetail"
                                                                                                                     bundle:nil]
                                                                                                         instantiateInitialViewController];
    detailViewController.status = self.dataList[(NSUInteger) indexPath.row];;
    [self.navigationController pushViewController:detailViewController animated:YES];

}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.lastObject;
    [[MRApiClient sharedClient]
                  getImagesFromServerInLocation:location AndDistance:@"1000"
                                      WithBlock:^(NSArray *statusArray) {
                                          self.dataList = statusArray;
                                          [self.tableView reloadData];
                                      }];

}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (error.code == kCLErrorDenied) {
        NSLog(@"deny");
    }
    if (error.code == kCLErrorLocationUnknown) {
        NSLog(@"unknown");
    }
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager startUpdatingLocation];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mgr stopUpdatingLocation];
}



@end