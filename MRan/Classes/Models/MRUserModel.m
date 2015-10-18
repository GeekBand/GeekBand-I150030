//
// Created by 凌空 on 15/10/11.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import "MRUserModel.h"
#import "MRApiClient.h"
#import "MJExtension.h"
#import "SSKeychain.h"
#import "MBProgressHUD.h"

@implementation MRUserModel {

}

+(instancetype)instance

{
    static MRUserModel *_sharedUserModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedUserModel = [[self alloc] initPrivate];

    });
    return _sharedUserModel;
}

- (instancetype)initPrivate {
    self  = [super init];

#warning modifier
    self.userid = @"127";
    self.status = @"1";
    self.loginTime = -1;
    self.email = @"bombuu@163.com";
    self.token = @"ebb411f25d66de471993bd29efa180a4e5db0f7d";
    self.username = @"dkjfdsl";
    self.loginReturnMessage = @"no message";
    self.registerReturnMessage = @"no message";
    return self;
}

+ (AFHTTPRequestOperation *)registerWithData:(NSDictionary *)param success:(void(^)(MRUserModel *user))success fail:(void(^)(NSError *requestError))failed {
    NSString *requestURL = [URL_BASEREQUEST stringByAppendingString:URL_REGISTER];
    return [[MRApiClient sharedClient] POST:requestURL parameters:param
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {

                                        MRUserModel *userModel = [MRUserModel objectWithKeyValues:responseObject];
                                        success(userModel);
                                    }
                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                                        failed(error);

                                    }];

}


+ (AFHTTPRequestOperation *)loginWithData:(NSDictionary *)param success:(void (^)(MRUserModel *user))success
                                     fail:(void (^)(NSError *requestError))failed {
    NSString *requestURL = [URL_BASEREQUEST stringByAppendingString:URL_LOGIN];

    return [[MRApiClient sharedClient] POST:requestURL parameters:param
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        NSLog(@"%@", responseObject);
                                        //todo:User Model state Needed
                                        MRUserModel *userModel = [MRUserModel objectWithKeyValues:responseObject];
                                        success(userModel);
                                    }
                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"%@",error);

                                    }];
}

+ (void)getAccountInfo {

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString       *username     = [userDefaults valueForKey:@"KEY_USER_NAME"];
    NSString *userid = [userDefaults valueForKey:@"user_id"];
    NSString *token = [SSKeychain passwordForService:KEY_KEYCHAIN_SERVICE account:userid];
    [MRUserModel instance].token = token;
    [MRUserModel instance].userid = userid;
    [MRUserModel instance].username = username;

}

+ (void)saveAccountInfo:(MRUserModel *)userModel {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:userModel.username forKey:@"username"];
    [userDefaults setValue:userModel.lastLoginTime forKey:@"last_login_time"];
    [userDefaults setValue:userModel.userid forKey:@"user_id"];
    [userDefaults setValue:userModel.projectId forKey:@"project_id"];
    [SSKeychain setPassword:userModel.token forService:KEY_KEYCHAIN_SERVICE
                    account:userModel.userid];
    [userDefaults synchronize];

}


+ (void)deleteAccountInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    SSKeychainQuery *query = [[SSKeychainQuery alloc] init];
    NSArray *accounts = [query fetchAll:nil];
    for (id account in accounts) {
        SSKeychainQuery *singleQuery = [[SSKeychainQuery alloc] init];
        SSKeychainQuery *tokenQuery = [[SSKeychainQuery alloc] init];
        singleQuery.account = [account valueForKey:[userDefaults valueForKey:@"username"]];
        singleQuery.service = KEY_KEYCHAIN_SERVICE;

        tokenQuery.account = [account valueForKey:[userDefaults valueForKey:@"userid"]];
        tokenQuery.service = KEY_KEYCHAIN_SERVICE;
        [singleQuery deleteItem:nil];
        [tokenQuery deleteItem:nil];
    }
    [userDefaults removeObjectForKey:@"username"];
    [userDefaults removeObjectForKey:@"userid"];


    [userDefaults synchronize];
}

+ (void)logout {
    //todo: logout key - value remove
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"username"];
    [userDefaults synchronize];
}

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
            @"userid":@"data.user_id",
            @"username":@"data.user_name",
            @"token":@"data.token",
            @"avatar":@"data.avatar",
            @"projectId":@"data.project_id",
            @"lastLoginTime":@"last_login",
            @"loginTime":@"login_times",
            @"loginReturnMessage":@"message",
            @"registerReturnMessage":@"message"
    };
}


@end