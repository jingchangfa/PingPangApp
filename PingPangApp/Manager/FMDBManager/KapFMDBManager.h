//
//  KapFMDBManager.h
//  KapEp
//
//  Created by jing on 2017/10/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCF_FMDBManager.h"


@interface KapFMDBManager : NSObject

#pragma mark 更新单个
+ (BOOL)KapFMDBUpdataModelByType:(MODEL_MANAGER_TYPE)type
                   WithModel:(NSObject <JCF_FMDBModelProtocol>*)model;

#pragma mark 批量更新
+ (void)KapFMDBUpdateModelsByType:(MODEL_MANAGER_TYPE)type
                   WithModels:(NSArray <NSObject <JCF_FMDBModelProtocol>*> *)models
               AndFinishBlock:(JCF_ResultBlock)block;

#pragma mark 条件查找
+ (NSArray *)KapFMDBSearchModelsByModelClass:(Class)modelClass AndSearchPropertyDictionary:(NSDictionary *)propertyDictionary;

#pragma mark 退出登录，因为路径是靠userid生成的所以退出登录的时候要清除一下
+ (void)KapFMDBLogOut;
@end
