//
//  HttpConfiguration.m
//  QRCodeBarCode
//
//  Created by jing on 17/3/3.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "HttpConfiguration.h"
#import "AppDelegate.h"

@interface HttpConfiguration ()
//eg: 共有字断
@property (nonatomic,strong) NSNumber *userID;
@property (nonatomic,strong) NSString *token;
@end
@implementation HttpConfiguration
static HttpConfiguration *defaultConfiguration = nil;
+ (HttpConfiguration *)defaultConfiguration{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString * hostString = @"http://10.99.1.129:3000";
        hostString = @"http://app1.kap-ep.com:18888";//更换域名,一句话解决
        defaultConfiguration = [[HttpConfiguration alloc] initWithHostString:hostString];
    });
    return defaultConfiguration;
}
- (HttpConfiguration *)initWithHostString:(NSString *)hostString{
    self = [super init];
    if (self)
    {
        _hostString = hostString;
    }
    return self;
}

+ (void)setDefaultConfiguration:(HttpConfiguration *)configuration
{
    if (configuration)
    {
        @synchronized(defaultConfiguration)
        {
            defaultConfiguration = configuration;
        }
    }
    return;
}
#pragma mark 配置方法
- (void)changePublicWordBreaks:(NSDictionary *)publicWordBreaks{
    self.userID = publicWordBreaks[@"user_id"];
    self.token = publicWordBreaks[@"token"];
}
- (NSDictionary *)publicWordBreaks{
    return @{@"token":self.token,
             @"user_id":self.userID};
}
- (NSNumber *)userID{
    return @(1);
//    return [(AppDelegate *)[UIApplication sharedApplication].delegate userID];
}
- (NSString *)token{
    return @"";
//    return [(AppDelegate *)[UIApplication sharedApplication].delegate token];
}
#pragma mark 错误信息配置
- (BOOL)resultIsSuccessWithResult:(id)resultObject{
    return resultObject[@"success"];
}
- (NSInteger)resultErrorCodeWithResult:(id)resultObject{
    return [resultObject[@"code"] integerValue];
}
- (NSString *)resultErrorMsgWithResult:(id)resultObject{
    return resultObject[@"msg"];
}

#pragma mark 辅助方法
- (NSString *)complateURLWithAPIString:(NSString *)apiString{
    return [NSString stringWithFormat:@"%@/%@",self.hostString,apiString];
}
#pragma mark 下面是自己添加的接口API
//eg:
- (NSString *)loginPath{
    NSString *str = @"api/login";
    return [self complateURLWithAPIString:str];
}


@end
