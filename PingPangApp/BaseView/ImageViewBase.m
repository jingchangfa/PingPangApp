//
//  ImageViewBase.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ImageViewBase.h"

@implementation ImageViewBase

- (instancetype)init{
    self =  [super init];
    if (self) {
        [self bankViewInit];
        [self addAction];
    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image{
    self = [super initWithImage:image];
    if (self) {
        [self bankViewInit];
        [self addAction];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bankViewInit];
        [self addAction];
    }
    return self;
}

- (void)bankViewInit{
}
- (void)addAction{
    // 点击
    UITapGestureRecognizer *didTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgDidAction:)];
    didTapGesture.numberOfTouchesRequired = 1;
    didTapGesture.numberOfTapsRequired = 1;
    didTapGesture.delegate = self;
    [self addGestureRecognizer:didTapGesture];
    
    // 双击
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgDoubleAction:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired = 1;
    doubleTapGesture.delegate = self;
    [self addGestureRecognizer:doubleTapGesture];
    // 设置手势的优先级
    [didTapGesture requireGestureRecognizerToFail:didTapGesture];
    
    // 长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(imgLongAction:)];
    longPress.minimumPressDuration = 0.5; //定义按的时间
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    
}
- (void)imgDidAction:(UITapGestureRecognizer *)tapPress{
    [self useingBlockWithBlock:self.didBlock];
}

- (void)imgLongAction:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state != UIGestureRecognizerStateBegan)
    { //多次调用问题
        return;
    }
    [self useingBlockWithBlock:self.longBlock];
}

- (void)imgDoubleAction:(UITapGestureRecognizer *)tapPress{
    [self useingBlockWithBlock:self.doubleClickBlock];
}

- (void)useingBlockWithBlock:(ImageViewBaseActionBlock)block{
    if (block) {
        self.userInteractionEnabled = NO;
        block(self);
        self.userInteractionEnabled = YES;
    }
}
#pragma mark longPressDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 如果 没有其他的手势 则不响应其他手势
    if([gestureRecognizer.class isSubclassOfClass:[UILongPressGestureRecognizer class]]){
        return self.longBlock?YES:NO;
    }
    if([gestureRecognizer.class isSubclassOfClass:[UITapGestureRecognizer class]]){
        UITapGestureRecognizer *ges = (UITapGestureRecognizer *)gestureRecognizer;
        if (ges.numberOfTapsRequired == 1) {//单机
            return self.didBlock?YES:NO;
        }else{//双击
            return self.doubleClickBlock?YES:NO;
        }
    }
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
