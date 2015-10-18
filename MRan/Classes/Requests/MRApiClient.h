//
// Created by 凌空 on 15/10/11.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface MRApiClient : AFHTTPRequestOperationManager
+(instancetype)sharedClient;
@end