//
//  HttpConfiguration.h
//  QRCodeBarCode
//
//  Created by jing on 17/3/3.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpConfiguration : NSObject
@property (nonatomic, strong, readonly) NSString * hostString;
/**
 * defaultConfiguration 默认配置
 * initWithHostString 自定义配置
 * setDefaultConfiguration 设置成默认 (例如:测试环境和生产环境 代码切换)
 */
+ (HttpConfiguration *)defaultConfiguration;
- (HttpConfiguration *)initWithHostString:(NSString *)hostString;
+ (void)setDefaultConfiguration:(HttpConfiguration *)configuration;
/**
 * 共有字断配置
 */
- (void)changePublicWordBreaks:(NSDictionary *)publicWordBreaks;
- (NSDictionary *)publicWordBreaks;

/**
 * resultIsSuccessWithResult 配置 如何判断请求成功
 * resultErrorCodeWithResult 配置 请求失败code的key
 * resultErrorMsgWithResult  配置 请求失败msg的key
 */
- (BOOL)resultIsSuccessWithResult:(id)resultObject;
- (NSInteger)resultErrorCodeWithResult:(id)resultObject;
- (NSString *)resultErrorMsgWithResult:(id)resultObject;

#pragma mark 下面是自己添加的接口API
//eg:
- (NSString *)loginPath;
@end
