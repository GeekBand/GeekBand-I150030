//
// Created by 凌空 on 15/10/17.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRApiClient.h"
#define GBID @"GeekBand-I150003"
@class CLLocation;
@interface MRApiClient (Requset)


- (void)RegisterWithUserName:(NSString *)username AndEmail:(NSString *)email AndPassword:(NSString *)password
                   WithBlock:(void (^)(id))completion;

- (void)LoginWithEmail:(NSString *)email AndPassword:(NSString *)password WithBlock:(void (^)(id))completion;

- (void)modifyNicknameWithNickName:(NSString *)nickname WithBlock:(void (^)(id))completion;

- (void)sendAvatarToServer:(UIImage *)image WithBlock:(void (^)(id))completion;

- (void)getImagesFromServerInLocation:(CLLocation *)location AndDistance:(NSString *)distance
                            WithBlock:(void (^)(NSArray *statusArray))completion;
@end