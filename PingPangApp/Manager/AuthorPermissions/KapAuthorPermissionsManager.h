//
//  KapAuthorPermissionsManager.h
//  KapEp
//
//  Created by jing on 17/1/20.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger){
    KapAuthorPermissions_camera = 0,
    KapAuthorPermissions_mic = 1,
    KapAuthorPermissions_photo = 2,
    KapAuthorPermissions_adress = 3,
    KapAuthorPermissions_location = 4
} KapAuthorPermissions_status;

@interface KapAuthorPermissionsManager : NSObject
+ (BOOL)KapAuthorPermissionWithStatus:(KapAuthorPermissions_status)status;


@end
