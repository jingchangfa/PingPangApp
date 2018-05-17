//
//  UserAccount.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "UserAccount.h"
#import "UserAccountStore.h"
#import "MJExtension.h"
@implementation UserAccount
// 归档接档
MJExtensionCodingImplementation
+(NSArray *)mj_allowedCodingPropertyNames{
    // 返回归档的属性
    return @[@"userID",@"userToken",@"additional"];
}

- (UserAccount *)initWithID:(NSNumber *)userID
                      token:(NSString *)token
             herdDictionary:(NSDictionary *)herdDictionary{
    if (self = [super init]) {
        _userID = userID;
        _userToken = token;
        _additional = [[UserAccountInfoAdditional alloc] initWithDictionary:herdDictionary];
    }
    return self;
}

+ (UserAccount *)loadActiveUserAccount{
   return [UserAccountStore loadUserAccount];
}
+ (void)saveActiveUserAccount:(UserAccount *)userAccount{
    [UserAccountStore saveUserAccount:userAccount];
}
@end
