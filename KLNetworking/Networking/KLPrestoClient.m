//
//  KLPrestoClient.m
//  DDFlower_iOS
//
//  Created by user on 16/11/17.
//  Copyright © 2016年 user. All rights reserved.
//

#import "KLPrestoClient.h"
#import "KLHttpClient.h"


@interface KLPrestoClient()

@end

@implementation KLPrestoClient
static KLPrestoClient *instance;

+ (instancetype)prestoClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] init];
    });
    return instance;
}

#pragma mark - cancel all network operation

- (void)cancelAllOperation{
    [[KLHttpClient shareClient] cancelOperations];
}

@end
