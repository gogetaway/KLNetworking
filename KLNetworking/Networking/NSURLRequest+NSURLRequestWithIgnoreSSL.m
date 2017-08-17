//
//  NSURLRequest+NSURLRequestWithIgnoreSSL.h
//  DDCash
//
//  Created by Ash on 16/8/26.
//  Copyright © 2016年 Ash. All rights reserved.

//用于OC中跳过安全认证，请求https形式地址

#import "NSURLRequest+NSURLRequestWithIgnoreSSL.h"

@implementation NSURLRequest (NSURLRequestWithIgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

@end
