//
//  UIView+FrameLayout.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "UIView+FrameLayout.h"

@implementation UIView (FrameLayout)
- (void)setOriginX:(CGFloat)originX
{
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (void)setOriginY:(CGFloat)originY
{
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)setCenterX:(CGFloat)centerX{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}
-(CGFloat)centerX{
    return self.center.x;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}
-(CGFloat)centerY{
    return self.center.y;
}
#pragma mark 辅助方法
- (CGRect)convertRectFrame{
    return [self convertRect:self.bounds toView:self.window];
}
#pragma mark 链式布局
- (ViewSetFloatBlock)j_originX{
    return ^(float sizeFloat){
        self.originX = sizeFloat;
        return self;
    };
}
- (ViewSetFloatBlock)j_originY{
    return ^(float sizeFloat){
        self.originY = sizeFloat;
        return self;
    };
}
- (ViewSetFloatBlock)j_width{
    return ^(float sizeFloat){
        self.width = sizeFloat;
        return self;
    };
}
- (ViewSetFloatBlock)j_height{
    return ^(float sizeFloat){
        self.height = sizeFloat;
        return self;
    };
}

- (ViewSetFloatBlock)j_centerX{
    return ^(float sizeFloat){
        self.centerX = sizeFloat;
        return self;
    };
}
- (ViewSetFloatBlock)j_centerY{
    return ^(float sizeFloat){
        self.centerY = sizeFloat;
        return self;
    };
}
//borther
- (ViewCalculationFloatBlock)j_leftToBorther{
    return ^(UIView *scaleView,float sizeFloat){
        self.originX = scaleView.originX-sizeFloat-self.width;
        return self;
    };
}
- (ViewCalculationFloatBlock)j_rightToBorther{
    return ^(UIView *scaleView,float sizeFloat){
        self.originX = scaleView.originX+scaleView.width+sizeFloat;
        return self;
    };
}
- (ViewCalculationFloatBlock)j_topToBorther{
    return ^(UIView *scaleView,float sizeFloat){
        self.originY = scaleView.originY-sizeFloat-self.height;
        return self;
    };
}
- (ViewCalculationFloatBlock)j_buttomToBorther{
    return ^(UIView *scaleView,float sizeFloat){
        self.originY = scaleView.originY+scaleView.height+sizeFloat;
        return self;
    };
}
//equal
- (ViewCalculationViewBlock)j_equalCenterXByBorther{
    return ^(UIView *scaleView){
        self.centerX = scaleView.centerX;
        return self;
    };
}
- (ViewCalculationViewBlock)j_equalCenterYByBorther{
    return ^(UIView *scaleView){
        self.centerY = scaleView.centerY;
        return self;
    };
}
- (ViewCalculationViewBlock)j_equalCenterByBorther{
    return ^(UIView *scaleView){
        self.center = scaleView.center;
        return self;
    };
}
- (ViewCalculationViewBlock)j_equalOriginByBorther{
    return ^(UIView *scaleView){
        self.origin = scaleView.origin;
        return self;
    };
}
- (ViewCalculationViewBlock)j_equalSizeByBorther{
    return ^(UIView *scaleView){
        self.size = scaleView.size;
        return self;
    };
}
@end
