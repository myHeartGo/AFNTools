//
//  MQNetworkTools.m
//  OCAFN封装
//
//  Created by MQ on 15/12/28.
//  Copyright © 2015年 maoqiang. All rights reserved.
//

#import "MQNetworkTools.h"


@protocol MQNetworkToolsDelegate <NSObject>

@optional
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;

@end

@interface MQNetworkTools()<MQNetworkToolsDelegate>

@end

@implementation MQNetworkTools

+ (instancetype)sharedTools{
    static MQNetworkTools *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MQNetworkTools manager];
        instance.responseSerializer.acceptableContentTypes = [instance.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    });
    return instance;
}


- (void)request:(MQRequestMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void(^)(id responseObject, NSError *error))finished{
    
    NSString *m = @"POST";
    if (method == MQRequestMethodGET) {
        m = @"GET";
    }
    
    // 定义一个协议，申明一个方法，具体不去实现，在运行的时候向 `self` 发送 dataTaskWithHTTPMethod 这个消息，其身上没有实现这个方法，如果本类没有实现这个方法，本类没有找到，就会父类去找这个方法，而父类是实现过个方法的
    [[self dataTaskWithHTTPMethod:m URLString:urlString parameters:parameters uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *dataTask, id responseObject) {
        finished(responseObject,nil);
    } failure:^(NSURLSessionDataTask *dataTask, NSError *error) {
        finished(nil,error);
    }] resume];
    
//    if (method == MQRequestMethodGET) {
//        // 使用 afn 去请求数据
//        [self GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            finished(responseObject,nil);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            finished(nil,error);
//        }];
//    }else {
//        // 使用 afn 去请求数据
//        [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            finished(responseObject,nil);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            finished(nil,error);
//        }];
//    }
}

@end
