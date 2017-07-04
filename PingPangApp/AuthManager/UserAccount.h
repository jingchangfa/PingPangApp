//
//  UserAccount.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAccountInfoAdditional.h"
// 账户管理
@interface UserAccount : NSObject
@property (nonatomic, readonly) NSNumber * userID;
@property (nonatomic, readonly) NSString * userToken;
@property (nonatomic, readonly) UserAccountInfoAdditional * additional;


- (UserAccount *)initWithID:(NSNumber *)userID
                      token:(NSString *)token
             herdDictionary:(NSDictionary *)herdDictionary;

+ (UserAccount *)loadActiveUserAccount;
+ (void)saveActiveUserAccount:(UserAccount *)userAccount;
@end
