//
//  AFHTTPSessionManager+Synchronous.h
//  TTAdvertiseView
//
//  Created by alex on 17/4/10.
//  Copyright © 2017年 alex. All rights reserved.
//  基于AFN 3.0同步网络请求

#import "AFHTTPSessionManager.h"

@interface AFHTTPSessionManager (Synchronous)

- (id)syncGET:(NSString *)URLString
   parameters:(NSDictionary *)parameters
         task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
        error:(NSError *__autoreleasing *)outError;


- (id)syncPOST:(NSString *)URLString
    parameters:(NSDictionary *)parameters
          task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
         error:(NSError *__autoreleasing *)outError;


@end
