//
//  KLHttpClient.m
//  DDFlower_iOS
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 user. All rights reserved.
//

#import "KLHttpClient.h"
#import <AFNetworkActivityIndicatorManager.h>
#import "KLHttpClient+FailureHandler.h"
#import <YYModel.h>
#import <AFHTTPSessionManager.h>
#import "BaseModel.h"


#define JHostURL @"https://api.creditflower.cn"
#define JHostAPI @"/app"

NSString *NetworkReachabilityStatusChangedNotification = @"com.mahttpclient.network.reachability.changed";

@interface KLHttpClient ()

@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *api;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation KLHttpClient
static KLHttpClient *instance;

- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        
        _manager = [[AFHTTPSessionManager alloc] init];
        [_manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        [_manager.requestSerializer setTimeoutInterval:60.f];
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer=[AFJSONRequestSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
        [self addFailureObserver];
        [self setReachableMonitorOn:YES];

        [self setActivityIndicatorVisible:YES];

        
        // 2.设置非校验证书模式
//        _manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        _manager.securityPolicy.allowInvalidCertificates = YES;
//        [_manager.securityPolicy setValidatesDomainName:NO];
        
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
//        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
//        NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
//        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//        // 是否允许,NO-- 不允许无效的证书
//        [securityPolicy setAllowInvalidCertificates:YES];
//        // 设置证书
//        [securityPolicy setPinnedCertificates:certSet];
//        _manager.securityPolicy = securityPolicy;


    }
    return _manager;
}


- (NSString *)baseUrl {
    if (!_baseUrl) {
        _baseUrl = [NSString stringWithFormat:@"%@%@", self.host, self.api];
    }
    return _baseUrl;
}

- (NSString *)api {
    if (!_api) {
        _api = JHostAPI;
    }
    return _api;
}

- (NSString *)host {
    if (!_host) {
        _host = JHostURL;
    }
    return _host;
}

+ (NSString *)hostUrl {
    return [NSString stringWithFormat:@"%@%@", JHostURL,JHostAPI ];
}

- (void)reset {
    self.baseUrl = [NSString stringWithFormat:@"%@%@", JHostURL, JHostAPI];
}
- (void)setAPI:(NSString *)api {
    self.baseUrl = [NSString stringWithFormat:@"%@%@", self.host, api];
}
- (void)setHostUrl:(NSString *)url {
    self.baseUrl = [NSString stringWithFormat:@"%@%@", url, self.api];
}


+ (instancetype)shareClient {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (void)cancelOperations {
    [self.manager.operationQueue cancelAllOperations];
        for (NSURLSessionTask *task in self.manager.tasks)
        {
            [task cancel];
        }
}
- (void)setReachableMonitorOn:(BOOL)isOn {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    if (isOn) {
        [manager startMonitoring];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:NetworkReachabilityStatusChangedNotification
                                                               object:@(status)];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(httpClient:statusChanged:)]) {
                [self.delegate httpClient:self statusChanged:status];
            }
        }];
    } else {
        [manager stopMonitoring];
    }
}

#pragma mark - private
- (NSString *)assembledUrl:(NSString *)urlStr {
    NSURL *url = [NSURL URLWithString:urlStr];
    if (url.host && url.scheme)
        return urlStr;
    else
        return [NSString stringWithFormat:@"%@%@", self.baseUrl, url];
}

- (void)setActivityIndicatorVisible:(BOOL)visible {
    AFNetworkActivityIndicatorManager *manager = [AFNetworkActivityIndicatorManager sharedManager];
    [manager setEnabled:visible];
}

- (void)getUrl:(NSString *)url {
    [self getUrl:url class:nil completion:nil];
}

- (void)getUrl:(NSString *)url class:(Class)classVc completion:(void (^)(id))completion {
    [self getUrl:url params:nil class:classVc completion:completion];
}

- (void)getUrl:(NSString *)url params:(NSDictionary *)params class:(Class)classVc completion:(void (^)(id))completion {
    [self getUrl:url params:params class:classVc completion:completion error:nil];
}

- (void)getUrl:(NSString *)url params:(NSDictionary *)params class:(Class )class completion : (void (^)(id))completion  error : (void (^)(NSError *))failure{
    NSString *getUrl = [self assembledUrl:url];
    [self.manager GET:getUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self success:task reponseObject:responseObject class:class completion:completion exceptions:nil error:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)postUrl:(NSString *)url {
    [self postUrl:url completion:nil];
}

- (void)postUrl:(NSString *)url completion:(void (^)(id))completion {
    [self postUrl:url class:nil completion:completion];
}

- (void)postUrl:(NSString *)url class:(Class)classVc completion:(void (^)(id))completion {
    [self postUrl:url params:nil class:classVc completion:completion error:nil];
}

- (void)postUrl:(NSString *)url params:(NSDictionary *)params class:(Class)classVc completion:(void (^)(id))completion {
    [self postUrl:url params:params class:classVc completion:completion error:nil];
}

- (void)postUrl:(NSString *)url params:(NSDictionary *)params class:(Class )class completion :(void (^)(id))completion error : (void (^)(NSError *))failure
{
    [self postUrl:url params:params class:class completion:completion exceptions:nil error:failure];
    
}
- (void)postUrl:(NSString *)url params:(NSDictionary *)params class:(Class )class completion : (void (^)(id))completion exceptions:(void (^)(id))exceptions error : (void (^)(NSError *))failure
{
    NSString *getUrl = [self assembledUrl:url];
    [self.manager POST:getUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self success:task reponseObject:responseObject class:class completion:completion exceptions:exceptions error:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failure:task httpError:error class:class completion:completion error:failure];
    }];
}

- (void)success : (NSURLSessionDataTask *)task reponseObject : (id)responseObject class : (Class) class completion : (void (^)(id))completion exceptions:(void (^)(id))exceptions error : (void (^)(NSError *))error {
    
    NSDictionary *dic =responseObject;
    if (!exceptions&&self.delegate && [self.delegate respondsToSelector:@selector(httpClient:filterResponse:error:)])
    {
        if ([self.delegate httpClient:self filterResponse:dic error:nil]) {
            return;
        }
    }
    BaseModel *model = [class yy_modelWithJSON:dic];
    if (exceptions&&![model.status isEqualToString:@"0000"]) {
        exceptions(model);
    }
    completion(model);
}

- (void)failure : (NSURLSessionDataTask *)task httpError: (NSError *)httpError class : (Class) class completion : (void (^)(id))completion error : (void (^)(NSError *))failre {

    
    if (failre)
    {
        failre(nil);
    }
    if (httpError.code == NSURLErrorNotConnectedToInternet)
    {
        
      //  [self.failureQueue addObject:task];
        return;
    }
//
    
     [self.failureQueue addObject:task];

    [self resetNetworkActivityIndicator];
    

}


- (void)resetNetworkActivityIndicator {
    [[AFNetworkActivityIndicatorManager sharedManager] setValue:@0 forKey:@"activityCount"];
}

@end
