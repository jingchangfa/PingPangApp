
//
//  JCF_FMDBBlockHeader.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/7.
//  Copyright © 2017年 jing. All rights reserved.
//

#ifndef JCF_FMDBBlockHeader_h
#define JCF_FMDBBlockHeader_h

static NSString const* PropertyModelMainKey = @"propertyModelMainKey";//model主键
static NSString const* PropertyMainValue = @"propertyMainValue";
static NSString const* PropertyName = @"propertyName";
static NSString const* PropertyType = @"propertyType";
static NSString const* SQLType = @"sqlType";
static NSString const* PropertyValue = @"propertyValue";
static NSString const* PropertyClassInterface = @"propertyClassInterface";
static NSString const* PropertyModelThis = @"propertyModelThis";//model本身

/**
 * 成功：返回yes，fireModelArray ＝ nil；
 * 失败：返回no ，fireModelArray ！＝ nil；
 */
typedef void(^JCF_ResultBlock)(BOOL successful,NSArray *fireModelArray);

/**
 * JCF_SQLAddModelBlock  增添
 */

typedef void(^JCF_SQLAddModelBlock)(NSString *sqlString,NSArray *valueArray);


/**
 * JCF_GetModelValueBlock
 * columeName table字断名
 * type 数据类型
 */
typedef NS_ENUM(NSInteger){
    SQL_DATA_TYPE_TEXT = 0,//NSString,NSArray
    SQL_DATA_TYPE_INTEGER = 1,//Ti,Ts,TB,TQ,TI,TS,Tq
    SQL_DATA_TYPE_REAL = 2,//NSNumber
    SQL_DATA_TYPE_BLOB = 3,//NSData
    SQL_DATA_TYPE_NULL = 4//NULL
}SQL_DATA_TYPE;
typedef void (^JCF_GetModelValueBlock)(NSString *propertyNameString,SQL_DATA_TYPE type);
typedef void(^JCF_GetPropertyModelBlock)(NSString *propertyNameString,Class modelClass,SQL_DATA_TYPE type);

/**
 * JCF_AddPropertyBlcok 添加 行列的 block
 *  1
  *
 */
typedef void (^JCF_AddPropertyBlcok)(NSString *sqlString);

#endif /* JCF_FMDBBlockHeader_h */
