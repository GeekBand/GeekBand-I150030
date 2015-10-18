//
// Created by 凌空 on 15/10/18.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import "MRPicData.h"


@implementation MRPicData {

}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.picId=%@", self.picId];
    [description appendFormat:@", self.nodeId=%@", self.nodeId];
    [description appendFormat:@", self.userId=%@", self.userId];
    [description appendFormat:@", self.title=%@", self.title];
    [description appendFormat:@", self.picLink=%@", self.picLink];
    [description appendString:@">"];
    return description;
}


- (NSDictionary *)replacedKeyFromPropertyName {
    return @{
            @"nodeId":@"node_id",
            @"picId":@"pic_id",
            @"picLine":@"pic_link",
            @"userId":@"user_id",
            @"title":@"title"
    };
}

@end