//
//  ViewControllerBaseConfiguationDelegate.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewControllerBaseConfiguationDelegate <NSObject>
- (void)viewDidLoad;
- (void)viewWillAppear;
- (void)viewDidAppear;
- (void)viewWillDisappear;
- (void)viewDidDisappear;
@end
