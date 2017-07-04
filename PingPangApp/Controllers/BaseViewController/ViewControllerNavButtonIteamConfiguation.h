//
//  ViewControllerNavButtonIteamConfiguation.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/12.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 ViewController 工具类,用来创建UIBarButtonItem
 */
@interface ViewControllerNavButtonIteamConfiguation : NSObject

+ (UIBarButtonItem *)CreatedBarButtonItemByTitleString:(NSString *)titleString  AndTitleColor:(UIColor *)titleColor AndBlock:(void(^)(UIButton *customButton))block;
+ (UIBarButtonItem *)CreatedBarButtonItemByImageNameString:(NSString *)imageNameString AndBlock:(void(^)(UIButton *customButton))block;

@end
