//
//  HttpLogInClick.h
//  QRCodeBarCode
//
//  Created by jing on 17/3/6.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "HttpClickBase.h"

//调用
/**
 NSDictionary *dic = @{
 @"mobile" : @"+8615810544001",
 @"password" : @"7e6bb0121c0eed1d439b172a2673ae17c3c6cfc0245252d07e70f9ee5cf4cdbc51b35c131694fe53cb99f3c5ccba3b55535a1013107294cff8bb4ed8c2ccd851"
 };
 [[HttpLogInClick client] httpLoginAuthLoginWithDictionAry:dic WithSuccessBlock:^(UserModel *user) {
 
 } AndFailure:^(NSInteger errorCode, NSString *errorMsg) {
 
 }];
 */

//使用 实例
@interface HttpLogInClick : HttpClickBase
- (void)httpLoginAuthLoginWithDictionAry:(NSDictionary *)dic WithSuccessBlock:(void(^)())success AndFailure:(defaultFailureBlock)failure;
@end
