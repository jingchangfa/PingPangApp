//
//  OrderModel.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/5/2.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ModelBase.h"
@class CommodityModel;
@interface OrderModel : ModelBase
@property (nonatomic,strong)NSString *sellUserID;
@property (nonatomic,assign)NSInteger sellTotalPrice;
@property (nonatomic,strong)NSString *state;
@property (nonatomic,strong)NSString *buyUserID;
@property (nonatomic,strong)NSString *buyOrderID;
@property (nonatomic,strong)NSArray<CommodityModel *> *child;

@property (nonatomic,strong)NSString *HEAD_IMAGE;


@end
