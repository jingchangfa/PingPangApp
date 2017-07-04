//
//  ViewBaseInterface.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+FrameLayout.h"//frame布局相关的辅助方法
//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"//Masonry 布局

@protocol ViewBaseInterface <NSObject>
/**
 * bankViewInit  方法内添加子视图
 * layoutsubviews 方法内设置frame
 */
- (void)bankViewInit;
@end
