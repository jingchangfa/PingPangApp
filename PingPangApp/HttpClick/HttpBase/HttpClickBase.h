//
//  HttpClickBase.h
//  QRCodeBarCode
//
//  Created by jing on 17/3/3.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpConfiguration.h"
#import "HttpEngine.h"

/**
 * 强依赖 pod 'AFNetworking'
 */
#pragma pod 'AFNetworking'
/**
 * API_NET_ERROR_CODE 网络错误
 * API_SERVER_ERROR_CODE 服务端返回的错误
 * defaultFailureBlock 统一的错误反馈
 */
typedef NS_ENUM(NSInteger)
{
    API_NET_ERROR_UNKNOWN = 0,//未知
    API_NET_ERROR_DownLoad_EXPIRED = -999,//下载失败
    API_NET_ERROR_TIMEOUT = -1001,//超时
    API_NET_ERROR_NONETWORK = -1009//无网络
}API_NET_ERROR_CODE;

typedef NS_ENUM(NSInteger)
{
    API_SERVER_ERROR_UNKNOWN = 0,//未知
    //与后台预定好之后自行添加
}API_SERVER_ERROR_CODE;

typedef void (^defaultFailureBlock)(NSInteger errorCode, NSString * errorMsg);


@interface HttpClickBase : NSObject
/**
 * HttpClickBase 的子类可以使用下面的两个工具
 * HttpEngine 网络请求的引擎,对AFNetWorking的封装
 * HttpConfiguration 网络请求的配置
 */
@property (nonatomic, strong, readonly) HttpEngine * apiEngine;
@property (nonatomic, strong, readonly) HttpConfiguration * apiConfiguration;

+ (instancetype)client;

/**
 * 此方法用来加入一些 共有字断(eg:token,user_id)
 */
- (NSMutableDictionary *)urlParametersDictionary:(NSDictionary *)parametersDictionary;

//对 HttpEngine 返回的结果进行统一的处理
/**
 * customFinishedBlock  --post get
 * customDownloadFinishedBlock ---download
 */
- (HTTPAPIFinishedBlock)customFinishedBlock:(BOOL(^)(id resultObject))customBlock
                                withFailure:(defaultFailureBlock)failure;

- (DownloadFileFinishedBlock)customDownloadFinishedBlock:(BOOL (^)(NSURL * filePathURL))customHandler
                                             withFailure:(defaultFailureBlock)failure;
@end
