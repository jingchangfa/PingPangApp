//
//  ViewControllerBaseConfiguation.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewControllerBaseConfiguationDelegate.h"
#import "ViewControllerBase.h"
/**
 根据项目需求自己配置统一风格的nav的状态
 */
@interface ViewControllerBaseConfiguation : NSObject<ViewControllerBaseConfiguationDelegate>
- (instancetype)initWithController:(ViewControllerBase *)controller;
@property (nonatomic,weak,readonly)ViewControllerBase *controller;
@end
