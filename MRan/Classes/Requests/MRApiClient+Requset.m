//
// Created by 凌空 on 15/10/17.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "MRApiClient+Requset.h"
#import "MyConst.h"
#import "MRUserModel.h"
#import "MRStatus.h"
@implementation MRApiClient (Requset)

//比如提交的表单数 据为,username=testProject3,password=testProject3,
//         提交方式:POST。提交参数:username,password与email,以及gbid。
//gbid=GeekBand-I150003,
- (void)RegisterWithUserName:(NSString *)username AndEmail:(NSString *)email AndPassword:(NSString *)password
                   WithBlock:(void (^)(id))completion {
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSString *url = [MyConst returnFullRequsetURL:@"/user/login"];
    NSDictionary *param = @{
            @"username":username,
            @"password":password,
            @"gbid":GBID,
            @"email":email
    };

    [mgr POST:url parameters:param
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          MRUserModel *userModel = [MRUserModel objectWithKeyValues:responseObject];
          NSLog(@"username = %@ , userid = %@ , project_id = %@", userModel.username,userModel.userid,userModel.projectId);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"bad regiter request in mran%@",error);
      }];
}

- (void)LoginWithEmail:(NSString *)email AndPassword:(NSString *)password WithBlock:(void(^)(id))completion{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSString *url = [MyConst returnFullRequsetURL:@"/user/login"];
    NSDictionary *param = @{
            @"email": email,
            @"password":password,
            @"gbid":GBID
    };

    [mgr POST:url parameters:param
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          MRUserModel *userModel = [MRUserModel objectWithKeyValues:responseObject];
          NSLog(@"username = %@ , userid = %@ , project_id = %@", userModel.username,userModel.userid,userModel.projectId);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"bad regiter request in mran%@",error);
      }];


}

- (void)modifyNicknameWithNickName:(NSString *)nickname WithBlock:(void(^)(id))completion{
//    /user/rename
    NSString *url = [MyConst returnFullRequsetURL:@"/user/rename"];
//    POST提交。传递参数：user_id，token，new_name
    NSDictionary *param = @{
            @"user_id": [MRUserModel instance].userid,
            @"token":[MRUserModel instance].token,
            @"new_name":nickname
    };
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:url parameters:param
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          MRUserModel *userModel = [MRUserModel objectWithKeyValues:responseObject];
          completion(userModel);
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          NSLog(@"%@", error.localizedDescription);

      }];
}


- (void)sendAvatarToServer:(UIImage *)image WithBlock:(void(^)(id))completion{
//    /user/avatar
//    POST提交。传递参数:user_id,token,data(图片文件)。
    NSString *url = [MyConst returnFullRequsetURL:@"/user/avatar"];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSData *data = UIImagePNGRepresentation(image);
    NSDictionary *param = @{
        @"user_id":[MRUserModel instance].userid,
            @"token": [MRUserModel instance].token,
    };
    [mgr             POST:url parameters:param
constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
    [formData appendPartWithFileData:data name:@"Avatar" fileName:@"Avatar.png"
                            mimeType:@"image/png"];
}
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      completion(responseObject);
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"%@", error.localizedDescription);
                  }];


}

///node/list GET提交。参数user_id,token,longitude,latitude,distance。
//返回地理位置的列表,以及 各自的图片url列表。按距离排序。

- (void)getImagesFromServerInLocation:(CLLocation *)location AndDistance:(NSString *)distance
                            WithBlock:(void (^)(NSArray *statusArray))completion {
    NSDictionary *param = @{

            @"token": [MRUserModel instance].token,
            @"distance": distance,
            @"latitude": [NSString stringWithFormat:@"%f",location.coordinate.latitude],
            @"longitude": [NSString stringWithFormat:@"%f",location.coordinate.longitude],
            @"user_id" : [MRUserModel instance].userid

    };
    NSString *url = [MyConst returnFullRequsetURL:@"/node/list"];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:url parameters:param
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSLog(@"%@", statusArray);
//         MRStatus *status = [MRStatus objectWithKeyValues:@"data"];
//         NSLog(@"%@", statusArray);
         NSDictionary *datas = responseObject[@"data"];
//         NSLog(@"%@", datas);
         NSArray *statusArray = [MRStatus objectArrayWithKeyValuesArray:datas.allValues];
         completion(statusArray);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"failed%@",error);
     }];

}

-(NSDictionary *)getOtherUserInfoByUserid:(NSString *)userId WithBlock:(void(^)(id))completion{
//    /users/
    NSString *url = [MyConst returnFullRequsetURL:@"/users/"];
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSDictionary *param = @{
            @"user_id":userId
    };
    [mgr GET:url parameters:param
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         completion(responseObject);
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@", error.localizedDescription);

     }];
    return nil;
}
@end