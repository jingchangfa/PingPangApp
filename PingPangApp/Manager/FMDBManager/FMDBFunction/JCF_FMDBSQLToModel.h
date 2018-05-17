//
//  JCF_FMDBSQLToModel.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/7.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCF_FMDBModelProtocol.h"
#import "JCF_FMDBBlockHeader.h"
// 从sql 获取 数据 转化为model的工具类
// 好麻烦～
// 递归放外面了只能,只能作为工具，没有算法没有逻辑～
@interface JCF_FMDBSQLToModel : NSObject
/**
 * 初始化
 * 生成条件检索的infoDictionary
 */
- (instancetype)initWithModelClass:(Class)modelClass;
@property(nonatomic,readonly)Class modelClass;
+ (NSDictionary *)infoDictionaryByValue:(id)value AndClass:(Class)modelClass;
- (void)enumPropertyWithEnumBlcok:(JCF_GetModelValueBlock)block;
/**
 * enumModelArrayPropertyEnumBlock 有嵌套的model数组属性
 * enumModelPropertyEnumBlock 有嵌套的model属性
 */
- (void)enumModelArrayPropertyEnumBlock:(JCF_GetPropertyModelBlock)block;
- (void)enumModelPropertyEnumBlock:(JCF_GetPropertyModelBlock)block;
@end
