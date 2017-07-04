//
//  NSString+JSONConversion.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
// json 转化
@interface NSString (JSONConversion)
+ (NSString *)dictionaryToJSONString:(NSDictionary *)dictionary;
+ (NSString *)arrayToJSONString:(NSArray *)array;
+ (NSDictionary *)jsonStringToDictionary:(NSString *)jsonString;
+ (NSArray *)jsonStringToArray:(NSString *)jsonString;
@end
