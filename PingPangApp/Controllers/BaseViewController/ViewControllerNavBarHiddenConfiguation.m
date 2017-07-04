
//
//  ViewControllerNavBarHiddenConfiguation.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/13.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ViewControllerNavBarHiddenConfiguation.h"

@implementation ViewControllerNavBarHiddenConfiguation

#pragma mark - Private Methods
#pragma mark -
#pragma mark Whether need Navigation Bar Hidden
- (BOOL) needHiddenBarInViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass: NSClassFromString(@"xxViewController")]
        ||[viewController isKindOfClass: NSClassFromString(@"KapMakeImageViewController")]) {
        return YES;
    }
    return NO;
}

#pragma mark - UINaivgationController Delegate
#pragma mark -
#pragma mark Will Show ViewController
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [navigationController setNavigationBarHidden: [self needHiddenBarInViewController: viewController]
                                             animated: animated];
}
@end
