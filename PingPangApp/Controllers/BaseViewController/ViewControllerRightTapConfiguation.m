//
//  ViewControllerRightTapConfiguation.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/14.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ViewControllerRightTapConfiguation.h"

@implementation ViewControllerRightTapConfiguation
- (instancetype)initWithController:(ViewControllerBase *)controller{
    if (self = [super init]) {
        _controller = controller;
    }
    return self;
}

- (void)addTapGestureRecognizer{
    self.controller.navigationController.interactivePopGestureRecognizer.enabled = NO;
    id target = self.controller.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.controller.view addGestureRecognizer:pan];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 禁止制定页面的侧滑返回
    if ([self.controller isKindOfClass: NSClassFromString(@"ViewController")] ||
        [self.controller isKindOfClass: NSClassFromString(@"KapMakeImageViewController")]) {
        return NO;
    }
    if (self.controller.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    return YES;
}
@end
