//
//  TableViewCellBase.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "TableViewCellBase.h"

@implementation TableViewCellBase
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self bankViewInit];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)bankViewInit{
}
@end
