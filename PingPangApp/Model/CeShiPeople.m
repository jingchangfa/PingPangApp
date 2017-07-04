
//
//  CeShiPeople.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "CeShiPeople.h"

@implementation CeShiPeople
+ (Class)carJCFModel{
    return [CeShiCar class];
}
+ (Class)dogsJCFModelArray{
    return [CeShiDog class];
}
@end
