//
//  KLHttpClient+FailureHandler.m
//  DDFlower_iOS
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 user. All rights reserved.
//

#import "KLHttpClient+FailureHandler.h"
#import <objc/runtime.h>

static const void *kFailureQueue = &kFailureQueue;


@implementation KLHttpClient (FailureHandler)

- (void)addFailureObserver
{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(networkStatusChanged:)
                                                name:AFNetworkingReachabilityDidChangeNotification
                                              object:nil];
}



- (void)setFailureQueue:(NSMutableSet *)failureQueue
{
    objc_setAssociatedObject(self, kFailureQueue, failureQueue, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableSet *)failureQueue
{
    NSMutableSet *set = objc_getAssociatedObject(self, kFailureQueue);
    if(!set)
    {
        set = [[NSMutableSet alloc]initWithCapacity:1];
        self.failureQueue = set;
    }
    return set;
}

- (void)networkStatusChanged:(NSNotification *)notification
{
    [self.failureQueue enumerateObjectsUsingBlock:^(NSURLSessionDataTask *task, BOOL *stop) {
        [task resume];
    }];
}

@end
