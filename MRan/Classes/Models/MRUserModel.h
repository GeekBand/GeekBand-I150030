//
// Created by 凌空 on 15/10/11.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperation;

@interface MRUserModel : NSObject
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *userid;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *token;
@property(nonatomic, copy) NSString *avatar;
@property(nonatomic, copy) NSString *projectId;
@property(nonatomic, copy) NSString *lastLoginTime;
@property(nonatomic, assign) NSInteger loginTime;
@property(nonatomic, copy) NSString *loginReturnMessage;
@property(nonatomic, copy) NSString *registerReturnMessage;





+ (MRUserModel *)instance;
+ (AFHTTPRequestOperation *)loginWithData:(NSDictionary *)param success:(void(^)(MRUserModel *user))success fail:(void(^)(NSError *requestError))failed;
+ (AFHTTPRequestOperation *)registerWithData:(NSDictionary *)param success:(void(^)(MRUserModel *user))success fail:(void(^)(NSError *requestError))failed;

+ (void)getAccountInfo;

+ (void)saveAccountInfo:(MRUserModel *)userModel;
+ (void)deleteAccountInfo;
+ (void)logout;
@end