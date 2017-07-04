//
//  JCF_FMDBRunTimeModelInterface.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "JCF_FMDBBlockHeader.h"

//解析class的工具类
@interface JCF_FMDBRunTimeModelInterface : NSObject
// 优先取缓存,没有内部init一个,这样就可以随便用,不用担心性能问题了
+ (JCF_FMDBRunTimeModelInterface *)ModelInterfaceCacheByModelClassName:(NSString *)className;
//- (instancetype)initWithModelClassName:(NSString *)className;

@property (nonatomic,readonly)Class modelClass;
@property (nonatomic,readonly)NSString *className;

/*
 * mainKeyPropertyName 主键的属性名
 * mainKeyPropertyType 主键的类型
 * modelPropertyNameAndTypeDictionary <属性名 : 属性类型>
 */
@property (nonatomic,strong)NSString *mainKeyPropertyName;
@property (nonatomic,strong)NSString *mainKeyPropertyType;

@property (nonatomic,strong)NSDictionary *modelPropertyNameAndTypeDictionary;
@property (nonatomic,assign)BOOL haveModelArrayProperty;
@property (nonatomic,assign)BOOL haveModelProperty;
/*
 * modelArrayPropertyNameArray 只存的model属性名
 * modelArrayPropertyArray dic<model的class,属性名>
 (
    {
        propertyName = car;
        propertyType = CeShiCar;
    }
 )
 * modelPropertyNameArray 只存的array属性名
 * modelPropertyArray dic<属性名,属性类型的class>
 (
    {
        propertyName = dogs;
        propertyType = CeShiDog;
    }
 )
 */

@property (nonatomic,strong)NSArray *modelArrayPropertyNameArray;
@property (nonatomic,strong)NSArray <NSDictionary <NSString *,NSString *>*>* modelArrayPropertyArray;

@property (nonatomic,strong)NSArray *modelPropertyNameArray;
@property (nonatomic,strong)NSArray <NSDictionary <NSString *,NSString *>*>* modelPropertyArray;

@end
