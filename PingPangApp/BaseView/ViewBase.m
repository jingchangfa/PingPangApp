//
//  ViewBase.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ViewBase.h"

@implementation ViewBase

- (instancetype)init{
    self =  [super init];
    if (self) {
        [self bankViewInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bankViewInit];
    }
    return self;
}

- (void)bankViewInit{
//    // 添加
//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//    }];
//    // 更新
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {\
//        make.left.right.top.bottom.equalTo(@(123));
//        make.width.height.equalTo(@(10));
//        make.left.equalTo(self).offset(10);
//    }];
//    // 重置
//    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
//    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
