//
//  KapHudManager.h
//  KapEp
//
//  Created by jing on 16/11/24.
//  Copyright © 2016年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface KapHudManager : NSObject
typedef void(^JNullBlock)();
#pragma mark alert
+ (void)showSetingAlertWithTitle:(NSString *)title AndAgreeBlock:(JNullBlock)block;
+ (void)showSetingAlertWithTitle:(NSString *)title
                   AndAgreeTitle:(NSString *)agreeTitle
                  AndRefuseTitle:(NSString *)refuseTitle
                   AndAgreeBlock:(JNullBlock)block;

@end
