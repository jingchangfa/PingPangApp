//
//  UserAccountInfoAdditional.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
// 额外信息补充
@interface UserAccountInfoAdditional : NSObject
@property (nonatomic, readonly) NSNumber * ID;
@property (nonatomic, readonly) NSString * address;
@property (nonatomic, readonly) NSString * upload;
@property (nonatomic, readonly) NSString * image;

- (instancetype)initWithDictionary:(NSDictionary *)infoAdditionalDictionary;
@end
