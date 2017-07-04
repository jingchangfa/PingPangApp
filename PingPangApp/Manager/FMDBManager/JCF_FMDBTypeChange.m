//
//  JCF_FMDBTypeChange.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/7.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "JCF_FMDBTypeChange.h"
#import "JCF_FMDBRunTimeModelInterface.h"

@implementation JCF_FMDBTypeChange

+ (NSString *)sqlTypeStringByPropertyTypeString:(NSString *)propertyType{
    if ([propertyType hasPrefix:@"T@\"NSString\""]) {
        return SQLTEXT;
    }
    if ([propertyType hasPrefix:@"T@\"NSData\""]) {
        return SQLBLOB;
    }
    if ([propertyType hasPrefix:@"Ti"]||[propertyType hasPrefix:@"TI"]||[propertyType hasPrefix:@"Ts"]||[propertyType hasPrefix:@"TS"]||[propertyType hasPrefix:@"TB"]||[propertyType hasPrefix:@"Tq"]||[propertyType hasPrefix:@"TQ"]) {
        return SQLINTEGER;
    }
    if ([propertyType hasPrefix:@"T@\"NSArray\""]) {
        return SQLTEXT;
    }
    if ([propertyType hasPrefix:@"T@\"NSDictionary\""]) {
        return SQLTEXT;
    }
    if ([propertyType hasPrefix:@"T@\"NSNumber\""]) {
        return SQLREAL;
    }
    // T@"CeShiCar",&,N,V_car 导致解析失败 处理一下
    propertyType = [self classNameStringByPropertyType:propertyType];
    //model 嵌套 用递归获取主键
    JCF_FMDBRunTimeModelInterface *modelInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:propertyType];
    NSString *str = modelInterface.mainKeyPropertyType;
    return [self sqlTypeStringByPropertyTypeString:str];//递归～取主键类型对应的sql
}
+ (NSString *)classNameStringByPropertyType:(NSString *)propertyType{
    NSString *classNameString = propertyType;
    if ([propertyType hasPrefix:@"T@\""]) {
        NSArray *classNameArray = [propertyType componentsSeparatedByString:@"\""];
        classNameString = classNameArray[1];
    }
    return classNameString;
}

@end
