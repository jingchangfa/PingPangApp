//
//  PrefsLocation.m
//  KapEp
//
//  Created by jing on 17/1/20.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "PrefsLocation.h"
#import <CoreLocation/CoreLocation.h>
@implementation PrefsLocation
+ (NSString *)getPrefsURL{
    
    return @"prefs:root=Privacy&path=LOCATION_SERVICES";
}

+ (void)adjustPrivacySettingEnable:(void(^)(BOOL pFlag))block{
    
    if(block){
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        // kCLAuthorizationStatusNotDetermined                  //用户尚未对该应用程序作出选择
        // kCLAuthorizationStatusRestricted                     //应用程序的定位权限被限制
        // kCLAuthorizationStatusAuthorizedAlways               //一直允许获取定位
        // kCLAuthorizationStatusAuthorizedWhenInUse            //在使用时允许获取定位
        // kCLAuthorizationStatusAuthorized                     //已废弃，相当于一直允许获取定位
        // kCLAuthorizationStatusDenied                         //拒绝获取定位
        if(![CLLocationManager locationServicesEnabled] || status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied){
            block(NO);
        }else{
            block(YES);
        }
    }
}
@end
