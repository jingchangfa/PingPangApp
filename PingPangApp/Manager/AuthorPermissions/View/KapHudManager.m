//
//  KapHudManager.m
//  KapEp
//
//  Created by jing on 16/11/24.
//  Copyright © 2016年 jing. All rights reserved.
//

#import "KapHudManager.h"
#import <UIKit/UIKit.h>
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
@interface KapHudManager ()

@end

@implementation KapHudManager

+ (KapHudManager *)shareHudManager{
   static KapHudManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KapHudManager alloc] init];
    });
    return manager;
}

+ (void)showSetingAlertWithTitle:(NSString *)title AndAgreeBlock:(JNullBlock)block{
    [self showSetingAlertWithTitle:title AndAgreeTitle:@"确定" AndRefuseTitle:@"取消" AndAgreeBlock:block];
}
+ (void)showSetingAlertWithTitle:(NSString *)title
                   AndAgreeTitle:(NSString *)agreeTitle
                  AndRefuseTitle:(NSString *)refuseTitle
                   AndAgreeBlock:(JNullBlock)block{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:refuseTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *seting = [UIAlertAction actionWithTitle:agreeTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        block();
    }];
    [alert addAction:cancle];
    [alert addAction:seting];
    [KapHudManager.getPresentedViewController presentViewController:alert animated:YES completion:nil];
}
#pragma mark get

//获取当前屏幕显示的Presented 出来的viewcontroller
+ (UIViewController *)getPresentedViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        if ([[topVC.presentedViewController class] isSubclassOfClass:[UINavigationController class]]) {
            topVC = ((UINavigationController *)topVC.presentedViewController).viewControllers.lastObject;
        }else{
            topVC = topVC.presentedViewController;
        }
    }
    if ([topVC.class isSubclassOfClass:[UIAlertController class]]) {//防止alert 自己pre自己
        topVC = topVC.presentingViewController;
    }
    return topVC;
}
@end
