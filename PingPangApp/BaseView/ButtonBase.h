//
//  ButtonBase.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewBaseInterface.h"
@interface ButtonBase : UIButton<ViewBaseInterface , UIGestureRecognizerDelegate>
typedef void(^ButtonBaseActionBlock)(ButtonBase *button);
// 点击
@property (nonatomic,copy)ButtonBaseActionBlock didBlock;
- (void)setDidBlock:(ButtonBaseActionBlock)didBlock;

// 长按
@property (nonatomic,copy)ButtonBaseActionBlock longBlock;
- (void)setLongBlock:(ButtonBaseActionBlock)longBlock;

// 双击
@property (nonatomic,copy)ButtonBaseActionBlock doubleClickBlock;
- (void)setDoubleClickBlock:(ButtonBaseActionBlock)doubleClickBlock;

@end
