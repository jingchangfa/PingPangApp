
//
//  HttpClickBase.m
//  QRCodeBarCode
//
//  Created by jing on 17/3/3.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "HttpClickBase.h"
#import "HttpConfiguration.h"
#import "HttpEngine.h"
#import "HttpErrorShow.h"
@interface HttpClickBase ()
// HttpErrorShow 负责根据错误处理UI的,比如弹框什么的
@property (nonatomic, strong, readonly) HttpErrorShow * apiErrorShow;
@end

@implementation HttpClickBase
+ (instancetype)client
{
    return [[[self class] alloc] init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _apiErrorShow = [[HttpErrorShow alloc] init];
        _apiEngine = [[HttpEngine alloc] init];
        _apiConfiguration = [HttpConfiguration defaultConfiguration];
    }
    return self;
}
- (NSMutableDictionary *)urlParametersDictionary:(NSDictionary *)parametersDictionary{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //共有字断
    NSDictionary *publicWordBreaks = [self.apiConfiguration publicWordBreaks];
    if (publicWordBreaks) {
        [dic setDictionary:publicWordBreaks];
    }
    if (parametersDictionary) {
        [dic setDictionary:parametersDictionary];
    }
    return dic;
}

//对 HttpEngine 返回的结果进行统一的处理
- (HTTPAPIFinishedBlock)customFinishedBlock:(BOOL(^)(id resultObject))customBlock
                                withFailure:(defaultFailureBlock)failure{
    return ^(id resultObject, NSError * error){
        if (error){
            NSDictionary *dic = [self.apiEngine jsonStringErrorToDictionaryWithError:error];
            if (dic) {
                NSLog(@"错误信息%@",dic);//500 的情况下仍获取 崩溃信息
                resultObject = dic;
                error = nil;
            }
        }
        if ([self handleNetworkError:error withFailure:failure]) {
            return ;
        }
        if ([self handleCommonErrorFromResponse:resultObject withFailure:failure]) {
            return ;
        }
        if (customBlock(resultObject)) {//前台定义的错误，
            return ;
        }
        failure(-1, @"前台强行报错～");
        NSLog(@"前台强行报错%@",resultObject);
    };
}
- (DownloadFileFinishedBlock)customDownloadFinishedBlock:(BOOL (^)(NSURL * filePathURL))customHandler
                                             withFailure:(defaultFailureBlock)failure
{
    return ^void(NSURL * filePathURL, NSError * error) {
        if ([self handleNetworkError:error withFailure:failure])
            return;
        // 下载文件应该只返回 最终保存文件的本地路径，此处现在没考虑如果服务端不让下载，返回错误信息的情况，需要跟 server 端再确认一下
        if (customHandler(filePathURL))
            return;
        failure(-1, @"成功无返回结果");
    };
}
/**
 * handleNetworkError  网络错误
 * handleCommonErrorFromResponse 返回结果错误
 */
- (BOOL)handleNetworkError:(NSError *)error withFailure:(defaultFailureBlock)failure{
    if (!error) {
        return NO;
    }
    API_NET_ERROR_CODE code = error.code;
    NSString *msg = error.domain;
    failure(code,msg);
    [self.apiErrorShow httpErrorWithCode:code AndMes:msg];
    return YES;
}
- (BOOL)handleCommonErrorFromResponse:(id)responseObject withFailure:(defaultFailureBlock)failure{
    if (!responseObject) {
        return NO;
    }
    NSInteger succeed = [self.apiConfiguration resultIsSuccessWithResult:responseObject];
    if (succeed) {
        return NO;
    }
    API_SERVER_ERROR_CODE code = [self.apiConfiguration resultErrorCodeWithResult:responseObject];
    NSString *msg = [self.apiConfiguration resultErrorMsgWithResult:responseObject];
    failure(code,msg);
    [self.apiErrorShow serverErrorWithCode:code AndMes:msg];
    return YES;
}
@end
