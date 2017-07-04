//
//  ViewControllerBase.h
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerBaseConfiguationDelegate.h"
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;

@interface ViewControllerBase : UIViewController
/**
 子类可以通过重写delegate的get方法来重新设置一个遵循ViewControllerBaseConfiguationDelegate的对象,设置controller的style
 */
@property (nonatomic,readonly) id<ViewControllerBaseConfiguationDelegate> delegate;
/**
 * titleString 标题
 * navBankColor nav背景色
 * navTitleClolr nav标题颜色
 * isNavTranslucent 导航栏半透明
 * isNavHidden 导航栏隐藏
 * isNavShaowLineShow 导航栏的边界黑线
 */
@property (nonatomic,strong) NSString *titleString;
@property (nonatomic,strong) UIColor *navBankColor;
@property (nonatomic,strong) UIColor *navTitleClolr;
// 显示隐藏在ViewControllerNavBarHiddenConfiguation.h 配置
@property (nonatomic,assign) BOOL isNavTranslucent;
@property (nonatomic,assign) BOOL isNavShaowLineShow;
/**
 * addLeftBackButtonIteam 添加统一的返回按钮
 * addLeftButtonIteamByImageName 添加左侧按钮
 * addRightButtonIteamByImageName 添加右侧按钮
 */
- (void)addLeftBackButtonIteamWithDidBlock:(void(^)(UIButton *didButton))didBlock;
- (void)addLeftButtonIteamByImageName:(NSString *)imageName OrTitle:(NSString *)title AndTitleColor:(UIColor *)titleColor AndDidBlock:(void(^)(BOOL isImageButtom,NSString *sourceString,UIButton *didButton))didBlock;
- (void)addRightButtonIteamByImageName:(NSString *)imageName OrTitle:(NSString *)title AndTitleColor:(UIColor *)titleColor AndDidBlock:(void(^)(BOOL isImageButtom,NSString *sourceString,UIButton *didButton))didBlock;

// viewdidload 调用
- (void)bankViewInit;
- (void)setContro;
- (void)getModel;
// 重新布局view.frame
- (void)relayoutSubViewContent;
@end
