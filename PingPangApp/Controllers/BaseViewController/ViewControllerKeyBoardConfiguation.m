
//
//  ViewControllerKeyBoardConfiguation.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/14.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ViewControllerKeyBoardConfiguation.h"
#import "IQKeyboardManager.h"//键盘

@implementation ViewControllerKeyBoardConfiguation
+ (void)KeyBoardSetingWithController:(ViewControllerBase *)controller{
    //keyboard
    [IQKeyboardManager sharedManager].enable = [self IQKeyboardManagerEnableWithController:controller];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = [self IQKeyboardManagerShouldResignOnTouchOutsideWithController:controller];
}

+ (BOOL)IQKeyboardManagerEnableWithController:(ViewControllerBase *)controller{
    if ([controller isKindOfClass: NSClassFromString(@"ViewController")] ||
        [controller isKindOfClass: NSClassFromString(@"KapMakeImageViewController")]) {
        return NO;
    }
    return NO;
}
+ (BOOL)IQKeyboardManagerShouldResignOnTouchOutsideWithController:(ViewControllerBase *)controller{
    return YES;
}
@end
