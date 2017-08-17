//
//  KLPrestoClient+Version.h
//  KLNetworking
//
//  Created by user on 17/7/21.
//  Copyright © 2017年 user. All rights reserved.
//

#import "KLPrestoClient.h"

@interface KLPrestoClient (Version)
- (void)getVersionVersionSuccess:(void (^)(id))success failure:(void (^)(id))error;

@end
