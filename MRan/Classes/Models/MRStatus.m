//
// Created by 凌空 on 15/10/18.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import "MRStatus.h"


@implementation MRStatus {

}

//"2": {
//    "node": {
//        "id": "2",
//                "distance_in_meters": "42.40365071651872",
//                "addr": "淮海中路138号上海广场4楼",
//                "ST_AsText(geom)": "POINT(121.47753 31.22501)"
//    },
//    "pic": [
//            {

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
            @"addr" : @"node.addr",
            @"distanceInMeters" : @"node.distance_in_meters",
            @"picData" : @"pic",
            @"userId":@"node.id"
    };
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.addr=%@", self.addr];
    [description appendFormat:@", self.distanceInMeters=%@", self.distanceInMeters];
    [description appendFormat:@", self.picData=%@", self.picData];
    [description appendFormat:@", self.userId=%@", self.userId];
    [description appendString:@">"];
    return description;
}


@end