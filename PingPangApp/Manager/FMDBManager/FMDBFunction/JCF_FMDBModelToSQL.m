//
//  JCF_FMDBModelToSQL.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/7.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "JCF_FMDBModelToSQL.h"
#import "JCF_FMDBRunTimeModelInterface.h"
#import "JCF_FMDBTypeChange.h"
#import "JCF_FMDBConfiguration.h"

@implementation JCF_FMDBModelToSQL
@synthesize propertyDictionaryArray = _propertyDictionaryArray;
@synthesize mineModelDictionary = _mineModelDictionary;
- (instancetype)initWithModel:(NSObject<JCF_FMDBModelProtocol> *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}
- (NSArray<NSDictionary *> *)propertyDictionaryArray{
    if (!_propertyDictionaryArray) {
        [self analysisModel];
    }
    return _propertyDictionaryArray;
}
- (NSDictionary *)mineModelDictionary{
    if (!_mineModelDictionary) {
        [self analysisModel];
    }
    return _mineModelDictionary;
}
- (void)analysisModel{
    _propertyDictionaryArray = [self modelAnalysisByModel:_model];
}
#pragma mark 此方法只负责处理一层，无需处理嵌套关系，将model转化为特定格式的Dictionry
/**
 一个model实际可能是若干个sql语句(model 嵌套的原因) 递归～
 * 先处理嵌套的model
 * 最后把基础数据拼接进去
 */
- (NSArray *)modelAnalysisByModel:(NSObject<JCF_FMDBModelProtocol> *)model{
    NSArray *modelRecursiveArray = [self modelRecursiveWithModel:model];
    
    NSMutableArray *propertyDictionaryArray = [NSMutableArray array];
    for (NSDictionary *oneModelRecursiveDictionary in modelRecursiveArray) {
        NSMutableArray *oneModelPropertyDictionaryArray = [NSMutableArray array];
        JCF_FMDBRunTimeModelInterface *modelInterface = oneModelRecursiveDictionary[PropertyClassInterface];
        NSObject<JCF_FMDBModelProtocol> *oneModel = oneModelRecursiveDictionary[PropertyValue];
        
        for (NSString *modelPropertyNameString in modelInterface.modelPropertyNameAndTypeDictionary.allKeys){
            NSString *propertyType = modelInterface.modelPropertyNameAndTypeDictionary[modelPropertyNameString];
            NSString *sqlType = [JCF_FMDBTypeChange sqlTypeStringByPropertyTypeString:propertyType];
            id value = [oneModel valueForKey:modelPropertyNameString];
            // 字典数组转化json串
            NSString *jsonString = [self modelArrayOrDictionaryPropertyTojson:value];
            if (jsonString) {
                value = jsonString;
            }
            //下面俩if 将model转化为model的主键
            if ([modelInterface.modelArrayPropertyNameArray containsObject:modelPropertyNameString]) {//内嵌modelArray
                NSInteger index = [modelInterface.modelArrayPropertyNameArray indexOfObject:modelPropertyNameString];
                NSDictionary *propertyDic = modelInterface.modelArrayPropertyArray[index];
                NSString *className = propertyDic[PropertyType];
                JCF_FMDBRunTimeModelInterface *propertyClassInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:className];
                
                NSMutableArray *modelMainKeyValue = [NSMutableArray array];
                NSArray *modelsArray = value;
                for (NSObject<JCF_FMDBModelProtocol> *arrayModel in modelsArray) {
                    id MainKey = [arrayModel valueForKey:propertyClassInterface.mainKeyPropertyName];
                    [modelMainKeyValue addObject:MainKey];
                }
                value = [JCF_FMDBConfiguration arrayToJSONString:modelMainKeyValue];
            }
            if ([modelInterface.modelPropertyNameArray containsObject:modelPropertyNameString]) {//内嵌model
                NSInteger index = [modelInterface.modelPropertyNameArray indexOfObject:modelPropertyNameString];
                NSDictionary *propertyDic = modelInterface.modelPropertyArray[index];
                NSString *className = propertyDic[PropertyType];
                JCF_FMDBRunTimeModelInterface *propertyClassInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:className];
                value = [value valueForKey:propertyClassInterface.mainKeyPropertyName];
            }
            if (!value) {
                value = [NSNull null];
            }
            [oneModelPropertyDictionaryArray addObject:@{PropertyName:modelPropertyNameString,
                                                         PropertyType:propertyType,
                                                         SQLType:sqlType,
                                                         PropertyValue:value}];
        }
        // 生成解析数据，并存储
        NSDictionary *oneModelDictionary = @{PropertyType:modelInterface.className,
                                             PropertyModelMainKey:modelInterface.mainKeyPropertyName,
                                             PropertyMainValue:[oneModel valueForKey:modelInterface.mainKeyPropertyName],
                                             PropertyValue:oneModelPropertyDictionaryArray};
        if (oneModelRecursiveDictionary[PropertyName] == PropertyModelThis) {
            _mineModelDictionary = oneModelDictionary;
        }
        [propertyDictionaryArray addObject:oneModelDictionary];
    }
    return  propertyDictionaryArray;
}

