//
//  CeShiPeople.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/6.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ModelBase.h"
#import "CeShiCar.h"
#import "CeShiDog.h"

@interface CeShiPeople : ModelBase
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)CeShiCar *car;
@property (nonatomic, strong)NSArray *dogs;
@property (nonatomic, strong)NSDictionary *dic;
@property (nonatomic, strong)NSArray *arr;
@property (nonatomic, strong)NSNumber *sex;
@property (nonatomic, strong)NSString *location;
@end
