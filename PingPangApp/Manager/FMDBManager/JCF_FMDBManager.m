
//
//  JCF_FMDBManager.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "JCF_FMDBManager.h"
#import <FMDB/FMDB.h>//fmdb
#import "JCF_FMDBConfiguration.h"//配置文件

#import "JCF_FMDBModelToSQL.h"//解析model实例对象
#import "JCF_FMDBSQLToModel.h"//转化为model实例对象

#import "JCF_FMDBSQLStatement.h"//将解析结果转化为sql语句

@interface JCF_FMDBManager ()
@property (nonatomic,strong)FMDatabaseQueue *dbQueue;
@property (nonatomic,strong)NSString *name;
//用来存储class的数组(保证程序运行过程中，只会走一次创建表)
@property (nonatomic,strong)NSMutableArray *classNameArray;
@end

@implementation JCF_FMDBManager
-(instancetype)initWithDataBaseName:(NSString *)name{
    self = [super init];
    if (self) {
        self.name = name;//数据库名称的一部分，忘记就会丢库～～
    }
    return self;
}
/**
 * 建表
 * 创建JCF_FMDBSQLStatement
 * 1. 判断表是否存在，存在则继续执行第二步,（不存在不需要执行第二步）
 * 2. 判断是否属性有增，增加新列
 */
- (JCF_FMDBSQLStatement *)createTableActionWithModelDictionary:(NSDictionary *)modelDictionary AndDB:(FMDatabase *)db AndRollback:(BOOL *)rollback{
    // 创建sql语句生产者
    JCF_FMDBSQLStatement *statement = [[JCF_FMDBSQLStatement alloc] initWithModelPropertyDictionary:modelDictionary];
    NSString *tableName = statement.classNameString;
    if ([self.classNameArray containsObject:tableName]) {//没个类只会走一次
        return statement;
    }
    __block BOOL res = YES;
    __block FMResultSet *rs = nil;
    [statement isHaveTableSQLStringWith:^(NSString *sqlString, NSString *tableName) {
        rs = [db executeQuery:sqlString,tableName];
    }];
    BOOL isCreate = NO;
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        if (count != 0) isCreate = YES;
    }
    if (isCreate) {//已经创建：添加tab的 新列
        NSArray *columns = [self dataBaseProertyByFMDatabase:db AndTableName:tableName];
        [statement tableNeedAddNewColumnByTableAllColunm:columns AndSQLBlock:^(NSString *sqlString) {
            if (![db executeUpdate:sqlString]) {
                res = NO;
                *rollback = YES;
            }
        }];
    }else{ //未被创建：创建tab
        NSString *tableCreateSQLString = [statement createSQLTable];
        if (![db executeUpdate:tableCreateSQLString]) {
            res = NO;
            *rollback = YES;
        };
        NSLog(@"创建一个table - %@ -%@ -%@",tableName,res?@"成功":@"失败",tableCreateSQLString);
    }
    //成功的话存储一下class
    if (res) {
        [self.classNameArray addObject:tableName];
    }
    return statement;
}
/**
 * 获取表的列
 */
