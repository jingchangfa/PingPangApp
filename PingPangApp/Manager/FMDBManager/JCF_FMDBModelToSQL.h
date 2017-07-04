//
//  JCF_FMDBModelToSQL.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/7.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCF_FMDBModelProtocol.h"
// model往数据库存的转化的工具类类
// 将model转化为制定格式的 dictionary
@interface JCF_FMDBModelToSQL : NSObject
/**
 * initWithModel: 解析model的初始化方法(增删改)
 */
- (instancetype)initWithModel:(NSObject<JCF_FMDBModelProtocol> *)model;
@property (nonatomic,readonly)NSObject<JCF_FMDBModelProtocol> *model;
/**
 //{
 //    propertyType = CeShiPeople;
 //    propertyModelMainKey = ID;
 //    propertyValue =     (
 //                         {
 //                             propertyName = dogs;
 //                             propertyType = "T@\"NSArray\",&,N,V_dogs";
 //                             propertyValue = "[\n  11,\n  11,\n  11\n]";
 //                             sqlType = TEXT;
 //                         },
 //                         {
 //                             propertyName = ID;
 //                             propertyType = "T@\"NSNumber\",&,N,V_ID";
 //                             propertyValue = 11;
 //                             sqlType = REAL;
 //                         },
 //                         {
 //                             propertyName = car;
 //                             propertyType = "T@\"CeShiCar\",&,N,V_car";
 //                             propertyValue = 11;
 //                             sqlType = REAL;
 //                         },
 //                         {
 //                             propertyName = name;
 //                             propertyType = "T@\"NSString\",&,N,V_name";
 //                             propertyValue = "";
 //                             sqlType = TEXT;
 //                         }
 //                         );
 //}
 */
@property (nonatomic,readonly)NSDictionary *mineModelDictionary;
@property (nonatomic,readonly)NSArray<NSDictionary *> *propertyDictionaryArray;
@end
