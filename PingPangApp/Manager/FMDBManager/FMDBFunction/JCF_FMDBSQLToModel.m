//
//  JCF_FMDBSQLToModel.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/7.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "JCF_FMDBSQLToModel.h"
#import "JCF_FMDBRunTimeModelInterface.h"
#import "JCF_FMDBTypeChange.h"

@implementation JCF_FMDBSQLToModel
- (instancetype)initWithModelClass:(Class)modelClass{
    if (self = [super init]) {
        _modelClass = modelClass;
    }
    return self;
}
+ (NSDictionary *)infoDictionaryByValue:(id)value AndClass:(Class)modelClass{
    JCF_FMDBRunTimeModelInterface *modelInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(modelClass)];
    return @{modelInterface.mainKeyPropertyName:value};
}
- (void)enumPropertyWithEnumBlcok:(JCF_GetModelValueBlock)block{
    if (!block) return;
    
    JCF_FMDBRunTimeModelInterface *modelInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(self.modelClass)];
    for (NSString *modelPropertyNameString in modelInterface.modelPropertyNameAndTypeDictionary.allKeys){
        NSString *propertyType = modelInterface.modelPropertyNameAndTypeDictionary[modelPropertyNameString];
        NSString *sqlType = [JCF_FMDBTypeChange sqlTypeStringByPropertyTypeString:propertyType];
        SQL_DATA_TYPE type = [self SQLDataTypeEnumBysqlTypeString:sqlType];
        block(modelPropertyNameString,type);
    }
}
- (SQL_DATA_TYPE)SQLDataTypeEnumBysqlTypeString:(NSString *)sqlTypeString{
    NSArray *sqlTypeArray = @[SQLTEXT,SQLINTEGER,SQLREAL,SQLBLOB,SQLNULL];
    return [sqlTypeArray indexOfObject:sqlTypeString];
}
- (void)enumModelArrayPropertyEnumBlock:(JCF_GetPropertyModelBlock)block{
    if (!block) return;
    JCF_FMDBRunTimeModelInterface *modelInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(self.modelClass)];
    if (modelInterface.haveModelArrayProperty) {
        for (NSDictionary *propertyDictionary in modelInterface.modelArrayPropertyArray) {
            NSString *propertyName = propertyDictionary[PropertyName];
            NSString *classNameString = propertyDictionary[PropertyType];
            JCF_FMDBRunTimeModelInterface *childrenInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:classNameString];
            NSString *sqlType = [JCF_FMDBTypeChange sqlTypeStringByPropertyTypeString:childrenInterface.mainKeyPropertyType];
            SQL_DATA_TYPE type = [self SQLDataTypeEnumBysqlTypeString:sqlType];
            block(propertyName,NSClassFromString(classNameString),type);
        }
    }
}
- (void)enumModelPropertyEnumBlock:(JCF_GetPropertyModelBlock)block{
    if (!block) return;
    JCF_FMDBRunTimeModelInterface *modelInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(self.modelClass)];
    if (modelInterface.haveModelProperty) {
        for (NSDictionary *propertyDictionary in modelInterface.modelPropertyArray) {
            NSString *propertyName = propertyDictionary[PropertyName];
            NSString *classNameString = propertyDictionary[PropertyType];
            JCF_FMDBRunTimeModelInterface *childrenInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:classNameString];
            NSString *sqlType = [JCF_FMDBTypeChange sqlTypeStringByPropertyTypeString:childrenInterface.mainKeyPropertyType];
            SQL_DATA_TYPE type = [self SQLDataTypeEnumBysqlTypeString:sqlType];
            block(propertyName,NSClassFromString(classNameString),type);
        }
    }
}

@end
