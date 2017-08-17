//
//  KLPrestoClient.h
//  DDFlower_iOS
//
//  Created by user on 16/11/17.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLHttpClient.h"
@interface KLPrestoClient : NSObject

+ (instancetype)prestoClient;

- (void)cancelAllOperation;

@end
