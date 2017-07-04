//
//  UserAccountStore.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAccount.h"
//存储
@interface UserAccountStore : NSObject
+ (void)saveUserAccount:(UserAccount *)userAccount;
+ (UserAccount *)loadUserAccount;
@end
