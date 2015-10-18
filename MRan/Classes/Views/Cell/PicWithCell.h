//
// Created by 凌空 on 15/10/13.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PicWithCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *scrollviewOutlet;
@property (weak, nonatomic) IBOutlet UILabel *locationTitle;
@property(nonatomic, strong) NSArray *picdataList;
@property (weak, nonatomic) IBOutlet UILabel *distanceDisplay;



@end