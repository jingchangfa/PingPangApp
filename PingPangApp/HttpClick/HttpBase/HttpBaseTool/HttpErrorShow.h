//
//  HttpErrorShow.h
//  QRCodeBarCode
//
//  Created by jing on 17/3/3.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClickBase.h"
@interface HttpErrorShow : NSObject
- (void)httpErrorWithCode:(API_NET_ERROR_CODE)code AndMes:(NSString *)msg;
- (void)serverErrorWithCode:(API_SERVER_ERROR_CODE)code AndMes:(NSString *)msg;

@end
