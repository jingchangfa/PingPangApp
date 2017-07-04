//
//  JCF_FMDBTypeChange.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/7.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

/** SQLite五种数据类型 */
#define SQLTEXT     @"TEXT"
#define SQLINTEGER  @"INTEGER"
#define SQLREAL     @"REAL"
#define SQLBLOB     @"BLOB"
#define SQLNULL     @"NULL"

// 数据库数据类型与objectc数据类型转化的工具类
@interface JCF_FMDBTypeChange : NSObject
// model类型 -> sql类型
+ (NSString *)sqlTypeStringByPropertyTypeString:(NSString *)propertyType;

@end