- (NSArray *)dataBaseProertyByFMDatabase:(FMDatabase *)db AndTableName:(NSString *)tableName{
    NSMutableArray *columns = [NSMutableArray array];
    FMResultSet *resultSet = [db getTableSchema:tableName];
    while ([resultSet next]) {
        NSString *column = [resultSet stringForColumn:@"name"];
        [columns addObject:column];
    }
    return columns;
}
#pragma mark 单个___增删改
- (BOOL)updataModelByType:(MODEL_MANAGER_TYPE)type
                WithModel:(NSObject <JCF_FMDBModelProtocol>*)model{
    __block BOOL res = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        JCF_FMDBModelToSQL *helping = [[JCF_FMDBModelToSQL alloc] initWithModel:model];
        res = [self updataModel:db AndRollback:rollback AndAction:type WithodelToSQL:helping];
    }];
    return res;
}
#pragma mark 批量___增删改
- (void)updateModelsByType:(MODEL_MANAGER_TYPE)type
                WithModels:(NSArray <NSObject <JCF_FMDBModelProtocol>*> *)models
            AndFinishBlock:(JCF_ResultBlock)block{
    NSMutableArray *fairModelArray = [NSMutableArray array];
    __block BOOL res = NO;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (NSObject<JCF_FMDBModelProtocol> *model in models) {
            JCF_FMDBModelToSQL *helping = [[JCF_FMDBModelToSQL alloc] initWithModel:model];
            res = [self updataModel:db AndRollback:rollback AndAction:type WithodelToSQL:helping];
            if (!res) [fairModelArray addObject:model];
        }
    }];
    if (fairModelArray.count == 0){
        block(YES,nil);
    }else{
        NSLog(@"批量处理数据失败了%d个",(int)fairModelArray.count);
        block(NO,fairModelArray);
    }
}
#pragma mark 增删改处理方法
- (BOOL)updataModel:(FMDatabase *)db
        AndRollback:(BOOL *)rollback
          AndAction:(MODEL_MANAGER_TYPE)type
      WithodelToSQL:(JCF_FMDBModelToSQL*)helping{
    BOOL res = NO;
    if (type == MODEL_MANAGER_TYPE_REM) {
        NSDictionary *modelThisModel = helping.mineModelDictionary;
        JCF_FMDBSQLStatement *statement = [self createTableActionWithModelDictionary:modelThisModel AndDB:db AndRollback:rollback];
        res = [self removeAction:db WithSQLStatement:statement];
        if (!res) NSLog(@"删除失败一个数据%@",modelThisModel);
        return res;
    }
    for (NSDictionary *modelDictionary in helping.propertyDictionaryArray) {
        JCF_FMDBSQLStatement *statement = [self createTableActionWithModelDictionary:modelDictionary AndDB:db AndRollback:rollback];
        res = [self addAction:db WithSQLStatement:statement];
        if (!res) res = [self updateAction:db WithSQLStatement:statement];
        if (!res) NSLog(@"更新失败一个数据%@",modelDictionary);
    }
    return res;
}
#pragma mark 条件查找
- (NSArray *)searchModelsByModelClass:(Class)modelClass AndSearchPropertyDictionary:(NSDictionary *)infoDictionary{
    __block NSArray *models = nil;
    //无需 建表或更新列 直接查找 拼接
    // 1. 先查modelThisModel 然后解析modelThisModel
    // 2. 查属性model
    // 3. 查找结束拼接起来
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        models = [self searchAction:db WithModelClass:modelClass AndInfoDictionary:infoDictionary];
    }];
    return models;
}
/**
 addModel 增
 */
- (BOOL)addAction:(FMDatabase *)db
        WithSQLStatement:(JCF_FMDBSQLStatement *)statement{
    __block BOOL res = NO;
    [statement addSQLStringWithResult:^(NSString *sqlString, NSArray *valueArray) {
        res = [db executeUpdate:sqlString withArgumentsInArray:valueArray];
//        NSLog(@"%@,%@",res?@"成功":@"失败",sqlString);
    }];
    return res;
}
/**
 addModel 改
 */
- (BOOL)updateAction:(FMDatabase *)db
           WithSQLStatement:(JCF_FMDBSQLStatement *)statement{
    __block BOOL res = NO;
    [statement updateSQLStringWithResult:^(NSString *sqlString, NSArray *valueArray) {
        res = [db executeUpdate:sqlString withArgumentsInArray:valueArray];
        if(!res)NSLog(@"更新失败一个数据%@,%@",sqlString,valueArray);
    }];
    return res;
}
/**
 addModel 删
 */
- (BOOL)removeAction:(FMDatabase *)db
           WithSQLStatement:(JCF_FMDBSQLStatement *)statement{
    __block BOOL res = NO;
    [statement remSQLStringWithResult:^(NSString *sqlString, NSArray *valueArray) {
        res = [db executeUpdate:sqlString withArgumentsInArray:valueArray];
        if(!res)NSLog(@"删除失败一个数据%@,%@",sqlString,valueArray);
    }];
    return res;
}
/**
 searchAction 查
 */
