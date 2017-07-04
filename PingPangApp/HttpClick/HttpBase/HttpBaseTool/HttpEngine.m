
//
//  HttpEngine.m
//  QRCodeBarCode
//
//  Created by jing on 17/3/3.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "HttpEngine.h"
#import "HMFJSONResponseSerializerWithData.h"//这个玩意 是在500的时候仍然去获取result

@interface HttpEngine ()

@property (nonatomic, strong) NSURLSessionTask * sessionTask;

@end
@implementation HttpEngine
- (NSDictionary *)jsonStringErrorToDictionaryWithError:(NSError *)error{
    if (error) {
        NSString *errorString = error.userInfo[@"body"];
        return [self jsonToModelWithSrting:errorString];
    }
    return nil;
}
- (id)jsonToModelWithSrting:(NSString *)string{
    NSError *err;
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    id obj;
    if (jsonData) {
        obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    }
    return obj;
}

//获取网络状态
+ (void)HttpReachabilityStatus:(void(^)(AFNetworkReachabilityStatus status))block{
    AFNetworkReachabilityManager *networkManager = [AFNetworkReachabilityManager sharedManager];
    [networkManager startMonitoring];
    [networkManager setReachabilityStatusChangeBlock:block];
}

- (void)httpGetRequest:(NSString *)urlString
              finished:(HTTPAPIFinishedBlock)finished
{
    self.sessionTask =
    [[self manager] GET:urlString parameters:nil progress:NULL success:^(NSURLSessionDataTask *  task, id responseObject) {
        finished(responseObject, nil);
        NSLog(@"结果：%@",responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"结果：: %@",error);
        finished(nil, error);
    }];
}

- (void)httpPostRequest:(NSString *)urlString
             parameters:(NSDictionary *)parameters
          bodyWithBlock:(void (^)(id<AFMultipartFormData>))block
               finished:(HTTPAPIFinishedBlock)finished
{
    if (!block)
    {
        self.sessionTask =
        [[self manager] POST:urlString parameters:parameters progress:NULL success:^(NSURLSessionDataTask * task, id responseObject) {
            finished(responseObject, nil);
            NSLog(@"结果：%@",responseObject);
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            NSLog(@"结果：%@ %@",task,error);
            finished(nil, error);
        }];
    }
    else
    {
        AFHTTPSessionManager *manager = [self manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.sessionTask =
        [manager POST:urlString parameters:parameters constructingBodyWithBlock:block progress:NULL success:^(NSURLSessionDataTask * task, id   responseObject) {
            finished(responseObject, nil);
            NSLog(@"结果：%@",responseObject);
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            NSLog(@"结果：%@ %@",task,error);
            finished(nil, error);
        }];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
}

- (void)httpPostRequest:(NSString *)urlString
             parameters:(NSDictionary *)parameters
               progress:(DownLoadProgressBlock)progress
          bodyWithBlock:(void (^)(id<AFMultipartFormData>))block
               finished:(HTTPAPIFinishedBlock)finished
{
    self.sessionTask =
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters constructingBodyWithBlock:block progress:^(NSProgress * _Nonnull uploadProgress){
        // This is not called back on the main queue.
        // You are responsible for dispatching to the main queue for UI updates
        if (progress)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                progress(uploadProgress);
            });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finished(responseObject, nil);
        NSLog(@"结果：%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        finished(nil, error);
        NSLog(@"错误：%@",error);
    }];
}

// download one file
- (void)downLoadFile:(NSString *)urlString
              toPath:(NSString *)toPath
            progress:(DownLoadProgressBlock)progress
            finished:(DownloadFileFinishedBlock)finished
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    self.sessionTask =
    [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // This is not called back on the main queue.
        // You are responsible for dispatching to the main queue for UI updates
        if (progress)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                progress(downloadProgress);
            });
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL fileURLWithPath:toPath
                          isDirectory:NO];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"结果：%@", filePath);
        
        if (error)
        {
            finished(nil, error);
        }
        else
        {
            finished(filePath, nil);
        }
    }];
    [self.sessionTask resume];
}

// cancel the request, download or upload
- (void)cancelRequest
{
    if (self.sessionTask)
    {
        [self.sessionTask cancel];
        self.sessionTask = nil;
    }
}
- (void)cancelAllRequest{
    [[self manager].operationQueue cancelAllOperations];
}
//超时时间的manmger
- (AFHTTPSessionManager *)manager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setTimeoutInterval:30];
        NSSet *set = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
        set = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
        manager.responseSerializer = [HMFJSONResponseSerializerWithData serializer];
        manager.responseSerializer.acceptableContentTypes = set;
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    return manager;
}
- (void)dealloc{
    [self cancelRequest];
}
@end
