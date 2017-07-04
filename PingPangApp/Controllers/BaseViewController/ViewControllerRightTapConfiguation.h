//
//  ViewControllerRightTapConfiguation.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/14.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewControllerBase.h"
// 此类处理右划返回
@interface ViewControllerRightTapConfiguation : NSObject<UIGestureRecognizerDelegate>
- (instancetype)initWithController:(ViewControllerBase *)controller;
@property (nonatomic,weak,readonly)ViewControllerBase *controller;

- (void)addTapGestureRecognizer;
@end
