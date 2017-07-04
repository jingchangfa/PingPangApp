//
//  HttpEngine.h
//  QRCodeBarCode
//
//  Created by jing on 17/3/3.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^HTTPAPIFinishedBlock) (id resultObject, NSError * error);
typedef void (^DownloadFileFinishedBlock) (NSURL * filePath, NSError * error);
typedef void (^DownLoadProgressBlock) (NSProgress * progress);

@interface HttpEngine : NSObject
- (NSDictionary *)jsonStringErrorToDictionaryWithError:(NSError *)error;

//获取网络状态
+ (void)HttpReachabilityStatus:(void(^)(AFNetworkReachabilityStatus status))block;

// 普通 HTTP GET 请求，没有进度回调
- (void)httpGetRequest:(NSString *)urlString
              finished:(HTTPAPIFinishedBlock)finished;

// 普通 HTTP POST 请求，没有进度回调
- (void)httpPostRequest:(NSString *)urlString
             parameters:(NSDictionary *)parameters
          bodyWithBlock:(void(^)(id<AFMultipartFormData>))block
               finished:(HTTPAPIFinishedBlock)finished;

// 通过 HTTP POST 上传数据到服务器，bodyWithBlock 参数内拼接要上传的内容
- (void)httpPostRequest:(NSString *)urlString
             parameters:(NSDictionary *)parameters
               progress:(DownLoadProgressBlock)progress
          bodyWithBlock:(void (^)(id<AFMultipartFormData>))block
               finished:(HTTPAPIFinishedBlock)finished;

// 下载文件到本地，urlString 为下载地址，toPath 为本地存储路径（含文件名），finished block中，如果成功，返回最终文件保存的地址
- (void)downLoadFile:(NSString *)urlString
              toPath:(NSString *)toPath
            progress:(DownLoadProgressBlock)progress
            finished:(DownloadFileFinishedBlock)finished;

// 取消当前请求
- (void)cancelRequest;
// 取消全部请求
- (void)cancelAllRequest;

@end