#pragma mark 下面三个方法的作用递归解析model,纵向关系变为横向关系
/**
 递归
 * modelRecursiveWithModel 要解析的主体model
 * modelArrayRecursiveWithArray 递归讲纵向关系变为横向关系
 */
- (NSArray *)modelRecursiveWithModel:(NSObject<JCF_FMDBModelProtocol> *)model{
    NSMutableArray *allModelsArray = [NSMutableArray array];
    JCF_FMDBRunTimeModelInterface *modelInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(model.class)];
    NSArray *modelArray = @[@{
                                PropertyValue:model,
                                PropertyName:PropertyModelThis,
                                PropertyClassInterface:modelInterface
                                }];
    [self modelArrayRecursiveWithArray:modelArray AndSaveMutableArray:allModelsArray];
    return allModelsArray;
}
- (void)modelArrayRecursiveWithArray:(NSArray *)modelDictionaryArray AndSaveMutableArray:(NSMutableArray *)saveArray{
    if (modelDictionaryArray.count == 0) {
        return ;
    }
//    static int tag = 0;
//    NSLog(@"总计执行次数+%d",tag++);
    [saveArray addObjectsFromArray:modelDictionaryArray];
    for (NSDictionary *modelDictionary in modelDictionaryArray) {
        NSObject<JCF_FMDBModelProtocol> *model = modelDictionary[PropertyValue];
        modelDictionaryArray = [self modelVerticalDependenceToHorizontalDependence:model];
        [self modelArrayRecursiveWithArray:modelDictionaryArray AndSaveMutableArray:saveArray];
    }
}
// 一个model为单位找到其嵌套的子model
- (NSArray *)modelVerticalDependenceToHorizontalDependence:(NSObject<JCF_FMDBModelProtocol> *)model{
    NSMutableArray *modelHorizontalDependenceArray = [NSMutableArray array];
    JCF_FMDBRunTimeModelInterface *modelInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:NSStringFromClass(model.class)];
    //有嵌套model数组
    if (modelInterface.haveModelArrayProperty) {
        for (NSDictionary *dic in modelInterface.modelArrayPropertyArray) {
            NSString *propertyName = dic[PropertyName];
            NSString *propertyType = dic[PropertyType];
            NSArray *value = [model valueForKey:propertyName];
            if (!value) {
                continue;
            }
            JCF_FMDBRunTimeModelInterface *childrenInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:propertyType];
            
            for (NSObject<JCF_FMDBModelProtocol> *obj in value) {
                [modelHorizontalDependenceArray addObject:@{
                                                            PropertyValue:obj,
                                                            PropertyName:propertyName,
                                                            PropertyClassInterface:childrenInterface
                                                            }];
            }
        }
    }
    //嵌套model
    if (modelInterface.haveModelProperty) {
        for (NSDictionary *dic in modelInterface.modelPropertyArray) {
            NSString *propertyName = dic[PropertyName];
            NSString *propertyType = dic[PropertyType];
            NSObject<JCF_FMDBModelProtocol> *value = [model valueForKey:propertyName];
            if (!value) {
                continue;
            }
            JCF_FMDBRunTimeModelInterface *childrenInterface = [JCF_FMDBRunTimeModelInterface ModelInterfaceCacheByModelClassName:propertyType];
            [modelHorizontalDependenceArray addObject:@{
                                                        PropertyValue:value,
                                                        PropertyName:propertyName,
                                                        PropertyClassInterface:childrenInterface
                                                        }];
        }
    }
    return modelHorizontalDependenceArray;
}
#pragma mark 字典 数组转化为json
- (NSString *)modelArrayOrDictionaryPropertyTojson:(id)value{
    NSString *jsonString = nil;
    jsonString = [JCF_FMDBConfiguration toJson:value];
    if (jsonString) {
        NSLog(@"一个jsonObj%@转化为jsonstring->%@",value,jsonString);
    }
    return jsonString;
}
@end

//Class People{
//    NSArray *dogsArray;
//}
//Class Dog{
//    NSArray *peoplesArray;
//}
//{
//    Dog *dog1 = Dog.init();
//    dog1.peoplesArray = @[People.init(1)];
//    Dog *dog2 = Dog.init();
//    dog2.peoplesArray = @[People.init(2),People.init(3)];
//    Dog *dog3 = Dog.init();
//    dog3.peoplesArray = @[People.init(4),People.init(5),People.init(6)];
//    People *people = People.init()
//    people.dogsArray = @[dog1,dog2,dog3];
//
//    //如何 把 people 解析开 把纵向变为横向(变成如下所示)
//    NSArray *arrr = [people,dog1,dog2,dog3,People.init(1),People.init(2),People.init(3),People.init(4),People.init(5),People.init(6)];
//}
