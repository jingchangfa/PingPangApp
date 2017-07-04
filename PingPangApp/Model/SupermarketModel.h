//
//  SupermarketModel.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/5/2.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ModelBase.h"
@class OrderModel;
@interface SupermarketModel : ModelBase
@property (nonatomic,strong)NSString *headImage;
@property (nonatomic,strong)NSArray<OrderModel *> *child;
@property (nonatomic,strong)NSString *sellOrderID;
@property (nonatomic,strong)NSString *state;
@property (nonatomic,strong)NSString *buyUserID;
@property (nonatomic,strong)NSString *superMaketName;
@end
