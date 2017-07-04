//
//  UIView+FrameLayout.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef UIView *(^ViewSetFloatBlock)(float sizeFloat);
/**
 * scaleView 标尺view
 * sizeFloat 偏移
 */
typedef UIView *(^ViewCalculationFloatBlock)(UIView *scaleView,float sizeFloat);
/**
 * equal
 */
typedef UIView *(^ViewCalculationViewBlock)(UIView *scaleView);
typedef UIView *(^ViewEqulSuperBlock)();


@interface UIView (FrameLayout)
@property (nonatomic, assign) CGFloat  originX;
@property (nonatomic, assign) CGFloat  originY;
@property (nonatomic, assign) CGPoint  origin;
@property (nonatomic, assign) CGFloat  width;
@property (nonatomic, assign) CGFloat  height;
@property (nonatomic, assign) CGSize   size;
@property (nonatomic, assign) CGFloat  centerX;
@property (nonatomic, assign) CGFloat  centerY;

#pragma mark 辅助方法
/**
 * convertRectFrame 获取绝对坐标(相对于屏幕的坐标)
 */
- (CGRect)convertRectFrame;


#pragma mark 用到再追加吧～ 先下面这几个(简单的计算)
/**
  链式赋值
 * 直接设置值
 */
- (ViewSetFloatBlock)j_originX;
- (ViewSetFloatBlock)j_originY;
- (ViewSetFloatBlock)j_width;
- (ViewSetFloatBlock)j_height;

- (ViewSetFloatBlock)j_centerX;
- (ViewSetFloatBlock)j_centerY;

/**
  链式赋值
 * 相对 兄弟view (这几个方法调用钱确保width height已经设置了)
 */
- (ViewCalculationFloatBlock)j_leftToBorther;
- (ViewCalculationFloatBlock)j_rightToBorther;
- (ViewCalculationFloatBlock)j_topToBorther;
- (ViewCalculationFloatBlock)j_buttomToBorther;

/*
 equla
 * 相对 兄弟view
 */
- (ViewCalculationViewBlock)j_equalCenterXByBorther;
- (ViewCalculationViewBlock)j_equalCenterYByBorther;
- (ViewCalculationViewBlock)j_equalCenterByBorther;
- (ViewCalculationViewBlock)j_equalOriginByBorther;
- (ViewCalculationViewBlock)j_equalSizeByBorther;

@end
