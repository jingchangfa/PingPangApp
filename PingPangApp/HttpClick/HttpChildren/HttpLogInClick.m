//
//  HttpLogInClick.m
//  QRCodeBarCode
//
//  Created by jing on 17/3/6.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "HttpLogInClick.h"

@implementation HttpLogInClick
- (void)httpLoginAuthLoginWithDictionAry:(NSDictionary *)dic WithSuccessBlock:(void(^)())success AndFailure:(defaultFailureBlock)failure{
    NSString * urlString = [[self.apiConfiguration loginPath] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSDictionary *parameters = dic;
    /**
     * 若需要公共字断，则添加下面这句(公共字断 需要配置)
     */
//    parameters = [self urlParametersDictionary:dic];
    NSLog(@"登录:\n%@\n%@",urlString,parameters);

    HTTPAPIFinishedBlock finishedBlock = [self customFinishedBlock:^BOOL(id resultObject) {
        NSInteger succeed = [resultObject[@"success"] integerValue];
        if (succeed) {
            NSNumber *user_ID = resultObject[@"user_id"];
            if (user_ID.intValue == 2) {//@"前台强行报错～"
                return NO;
            }
        }
        return YES;
    } withFailure:failure];
    [self.apiEngine httpPostRequest:urlString parameters:parameters bodyWithBlock:nil finished:finishedBlock];
}
@end
