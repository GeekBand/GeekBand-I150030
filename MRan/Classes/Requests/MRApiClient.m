//
// Created by 凌空 on 15/10/11.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import "MRApiClient.h"
#import "AFNetworkActivityIndicatorManager.h"


@implementation MRApiClient {

}
+(instancetype)sharedClient
{
    static MRApiClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedClient = [[MRApiClient alloc] initWithBaseURL:[NSURL URLWithString:URL_BASEREQUEST]];
        [sharedClient setSecurityPolicy:[AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey]];
        [[sharedClient reachabilityManager]
                       setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
                           switch (status) {
                               case AFNetworkReachabilityStatusNotReachable: {
                                   NSLog(@"no connect");
                                   break;
                               }
                               case AFNetworkReachabilityStatusReachableViaWiFi: {
                                   NSLog(@"wifi connect");
                                   break;
                               }
                               case AFNetworkReachabilityStatusReachableViaWWAN: {
                                   NSLog(@"wan connect");
                                   break;
                               }
                               default:
                                   break;
                           }
                       }];
        [sharedClient.reachabilityManager startMonitoring];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    });
    return sharedClient;
}



@end