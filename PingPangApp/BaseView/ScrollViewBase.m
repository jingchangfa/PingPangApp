
//
//  ScrollViewBase.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ScrollViewBase.h"

@implementation ScrollViewBase

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
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
