//
//  ViewControllerNavButtonIteamConfiguation.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ViewControllerNavButtonIteamConfiguation.h"
#import "ButtonBase.h"
@interface ImageBarButton : ButtonBase
- (instancetype)initWithTitle:(NSString *)titleString AndDidBlock:(void(^)(UIButton *customButton))didBlock;
- (instancetype)initWithImage:(UIImage *)image AndDidBlock:(void(^)(UIButton *customButton))didBlock;
//@property (nonatomic,strong)UIColor *titleColor;
@end

#pragma mark ViewControllerNavButtonIteamConfiguation
@implementation ViewControllerNavButtonIteamConfiguation
+ (UIBarButtonItem *)CreatedBarButtonItemByTitleString:(NSString *)titleString AndTitleColor:(UIColor *)titleColor AndBlock:(void(^)(UIButton *customButton))block{
    ImageBarButton *customButton = [[ImageBarButton alloc] initWithTitle:titleString AndDidBlock:block];
    [customButton setTitleColor:titleColor forState:UIControlStateNormal];
    [customButton setTitleColor:titleColor forState:UIControlStateHighlighted];
    UIBarButtonItem *barIteam = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    return barIteam;
}
+ (UIBarButtonItem *)CreatedBarButtonItemByImageNameString:(NSString *)imageNameString AndBlock:(void(^)(UIButton *customButton))block{
    ImageBarButton *customButton = [[ImageBarButton alloc] initWithImage:[UIImage imageNamed:imageNameString] AndDidBlock:block];
    UIBarButtonItem *barIteam = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    return barIteam;
}
@end

#pragma mark BarButtonItem
@implementation ImageBarButton
- (instancetype)initWithTitle:(NSString *)titleString AndDidBlock:(void(^)(UIButton *customButton))didBlock{
    self = [super initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (self) {
        self.didBlock = didBlock;
        self.titleLabel.font = [UIFont systemFontOfSize:self.height*0.45];
        [self setTitle:titleString forState:UIControlStateNormal];
        [self setTitle:titleString forState:UIControlStateHighlighted];
    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image AndDidBlock:(void(^)(UIButton *customButton))didBlock{
    self = [super initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (self) {
        self.didBlock = didBlock;
        if (!image) {
            image = [UIImage imageNamed:@"image_notfound"];
            NSLog(@"未发现图片");
        }
        [self setBackgroundImage:image forState:UIControlStateNormal];
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
    }
    return self;
}
- (UIEdgeInsets)alignmentRectInsets {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
@end
