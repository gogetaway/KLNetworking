//
//  JVersionInfoModel.m
//  J1000
//
//  Created by luming on 2017/2/8.
//  Copyright © 2017年 user. All rights reserved.
//

#import "JVersionInfoModel.h"

@implementation JVersionInfoModel
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"downloadUrl":@"data.ios.downloadUrl",
             @"versionName":@"data.ios.versionName",
             @"versionCode":@"data.ios.versionCode",
             @"appSize":@"data.ios.appSize",
             @"enumCode":@"data.ios.enumCode",
             @"desc":@"data.ios.description",
             @"isOpen":@"data.ios.isOpen"
             };
}


@end
