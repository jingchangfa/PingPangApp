//
//  JCF_FMDBSQLStatement.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "JCF_FMDBSQLStatement.h"
#import "JCF_FMDBConfiguration.h"

@implementation JCF_FMDBSQLStatement
- (instancetype)initWithModelPropertyDictionary:(NSDictionary *)modelDictionary{
    if (self = [super init]) {
        if (!modelDictionary) {
            NSLog(@"model解析的字典不存在，请检查");
        }
        _modelDictionary = modelDictionary;
    }
    return self;
}

+ (NSString *)CreatedSQLLibStringByName:(NSString *)nameString{
    NSFileManager *filemanage = [NSFileManager defaultManager];
    NSString *pathString = [JCF_FMDBConfiguration SQLPath];
    BOOL isDir;
    BOOL exit =[filemanage fileExistsAtPath:pathString isDirectory:&isDir];
    BOOL success = false;
    if (!exit || !isDir) {
        success = [filemanage createDirectoryAtPath:pathString withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *dbpath = [JCF_FMDBConfiguration CompletePathByToken:nameString];
    return dbpath;
}
- (NSString *)createSQLTable{
    NSString *classNameString = self.classNameString;
    NSString *mainKeyString = self.mainKeyString;
    NSArray *propertyArray = self.propertyArray;
    
    NSMutableString *columeAndTypeString = [NSMutableString string];
    for (NSDictionary *propertyDic in propertyArray) {
        NSString *proName = propertyDic[PropertyName];
        NSString *proSQLType = propertyDic[SQLType];
        if ([proName isEqualToString:mainKeyString]) {
            [columeAndTypeString appendString:[NSString stringWithFormat:@"%@ %@ %@",mainKeyString,proSQLType,PrimaryKey]];
        }else{
            [columeAndTypeString appendFormat:@"%@ %@ %@",proName,proSQLType,@"NULL"];//允许为空
        }
        [columeAndTypeString appendString:@","];
    }
    if(columeAndTypeString.length>1){//去除最后一个 ,
        [columeAndTypeString deleteCharactersInRange:NSMakeRange(columeAndTypeString.length-1,1)];
    }
    NSString *sqlString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@);",classNameString,columeAndTypeString];
    return sqlString;
}
- (void)isHaveTableSQLStringWith:(void(^)(NSString *sqlString,NSString *tableName))block{
    if (!block) return;
    NSString *classNameString = self.classNameString;
    NSString *sqlString = @"select count(*) as 'count' from sqlite_master where type ='table' and name = ?";
    block(sqlString,classNameString);
}
- (NSString *)isHaveTableSQLString{
    NSString *classNameString = self.classNameString;
    
    NSString *sqlString = [NSString stringWithFormat:@"select count(*) as 'count' from sqlite_master where type ='table' and name = %@", classNameString];
    return sqlString;
}
- (void)tableNeedAddNewColumnByTableAllColunm:(NSArray *)allColumn
                                  AndSQLBlock:(JCF_AddPropertyBlcok)block{
    NSString *classNameString = self.classNameString;
    NSArray *propertyArray = self.propertyArray;

    for (NSDictionary *propertyDic in propertyArray) {
        NSString *proName = propertyDic[PropertyName];
        NSString *sqlType = propertyDic[SQLType];
        if ([allColumn containsObject:proName]) continue;
        NSString *fieldSql = [NSString stringWithFormat:@"%@ %@",proName,sqlType];
        NSString *sqlString = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ ",classNameString,fieldSql];
        block(sqlString);//返回add列的sql语句
    }
}

/**
 * 增加操作
 * 此方法生成sql语句，以及与sql匹配的value数组
 */
- (void)addSQLStringWithResult:(JCF_SQLAddModelBlock)block{
    NSString *classNameString = self.classNameString;
    NSArray *propertyArray = self.propertyArray;
    
    NSMutableString *keyString = [NSMutableString string];
    NSMutableString *valueString = [NSMutableString string];
    NSMutableArray *insertValues = [NSMutableArray  array];
    for (NSDictionary *propertyDic in propertyArray) {
        NSString *proname = propertyDic[PropertyName];
        [keyString appendFormat:@"%@,", proname];
        [valueString appendString:@"?,"];
        [insertValues addObject:propertyDic[PropertyValue]];
    }
    if(keyString.length>1){//去除最后一个 ,
        [keyString deleteCharactersInRange:NSMakeRange(keyString.length-1,1)];
        [valueString deleteCharactersInRange:NSMakeRange(valueString.length-1,1)];
    }
    NSString *sqlString = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@);", classNameString, keyString, valueString];
    block(sqlString,insertValues);
}
/**
 * 修改（根据主键更新）
 * 此方法生成sql语句，以及与sql匹配的value数组
 */
