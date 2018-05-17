//
//  KapFMDBManager.m
//  KapEp
//
//  Created by jing on 2017/10/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "KapFMDBManager.h"
#import "KapAuthManagerHeader.h"
@interface KapFMDBManager ()
@property (nonatomic,strong)JCF_FMDBManager *modelManager;
@end
@implementation KapFMDBManager
static KapFMDBManager *manager = nil;
+ (KapFMDBManager *)KapLocationSaveManagerShare{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KapFMDBManager alloc] init];
    });
    return manager;
}

#pragma mark 更新单个
+ (BOOL)KapFMDBUpdataModelByType:(MODEL_MANAGER_TYPE)type
                       WithModel:(NSObject <JCF_FMDBModelProtocol>*)model{
     return [[self KapLocationSaveManagerShare].modelManager updataModelByType:type WithModel:model];
}

#pragma mark 批量更新
+ (void)KapFMDBUpdateModelsByType:(MODEL_MANAGER_TYPE)type
                       WithModels:(NSArray <NSObject <JCF_FMDBModelProtocol>*> *)models
                   AndFinishBlock:(JCF_ResultBlock)block{
    [[self KapLocationSaveManagerShare].modelManager updateModelsByType:type WithModels:models AndFinishBlock:block];
}

#pragma mark 条件查找
+ (NSArray *)KapFMDBSearchModelsByModelClass:(Class)modelClass AndSearchPropertyDictionary:(NSDictionary *)propertyDictionary{
    return [[self KapLocationSaveManagerShare].modelManager searchModelsByModelClass:modelClass AndSearchPropertyDictionary:propertyDictionary];
}
#pragma mark 退出登录，因为路径是靠userid生成的所以退出登录的时候要清除一下
+ (void)KapFMDBLogOut{
    [self KapLocationSaveManagerShare].modelManager = nil;
}

//get
-(JCF_FMDBManager *)modelManager{
    if (!_modelManager) {
        NSString *string = @"KapEp";
        if (self.userID) {
            string = [NSString stringWithFormat:@"KapEpUser%@",self.userID];
        }
        _modelManager = [[JCF_FMDBManager alloc] initWithDataBaseName:string];
    }
    return _modelManager;
}
#pragma mark 此处自己配置ID
- (NSNumber *)userID{
    return [UserAccount loadActiveUserAccount].userID;
}
@end
