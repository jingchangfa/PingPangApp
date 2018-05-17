//
//  JCF_FMDBConfiguration.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 配置文件
 */
@interface JCF_FMDBConfiguration : NSObject
/**
 * CompletePathByToken 完成的路径包括数据库名称
 * SQLPath 数据库存在路径
 * SQLLibNameByToken 数据库名字通过标识符(一个用户对于一个sql)
 */
+ (NSString *)CompletePathByToken:(NSString *)token;
+ (NSString *)SQLPath;
+ (NSString *)SQLLibNameByToken:(NSString *)token;


//把数组转换成json字符串
+ (NSString *)toJson:(id)obj;
+ (id)jsonToObj:(NSString *)jsonString;

+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary;
+ (NSString *)arrayToJSONString:(NSArray *)array;
+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString;
+ (NSArray *)jsonStringToArray:(NSString *)jsonString;
@end
