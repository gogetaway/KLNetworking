//
//  KLHttpClient+FailureHandler.h
//  DDFlower_iOS
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 user. All rights reserved.
//

#import "KLHttpClient.h"

@interface KLHttpClient (FailureHandler)

@property (nonatomic, strong) NSMutableSet *failureQueue;
- (void)addFailureObserver;

@end
