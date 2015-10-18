//
// Created by 凌空 on 15/10/11.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import "MyConst.h"


@implementation MyConst {

}

+ (NSString *)returnFullRequsetURL:(NSString *)segment {
    NSString *baseURL = @"http://moran.chinacloudapp.cn/moran/web";
    return [NSString stringWithFormat:@"%@%@", baseURL, segment];
}
@end