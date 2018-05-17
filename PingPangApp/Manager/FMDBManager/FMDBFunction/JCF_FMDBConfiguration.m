//
//  JCF_FMDBConfiguration.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "JCF_FMDBConfiguration.h"

@implementation JCF_FMDBConfiguration
+ (NSString *)CompletePathByToken:(NSString *)token{
    NSString *pathString = [self SQLPath];
    NSString *nameString = [self SQLLibNameByToken:token];
    pathString = [pathString stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",nameString]];
    return pathString;
}

+ (NSString *)SQLPath{
    NSString *pathString = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    pathString = [pathString stringByAppendingPathComponent:self.TheCompanyName];//用公司名比较好
    return pathString;
}
+ (NSString *)SQLLibNameByToken:(NSString *)token{
    NSString *nameString = [NSString stringWithFormat:@"%@%@.sqlite",self.TheProjectName,token];
    return nameString;
}
// 配置
+ (NSString *)TheCompanyName{
    return @"RaiseThink";
}
+ (NSString *)TheProjectName{
    return @"KapEp";
}

//dic json 转化
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary{
    return [self toJson:dictionary];
}
+ (NSString *)arrayToJSONString:(NSArray *)array{
    return [self toJson:array];
}
+ (NSString *)toJson:(id)obj{
//    if (!([[obj class]isSubclassOfClass:[NSArray class]]||[[obj class] isSubclassOfClass:[NSDictionary class]])) {
//        return nil;
//    }
    if (![NSJSONSerialization isValidJSONObject:obj]){
        return nil;
    }
    NSError *err = nil;
    NSData *stringData =
    [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&err];
    if (err) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return jsonString;
}
+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString{
    return [self jsonToObj:jsonString];
}
+ (NSArray *)jsonStringToArray:(NSString *)jsonString{
    return [self jsonToObj:jsonString];
}
+ (id)jsonToObj:(NSString *)jsonString{
    if (![[jsonString class]isSubclassOfClass:[NSString class]]) {
        return nil;
    }
    NSError *err;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id obj;
    if (jsonData) {
        obj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    }
    if (err) {
        return nil;
    }
    return obj;
}
@end
