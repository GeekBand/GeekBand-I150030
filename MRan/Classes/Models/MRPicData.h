//
// Created by 凌空 on 15/10/18.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MRPicData : NSObject
@property(nonatomic, copy) NSString *picId;
@property(nonatomic, copy) NSString *nodeId;
@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *picLink;

- (NSString *)description;

//
//{
//    "node_id" = 52;
//    "pic_id" = 499;
//    "pic_link" = "http://moran.chinacloudapp.cn/moran/web/picture/read?pic_id=499";
//    title = "";
//    "user_id" = 0;
//}
@end