//
//  ModelBase.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ModelBase.h"

@implementation ModelBase
+ (instancetype)click{
    return [[self alloc] init];
}
+ (instancetype)clickTwo{
    return [[[self class] alloc] init];
}



- (instancetype)initWithID:(NSNumber *)ID{
    self = [super init];
    if (self) {
        _ID = ID;
    }
    return self;
}

+ (Class)modelBaseClass{
    return [NSObject class];// 指向basemodel的base
}
+ (NSString *)mainKey{
    return @"ID";
}
+ (NSArray *)transients{
    return @[@"debugDescription",@"description",@"hash",@"superclass"];
}
@end
