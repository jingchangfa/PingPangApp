//
//  KapAuthorPermissionsManager.m
//  KapEp
//
//  Created by jing on 17/1/20.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "KapAuthorPermissionsManager.h"
#import "KapHudManager.h"

#import "PrefsCamera.h"
#import "PrefsMicrophone.h"
#import "PrefsPhoto.h"
#import "PrefsAddressBook.h"
#import "PrefsLocation.h"

@implementation KapAuthorPermissionsManager
+ (BOOL)KapAuthorPermissionWithStatus:(KapAuthorPermissions_status)status{
    __block BOOL havePermission = YES;
    __block Class authClass;
    __block NSString *title;
    [self getClassAndTitleStringByStatus:status AndFinishBlock:^(NSString *titleString, __unsafe_unretained Class class) {
        authClass = &*class;
        title = titleString;
    }];
    [authClass adjustPrivacySettingEnable:^(BOOL pFlag) {
        if (!pFlag) {
            //无权限
            havePermission = NO;
            [KapHudManager showSetingAlertWithTitle:title AndAgreeTitle:@"去设置" AndRefuseTitle:@"取消" AndAgreeBlock:^{
                [authClass openPrivacySetting];
            }];
        }
    }];
    return havePermission;
}

+ (void)getClassAndTitleStringByStatus:(KapAuthorPermissions_status)status
                        AndFinishBlock:(void(^)(NSString *titleString,Class class))finishBlock{
    if (!finishBlock) {
        return;
    }
    
    switch (status) {
        case KapAuthorPermissions_camera:
            finishBlock(@"允许访问相机",[PrefsCamera class]);
            break;
        case KapAuthorPermissions_mic:
            finishBlock(@"允许访问麦克风",[PrefsMicrophone class]);

            break;
        case KapAuthorPermissions_photo:
            finishBlock(@"允许访问相册",[PrefsPhoto class]);

            break;
        case KapAuthorPermissions_adress:
            finishBlock(@"允许访问通讯录",[PrefsAddressBook class]);

            break;
        case KapAuthorPermissions_location:
            finishBlock(@"允许访问位置",[PrefsLocation class]);
            
            break;
        default:
            break;
    }
}
@end
