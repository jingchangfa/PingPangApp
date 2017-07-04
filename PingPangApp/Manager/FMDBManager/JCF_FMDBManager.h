//
//  JCF_FMDBManager.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//

/**
 * 管理类
 1. 先解析class
 2. 再解析实例对象
 3. 解析之后生成sql语句
 4. 调用fmdb执行sql语句
 */

#import <Foundation/Foundation.h>
#import "JCF_FMDBBlockHeader.h"
#import "JCF_FMDBModelProtocol.h"
// 只有删除和更新，更新先add add失败则change
typedef NS_ENUM(NSInteger) {
//    MODEL_MANAGER_TYPE_ADD = 0,
    MODEL_MANAGER_TYPE_REM = 1,
    MODEL_MANAGER_TYPE_CHANGE = 2
}MODEL_MANAGER_TYPE;

@interface JCF_FMDBManager : NSObject
/**
 注意
 * 注意
 * 注意
 * 注意
 * 若A持有B,B持有A 会造成死循环～
 **/

#pragma mark 创建根据唯一标识符,设计上一个用户一个数据库
-(instancetype)initWithDataBaseName:(NSString *)name;

#pragma mark 批量___增删改
- (BOOL)updataModelByType:(MODEL_MANAGER_TYPE)type
                WithModel:(NSObject <JCF_FMDBModelProtocol>*)model;

#pragma mark 单个___增删改
- (void)updateModelsByType:(MODEL_MANAGER_TYPE)type
                WithModels:(NSArray <NSObject <JCF_FMDBModelProtocol>*> *)models
            AndFinishBlock:(JCF_ResultBlock)block;

#pragma mark 条件查找
/**
 查找
 * 1. nil 查找所有的
 * 2. @{@"主键" : @"主键值"}
 * 3. 复杂查询没弄～
 */
- (NSArray *)searchModelsByModelClass:(Class)modelClass AndSearchPropertyDictionary:(NSDictionary *)infoDictionary;
@end
