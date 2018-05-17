//
//  UserAccountInfoAdditional.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "UserAccountInfoAdditional.h"
#import "MJExtension.h"

@implementation UserAccountInfoAdditional
// 实现归档，接档
MJExtensionCodingImplementation
+(NSArray *)mj_allowedCodingPropertyNames{
    // 返回归档的属性
    return @[@"ID",@"address",@"upload",@"image"];
}

- (instancetype)initWithDictionary:(NSDictionary *)infoAdditionalDictionary{
    if (self = [super init]) {
        _ID = infoAdditionalDictionary[@"id"];
        _address = infoAdditionalDictionary[@"address"];
        _upload = infoAdditionalDictionary[@"upload"];
        _image = infoAdditionalDictionary[@"image"];
    }
    return self;
}
@end
