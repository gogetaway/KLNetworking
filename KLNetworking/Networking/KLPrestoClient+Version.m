









//
//  KLPrestoClient+Version.m
//  KLNetworking
//
//  Created by user on 17/7/21.
//  Copyright © 2017年 user. All rights reserved.
//

#import "KLPrestoClient+Version.h"
#import "JVersionInfoModel.h"
@implementation KLPrestoClient (Version)

- (void)getVersionVersionSuccess:(void (^)(id))success failure:(void (^)(id))error
{

    [[KLHttpClient shareClient]postUrl:@"/version/newVersion" params:@{@"version":@"222"} class:[JVersionInfoModel class] completion:^(id model) {
        success(model);
    } error:^(NSError *error) {
        
    }];
    
}

@end
