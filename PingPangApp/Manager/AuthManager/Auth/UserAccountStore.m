//
//  UserAccountStore.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "UserAccountStore.h"

@implementation UserAccountStore

+ (UserAccount *)loadUserAccount{
    NSNumber *userID = [self loadCurrentUserID];
    if (!userID || userID.intValue == -1) return nil;
    NSString * filePath = [self getUserAccountFilePathByID:userID];
    UserAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return account;
}
+ (void)saveUserAccount:(UserAccount *)userAccount{
    NSNumber *userID = userAccount.userID;
    if(!userAccount){
        // 注销当前账户
        [self saveCurrentUserID:@(-1)];
        return;
    }
    [self saveCurrentUserID:userID];
    NSString * filePath = [self getUserAccountFilePathByID:userID];
    [NSKeyedArchiver archiveRootObject:userAccount toFile:filePath];
}

#define KEY_ACTIVE_USER_ID  @"active_user_id"
+ (NSNumber *)loadCurrentUserID{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber * userID = [userDefaults objectForKey:KEY_ACTIVE_USER_ID];
    return userID;
}
+ (void)saveCurrentUserID:(NSNumber *)userID{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userID forKey:KEY_ACTIVE_USER_ID];
    [userDefaults synchronize];
}



















#pragma mark 获取存储路径
+ (NSString *)getUserAccountFilePathByID:(NSNumber *)userID
{
    NSString * folder = [self getStorageFolder];
    NSString * filePath = [folder stringByAppendingPathComponent:[NSString stringWithFormat:@"u%@", userID]];
    
    return filePath;
}
#define USER_ACCOUNT_FOLDER  @"usr_acc"
+ (NSString *)getStorageFolder
{
    NSString * folder = [[self getAppDocumentDir] stringByAppendingPathComponent:USER_ACCOUNT_FOLDER];
    [self checkDirectory:folder createIfNotExist:YES];
    return folder;
}
+ (NSString *)getAppDocumentDir
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask,
                                                YES) objectAtIndex:0];
    
}
+ (BOOL)checkDirectory:(NSString *)directory createIfNotExist:(BOOL)create
{
    if (!directory || [directory isEqualToString:@""])
        return FALSE;
    
    BOOL isDir;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:directory
                                                       isDirectory:&isDir];
    
    if (exists && !isDir)
    {
        if (create)
        {
            // 存在但不是文件夹，且需要创建文件夹
            [[NSFileManager defaultManager] removeItemAtPath:directory
                                                       error:nil];
        }
        
        exists = NO;
    }
    
    // 不存在，且需要创建
    if (!exists && create)
    {
        exists = [[NSFileManager defaultManager] createDirectoryAtPath:directory
                                           withIntermediateDirectories:YES
                                                            attributes:nil
                                                                 error:nil];
    }
    return exists;
}



@end
