//
//  ViewControllerBaseConfiguation.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ViewControllerBaseConfiguation.h"

@implementation ViewControllerBaseConfiguation
- (instancetype)initWithController:(ViewControllerBase *)controller{
    if (self = [super init]) {
        _controller = controller;
    }
    return self;
}

- (void)viewDidLoad{
    self.controller.view.backgroundColor = [UIColor whiteColor];//默认黑色
    /**
     * 黑色导航条(白色字体)
     */
    self.controller.isNavTranslucent = NO;
    self.controller.navTitleClolr = [UIColor whiteColor];
    self.controller.navBankColor = PCH_CUSTOM_BLUE_COLOR;
}
- (void)viewWillAppear{
    //不去掉导航栏的边界黑线
    self.controller.isNavShaowLineShow = NO;
    self.controller.isNavTranslucent = NO;
}
- (void)viewDidAppear{
    
}
- (void)viewWillDisappear{
    
}
- (void)viewDidDisappear{
    
}
@end
