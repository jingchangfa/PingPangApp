//
//  ButtonBase.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ButtonBase.h"

@implementation ButtonBase 

- (instancetype)init{
    self =  [super init];
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
/**
 http://www.jianshu.com/p/cb0314b72883

 手势的触发优先级高于touch
 AView 有子view BView，AView上面有一个单击手势，这个时候点击BView。默认情况下，Bview的四个Touch方法中，那些方法会被调用？
 答案：仅仅调用下面俩个
 - (void)touchesBegan:(NSSet *)touches withEvent:(nullable UIEvent *)event;
 - (void)touchesCancelled:(NSSet *)touches withEvent:(nullable UIEvent *)event;
 
 手势 和 UIResponser一样 也是四个方法,Began,move,end,cancle
 
 第一步：系统会将所有的 Touch message 优先发送给 关联在响应链上的全部手势。如果没有一个手势对Touch message 进行拦截（拦截:系统不会将Touch message 发送给响应链顶部响应者)，系统会进入第二步
 
 第二步：系统将Touch message 发送给响应链 顶部的 视图控件 UIResponser的四个方法
 
 
 */
- (void)addAction{
    // 点击
     [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    // 长按
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongAction:)];
    longPress.minimumPressDuration = 0.5; //定义按的时间
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    // 双击
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnDoubleAction:)];
    doubleTapGesture.numberOfTapsRequired =2;
    doubleTapGesture.numberOfTouchesRequired =1;
    doubleTapGesture.delegate = self;
    [self addGestureRecognizer:doubleTapGesture];
}

- (void)buttonAction:(ButtonBase *)button{
    [self useingBlockWithBlock:self.didBlock];
}

- (void)btnLongAction:(UILongPressGestureRecognizer *)longPress{
    if (longPress.state != UIGestureRecognizerStateBegan)
    { //多次调用问题
        return;
    }
    [self useingBlockWithBlock:self.longBlock];
}
- (void)btnDoubleAction:(UITapGestureRecognizer *)longPress{
    [self useingBlockWithBlock:self.doubleClickBlock];
}

- (void)useingBlockWithBlock:(ButtonBaseActionBlock)block{
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
        return self.doubleClickBlock?YES:NO;
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
