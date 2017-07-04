//
//  ModelBase.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//
/**
  model 自带持久化功能（model为单位 增删改查）
 * 基于fmdb
 递归的套路 ～ ～ ～
 
 * 增改的流程:
 类名:作为表名
 属性名:作为列名
 model嵌套(实现协议嵌套的协议):建新表，主键作为value，增加或者更新嵌套的model
 model数组(实现数组嵌套的协议):for 主键 数组转 json
 
 * 查的流程:
 model嵌套(实现协议嵌套的协议):去指定表查到model拼接起来，返回完整的model
 model数组(实现数组嵌套的协议):for 主键 数组转 json

 * 删的流程:
 只删除本数据不删除关联数据
 
 manager: 负责各个组件的协调
 configuration:配置文件，数据库路径之类的
 协议: model 定制化设置
 sql语句管理: 生成sql语句
 model转换器: 
    存: model 和 model 数组 存到指定表内存model，存主键
    取: model 和 model 数组 去指定表根据主键查出来，付给model 返回
 */
#import <Foundation/Foundation.h>
#import "JCF_FMDBModelProtocol.h"
#import "MJExtension.h"
@interface ModelBase : NSObject <JCF_FMDBModelProtocol>
@property (nonatomic,strong)NSNumber *ID;
- (instancetype)initWithID:(NSNumber *)ID;
+ (instancetype)click;
+ (instancetype)clickTwo;
@end
