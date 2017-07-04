//
//  PPJ_TabBarManager.m
//  PingPangApp
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "PPJ_TabBarManager.h"
#import "PPJ_HomeViewController.h"
#import "PPJ_StoreViewController.h"
#import "PPJ_BuyViewController.h"
#import "PPJ_MineViewController.h"

@implementation PPJ_TabBarManager
+ (UITabBarController *)CreatedTabBarController{
    UITabBarController *tabController = [[UITabBarController alloc] init];
    [self SetAllChildrenVCBy:tabController];
    [self SetShowUI:tabController];
    return tabController;
}
+ (void)SetAllChildrenVCBy:(UITabBarController *)tabController{
    UINavigationController *homeNC = [[UINavigationController alloc]initWithRootViewController:[[PPJ_HomeViewController alloc] init]];
    homeNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"gongzuo_image"] selectedImage:[UIImage imageNamed:@"gongzuo_image_selec"]];
    
    UINavigationController *storeNC = [[UINavigationController alloc]initWithRootViewController:[[PPJ_StoreViewController alloc] init]];
    storeNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"球桌预定" image:[UIImage imageNamed:@"gongzuo_image"] selectedImage:[UIImage imageNamed:@"gongzuo_image_selec"]];
    

    UINavigationController *buyNC = [[UINavigationController alloc]initWithRootViewController:[[PPJ_BuyViewController alloc] init]];
    buyNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"gongzuo_image"] selectedImage:[UIImage imageNamed:@"gongzuo_image_selec"]];
    

    UINavigationController *mineNC = [[UINavigationController alloc]initWithRootViewController:[[PPJ_MineViewController alloc] init]];
    mineNC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"gongzuo_image"] selectedImage:[UIImage imageNamed:@"gongzuo_image_selec"]];
    

    tabController.viewControllers = @[homeNC,storeNC,buyNC,mineNC];
}
+ (void)SetShowUI:(UITabBarController *)tabController{
    tabController.tabBar.translucent = NO;
    
    tabController.view.backgroundColor = [UIColor whiteColor];
    //设置标签栏文字和图片的颜色
    tabController.tabBar.tintColor = PCH_CUSTOM_BLUE_COLOR;
    
    //设置标签栏的颜色
    tabController.tabBar.barTintColor = [UIColor whiteColor];
    
    //设置标签栏风格(默认高度49)
    tabController.tabBar.barStyle = UIBarStyleDefault;
}
@end
