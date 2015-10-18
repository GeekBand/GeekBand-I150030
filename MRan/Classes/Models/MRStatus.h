//
// Created by 凌空 on 15/10/18.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MRStatus : NSObject
@property(nonatomic, copy) NSString *addr;
@property(nonatomic, copy) NSNumber *distanceInMeters;
@property(nonatomic, strong) NSArray *picData;
@property(nonatomic, copy) NSString *userId;

- (NSString *)description;

@end