- (NSArray *)searchAction:(FMDatabase *)db WithModelClass:(Class)modelClass AndInfoDictionary:(NSDictionary *)infoDictionary{
    NSMutableArray *models = [NSMutableArray array];
    NSString *sqlString = [JCF_FMDBSQLStatement searchSQLStringByModelClass:modelClass WithInfoDictionary:infoDictionary];
    JCF_FMDBSQLToModel *helping = [[JCF_FMDBSQLToModel alloc] initWithModelClass:modelClass];
    FMResultSet *resultSet = [db executeQuery:sqlString];
    while ([resultSet next]) {
        NSObject <JCF_FMDBModelProtocol> *model = [[modelClass alloc] init];
        [helping enumPropertyWithEnumBlcok:^void(NSString *propertyNameString, SQL_DATA_TYPE type) {
            id value = [self valueByType:type AndResult:resultSet AndPropertyName:propertyNameString];
            [model setValue:value forKey:propertyNameString];
        }];
        [helping enumModelPropertyEnumBlock:^(NSString *propertyNameString, __unsafe_unretained Class modelClass, SQL_DATA_TYPE type) {
            // type 是propertyNameString对应的class对应的model的主键的type
            // 获取主键的value
            id value = [self valueByType:type AndResult:resultSet AndPropertyName:propertyNameString];
            // 查找model
            NSObject <JCF_FMDBModelProtocol> *children = [self modelByDb:db AndClass:modelClass AndValue:value];
            [model setValue:children forKey:propertyNameString];
        }];
        [helping enumModelArrayPropertyEnumBlock:^(NSString *propertyNameString, __unsafe_unretained Class modelClass, SQL_DATA_TYPE type) {
            // type 是propertyNameString对应的class对应的model的主键的type
            // 获取主键的value
            NSArray *jsonArray = [self valueByType:SQL_DATA_TYPE_TEXT AndResult:resultSet AndPropertyName:propertyNameString];
            NSMutableArray *modelsArray = [NSMutableArray array];
            for (id value in jsonArray) {
                // 查找model
                NSObject <JCF_FMDBModelProtocol> *children = [self modelByDb:db AndClass:modelClass AndValue:value];
                if (children) {
                    [modelsArray addObject:children];
                }
            }
            [model setValue:modelsArray forKey:propertyNameString];
        }];
        [models addObject:model];
        FMDBRelease(model);
    }
    return models;
}
// 获取model
- (NSObject <JCF_FMDBModelProtocol> *)modelByDb:(FMDatabase *)db AndClass:(Class)modelClass AndValue:value{
    if (!value) return nil;

    // value创建info
    NSDictionary *infoDictionary = [JCF_FMDBSQLToModel infoDictionaryByValue:value AndClass:modelClass];
    // 查找嵌套model
    NSArray *childrens = [self searchAction:db WithModelClass:modelClass AndInfoDictionary:infoDictionary];
    if (childrens.count != 0) {
        return childrens.firstObject;
    }
    return nil;
}

// 获取value
// 若为数组和字典转化则自动转化为数组和字典
- (id)valueByType:(SQL_DATA_TYPE)type AndResult:(FMResultSet *)resultSet AndPropertyName:(NSString *)propertyNameString{
    id value = nil;
    if([resultSet columnIsNull:propertyNameString])return value;
    
    if (type == SQL_DATA_TYPE_TEXT) {
        value = [resultSet stringForColumn:propertyNameString];
        id obj = [JCF_FMDBConfiguration jsonToObj:value];
        if (obj){
            NSLog(@"jsonString%@转化为->%@",value,obj);
            value = obj;
        }
    }else if (type == SQL_DATA_TYPE_BLOB){
        value = [resultSet dataForColumn:propertyNameString];
    }else{
        value = @([resultSet longLongIntForColumn:propertyNameString]);
    }
    return value;
}

#pragma mark get 方法
-(FMDatabaseQueue *)dbQueue{
    if (!_dbQueue) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[JCF_FMDBSQLStatement CreatedSQLLibStringByName:self.name]];
    }
    return _dbQueue;
}
-(NSMutableArray *)classNameArray{
    if (!_classNameArray) {
        _classNameArray = [NSMutableArray array];
    }
    return _classNameArray;
}
@end
