//
//  ImageViewBase.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "ViewBaseInterface.h"
@interface ImageViewBase : UIImageView<ViewBaseInterface,UIGestureRecognizerDelegate>
typedef void(^ImageViewBaseActionBlock)(ImageViewBase *imageView);

// 点击
@property (nonatomic,copy)ImageViewBaseActionBlock didBlock;
- (void)setDidBlock:(ImageViewBaseActionBlock)didBlock;
// 长按
@property (nonatomic,copy)ImageViewBaseActionBlock longBlock;
- (void)setLongBlock:(ImageViewBaseActionBlock)longBlock;
// 双击
@property (nonatomic,copy)ImageViewBaseActionBlock doubleClickBlock;
- (void)setDoubleClickBlock:(ImageViewBaseActionBlock)doubleClickBlock;
@end
