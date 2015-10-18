//
// Created by 凌空 on 15/10/11.
// Copyright (c) 2015 fharmony. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - API
#define URL_DOMAIN @"moran.chinacloudapp.cn"
#define URL_BASEREQUEST @"http://moran.chinacloudapp.cn/moran/web"
#define URL_REGISTER @"/user/register"
#define URL_LOGIN @"/user/login"
#define URL_USERS @"/users"
#define URL_UPLOAD_AVATAR @"/user/avatar"
#define URL_RENAME @"/user/rename"
#define URL_SHOW_AVATAR @"/user/show"
#define URL_COMMENT @"/comment"
#define URL_VIEW_COMMENT @"/comment/view"
#define URL_CREATE_COMMENT @"/comment/create"
#define URL_UPDATE_COMMENT @"/comment/update"
#define URL_DELETE_COMMENT @"/comment/delete"
#define URL_GEO_LIST @"/node/list"
#define URL_UPLOAD_PIC @"/picture/create"
#define URL_READ_PIC @"/picture/read"

#pragma mark - Regex
#define RE_EMAIL @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define RE_CELLPHONE_S @"1[0-9]{10}"
#define RE_PASSWORD @"^[a-zA-Z0-9]{6,20}+$"

#pragma mark - Const Value
#define GBID @"GeekBand-I150030"
#define KEY_KEYCHAIN_SERVICE @"com.bombuu"

#pragma mark - macro

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#pragma mark - color

#define COLOR_MAIN_FOREGROUND 0xEF8042
//text color
#define COLOR_MAIN_WHITE 0xFFFFFF


@interface MyConst : NSObject

#pragma mark - custom method
+ (NSString *)returnFullRequsetURL:(NSString *)segment;
@end