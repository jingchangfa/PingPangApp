//
//  NSString+Encryption.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
// 字符串加密,解密
@interface NSString (Encryption)
+ (NSString*) sha1: (NSString *)srcString;
+ (NSString*) sha512:(NSString*)srcString;

@end