- (void)updateSQLStringWithResult:(JCF_SQLAddModelBlock)block{
    NSString *mainKeyString = self.mainKeyString;
    NSString *classNameString = self.classNameString;
    NSArray *propertyArray = self.propertyArray;
    
    NSMutableString *keyString = [NSMutableString string];
    NSMutableArray *updateValues = [NSMutableArray  array];
    for (NSDictionary *propertyDic in propertyArray) {
        NSString *proname = propertyDic[PropertyName];
        [keyString appendFormat:@"%@=?,", proname];
        [updateValues addObject:propertyDic[PropertyValue]];
    }
    if(keyString.length>1){//去除最后一个 ,
        [keyString deleteCharactersInRange:NSMakeRange(keyString.length-1,1)];
    }
    NSString *sqlString = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@ = ?;", classNameString, keyString, mainKeyString];
    //别忘了 补上主键对应的————值
    [updateValues addObject:self.mainKeyValue];
    block(sqlString,updateValues);
}
/**
 * 删除操作 （通过主键删除）
 * 此方法生成sql语句，以及与sql匹配的value数组
 */
- (void)remSQLStringWithResult:(JCF_SQLAddModelBlock)block{
    NSString *classNameString = self.classNameString;
    NSString *mainKeyString = self.mainKeyString;
    id value = self.mainKeyValue;
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?",classNameString,mainKeyString];
    block(sqlString,@[value]);
}

/**
 * 查(通过条件查找)
 * infoDictionary = nil 查找表内全部数据
 * 更多的查询，自己扩展吧～
 */
+ (NSString *)searchSQLStringByModelClass:(Class)modelClass WithInfoDictionary:(NSDictionary *)infoDictionary{
    NSString *classNameString = NSStringFromClass(modelClass);
    //查找全部
    if (!infoDictionary) {
        return [NSString stringWithFormat:@"SELECT * FROM %@",classNameString];
    }
    NSMutableString *sqlString = [NSMutableString string];
    NSArray *proNamesArray = infoDictionary.allKeys;
    for (int i = 0; i<proNamesArray.count; i++) {
        NSString *proname = proNamesArray[i];
        id provalue = infoDictionary[proname];
        if ([[provalue class] isSubclassOfClass:[NSString class]]) {
            [sqlString appendFormat:@"SELECT * FROM %@ WHERE %@='%@',",classNameString, proname,provalue];
        }else{
            [sqlString appendFormat:@"SELECT * FROM %@ WHERE %@=%@,",classNameString, proname,provalue];
        }
    }
    if(sqlString.length>1){//去除最后一个 ,
        [sqlString deleteCharactersInRange:NSMakeRange(sqlString.length-1,1)];
    }
    return sqlString;
}

#pragma mark get
- (NSString *)classNameString{
    return self.modelDictionary[PropertyType];
}
- (NSString *)mainKeyString{
    return self.modelDictionary[PropertyModelMainKey];
}
- (id)mainKeyValue{
    return self.modelDictionary[PropertyMainValue];
}
- (NSArray *)propertyArray{
    return self.modelDictionary[PropertyValue];
}

@end
