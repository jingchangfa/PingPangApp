//
//  JCF_FMDBModelProtocol.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JCF_FMDBModelProtocol <NSObject>
/**
 * 如果model类中有一些property不需要创建数据库字段，那么这个方法必须在子类中重写
 * @[@"name",@"age"]; 属性名
 * 避免继承，必须要用类方法
 */
+ (NSArray *)transients;
/**
 * 每个类必须设置主键
 * 主键必须是已经存在的属性  eg: ID
 * 必须实现其中一个
 */
+ (NSString *)mainKey;//优先调用此方法获取
- (NSString *)mainKey;//可继承  例如所有的ID 都是主键 则在base 直接 return @"ID"
/**
 * 指定父类
 * 不指定 递归获取属性的时候 直到 nsonject为止
 */
+ (Class)modelBaseClass;
/**
 用runtime 检测类方法
 * model 的嵌套        (属性名+JCF+Model)
 * modelArray 的嵌套   (属性名+JCF+ModelArray)
 */
//+ (Class)xxxJCFModel;
//+ (Class)xxxJCFModelArray;
@end
