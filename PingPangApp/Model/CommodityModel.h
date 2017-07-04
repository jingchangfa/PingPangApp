//
//  CommodityModel.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/5/2.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ModelBase.h"

@interface CommodityModel : ModelBase
//下面就不写了 没嵌套了
@property (nonatomic,strong)NSString *STATE;
@property (nonatomic,strong)NSString *SINGLE_PRICE;
@property (nonatomic,strong)NSString *SELL_GOODSTYPE_ID;
@property (nonatomic,strong)NSString *BUY_ORDER_ID;
@property (nonatomic,strong)NSString *HEAD_IMAGE;
@property (nonatomic,strong)NSString *COUNT;
@property (nonatomic,strong)NSString *sellUserID;


@end
