//
//  KLHttpClient.h
//  DDFlower_iOS
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
//#import "AFHTTPRequestOperation"
#import <UIKit/UIKit.h>
@class KLHttpClient;

@protocol KLHttpClientDelegate<NSObject>

@optional
- (void)httpClient:(KLHttpClient *)client statusChanged:(AFNetworkReachabilityStatus) status;
- (BOOL)httpClient:(KLHttpClient *)client filterResponse:(NSDictionary *)dic error:(NSError *)error;
- (BOOL)httpClient:(KLHttpClient *)client filterRetryFailureSessionManager:(AFHTTPSessionManager *)sessionManager error:(NSError *)error;

@end
@interface KLHttpClient : NSObject
@property (nonatomic, weak) id <KLHttpClientDelegate>delegate;

+ (instancetype)shareClient;
- (void)cancelOperations;
- (void)getUrl:(NSString *) url;
- (void)getUrl:(NSString *) url class:(Class)classVc completion:(void(^)(id)) completion;
- (void)getUrl:(NSString *) url params:(NSDictionary *)params class:(Class)classVc completion:(void(^)(id)) completion;
- (void)getUrl:(NSString *)url params:(NSDictionary *)params class:(Class )vclass completion : (void (^)(id))completion  error : (void (^)(NSError *))failure;




// post
- (void)postUrl:(NSString *) url;
- (void)postUrl:(NSString *) url completion:(void(^)(id)) completion;
- (void)postUrl:(NSString *) url class:(Class)classVc completion:(void(^)(id)) completion;
- (void)postUrl:(NSString *) url params:(NSDictionary *)params class:(Class)classVc completion:(void(^)(id)) completion;
- (void)postUrl:(NSString *)url params:(NSDictionary *)params class:(Class )vclass completion : (void (^)(id))completion error : (void (^)(NSError *))failure;
- (void)postUrl:(NSString *)url params:(NSDictionary *)params class:(Class )vclass completion : (void (^)(id))completion exceptions:(void (^)(id))exceptions error : (void (^)(NSError *))failure;


@end
