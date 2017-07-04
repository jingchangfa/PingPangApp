//
//  CollectionViewCellBase.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "CollectionViewCellBase.h"

@implementation CollectionViewCellBase
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bankViewInit];
    }
    return self;
}
- (void)bankViewInit{
    //子类重写
}
@end
