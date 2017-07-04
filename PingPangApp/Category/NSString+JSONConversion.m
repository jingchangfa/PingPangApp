//
//  NSString+JSONConversion.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "NSString+JSONConversion.h"

@implementation NSString (JSONConversion)
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary{
    return [self toJson:dictionary];
}
+ (NSString *)arrayToJSONString:(NSArray *)array{
    return [self toJson:array];
}
+ (NSString *)toJson:(id)obj{
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
