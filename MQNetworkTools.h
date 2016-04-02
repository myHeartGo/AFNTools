//
//  MQNetworkTools.h
//  OCAFN封装
//
//  Created by MQ on 15/12/28.
//  Copyright © 2015年 maoqiang. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


/// 请求方式
typedef NS_ENUM(NSUInteger, MQRequestMethod) {
    /// get
    MQRequestMethodGET,
    /// post
    MQRequestMethodPOST
};

@interface MQNetworkTools : AFHTTPSessionManager

// 全局访问点
+ (instancetype)sharedTools;

/// 向外界提供的请求的方法
///
/// @param urlString  请求地址
/// @param parameters 请求参数
/// @param finished   请求完毕之后的回调
- (void)request:(MQRequestMethod)method urlString:(NSString *)urlString parameters:(id)parameters finished:(void(^)(id responseObject, NSError *error))finished;


@end
