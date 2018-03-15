//
//  AFHTTPSessionManager+Synchronous.m
//  TTAdvertiseView
//
//  Created by alex on 17/4/10.
//  Copyright © 2017年 alex. All rights reserved.
//

#import "AFHTTPSessionManager+Synchronous.h"

@interface AFHTTPSessionManager (Private)
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end

@implementation AFHTTPSessionManager (Synchronous)

- (id)synchronouslyPerformMethod:(NSString *)method
                       URLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                            task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
                           error:(NSError *__autoreleasing *)outError
{

    if ([NSThread isMainThread])
    {
        if (self.completionQueue == nil || self.completionQueue == dispatch_get_main_queue())
        {
            @throw
            [NSException exceptionWithName:NSInvalidArgumentException
                                    reason:@"Can't make a synchronous request on the same queue as the completion handler"
                                  userInfo:nil];
        }
    }
    
    __block id responseObjcet = nil;
    __block NSError *error = nil;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURLSessionDataTask *task = [self dataTaskWithHTTPMethod:method
                                                    URLString:URLString
                                                   parameters:parameters
                                               uploadProgress:nil
                                             downloadProgress:nil
                                                      success:^(NSURLSessionDataTask *unusedTask, id resp) {
                                                          responseObjcet = resp;
                                                          dispatch_semaphore_signal(semaphore);
                                                      } failure:^(NSURLSessionDataTask *unusedTask, NSError *err) {
                                                          error = err;
                                                          dispatch_semaphore_signal(semaphore);
                                                      }];
    [task resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    if (taskPtr != nil) *taskPtr = task;
    if (outError != nil) *outError = error;

    return responseObjcet;
}

- (id)syncGET:(NSString *)URLString
   parameters:(NSDictionary *)parameters
         task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
        error:(NSError *__autoreleasing *)outError
{
    return [self synchronouslyPerformMethod:@"GET"
                                  URLString:URLString
                                 parameters:parameters
                                       task:taskPtr
                                      error:outError];
}

- (id)syncPOST:(NSString *)URLString
    parameters:(NSDictionary *)parameters
          task:(NSURLSessionDataTask *__autoreleasing *)taskPtr
         error:(NSError *__autoreleasing *)outError
{
    return [self synchronouslyPerformMethod:@"POST"
                                  URLString:URLString
                                 parameters:parameters
                                       task:taskPtr
                                      error:outError];
}


@end
