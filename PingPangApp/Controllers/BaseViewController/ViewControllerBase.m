//
//  ViewControllerBase.m
//  NewProjectDevelopmentEnvironment
//
//  Created by jing on 17/4/1.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ViewControllerBase.h"
#import "ViewControllerBaseConfiguation.h"// 杂乱的设置
#import "ViewControllerNavButtonIteamConfiguation.h"// 导航条按钮
#import "ViewControllerNavBarHiddenConfiguation.h"// 导航条显示隐藏
#import "ViewControllerRightTapConfiguation.h" // 侧滑返回
#import "ViewControllerKeyBoardConfiguation.h"// 键盘

@interface ViewControllerBase ()
@property (nonatomic,strong)ViewControllerBaseConfiguation *configuation;
@property (nonatomic,strong)ViewControllerNavBarHiddenConfiguation *barHiddenConfiguation;
@property (nonatomic,strong)ViewControllerRightTapConfiguation *rightBackTapConfiguation;

@end

@implementation ViewControllerBase
- (void)dealloc
{
    NSLog(@"%@-----delloc",NSStringFromClass(self.class));
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    // 设置controler的style
    [self.delegate viewDidLoad];
    // 右划返回
    [self.rightBackTapConfiguation addTapGestureRecognizer];
    // 子类didload
    [self setContro];
    [self bankViewInit];
    [self getModel];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.delegate viewWillAppear];
    [self relayoutSubViewContent];
    self.navigationController.delegate = self.barHiddenConfiguation;
    [ViewControllerKeyBoardConfiguation KeyBoardSetingWithController:self];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.delegate viewDidAppear];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.delegate viewWillDisappear];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.delegate viewDidDisappear];
}
- (void)bankViewInit
{
    [NSException raise:NSInternalInconsistencyException format:@"您必须重载该方法bankViewInit来添加view:%@",NSStringFromClass(self.class)];
}
- (void)setContro
{
    [NSException raise:NSInternalInconsistencyException format:@"您必须重载该方法setContro来设置controller:%@",NSStringFromClass(self.class)];
}
- (void)getModel
{
}

- (void)relayoutSubViewContent
{
    // do nothing , subclass should implement it if needed
    [NSException raise:NSInternalInconsistencyException format:@"您必须重载该方法relayoutSubViewContent来布局:%@",NSStringFromClass(self.class)];
}
#pragma mark buttonIteam
/**
 * addLeftBackButtonIteam 添加统一的返回按钮(didBlock = nil,返回上一页)
 * addLeftButtonIteamByImageName 添加左侧按钮
 * addRightButtonIteamByImageName 添加右侧按钮
 */
- (void)addLeftBackButtonIteamWithDidBlock:(void(^)(UIButton *didButton))didBlock{
    UIBarButtonItem *backBarButtonItem = [self buttonIteamByImageName:@"back_image" OrTitle:nil AndTitleColor:nil AndDidBlock:^(BOOL isImageButtom, NSString *sourceString, UIButton *didButton) {
        if (didBlock) {
            didBlock(didButton);
            return;
        }
        [self onBackButtonClicked];
    }];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
}
- (void)addLeftButtonIteamByImageName:(NSString *)imageName OrTitle:(NSString *)title AndTitleColor:(UIColor *)titleColor AndDidBlock:(void(^)(BOOL isImageButtom,NSString *sourceString,UIButton *didButton))didBlock{
    UIBarButtonItem *leftBarButtonItem = [self buttonIteamByImageName:imageName OrTitle:title AndTitleColor:titleColor AndDidBlock:didBlock];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}
- (void)addRightButtonIteamByImageName:(NSString *)imageName OrTitle:(NSString *)title AndTitleColor:(UIColor *)titleColor AndDidBlock:(void(^)(BOOL isImageButtom,NSString *sourceString,UIButton *didButton))didBlock{
    UIBarButtonItem *rightBarButtonItem = [self buttonIteamByImageName:imageName OrTitle:title AndTitleColor:titleColor AndDidBlock:didBlock];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}
- (UIBarButtonItem *)buttonIteamByImageName:(NSString *)imageName OrTitle:(NSString *)title AndTitleColor:(UIColor *)titleColor AndDidBlock:(void(^)(BOOL isImageButtom,NSString *sourceString,UIButton *didButton))didBlock{
    UIBarButtonItem *barButtonItem = nil;
    if (imageName) {
        barButtonItem = [ViewControllerNavButtonIteamConfiguation CreatedBarButtonItemByImageNameString:imageName AndBlock:^(UIButton *customButton) {
            if (didBlock) didBlock(YES,imageName,customButton);
        }];
    }else{
        barButtonItem = [ViewControllerNavButtonIteamConfiguation CreatedBarButtonItemByTitleString:title AndTitleColor:titleColor  AndBlock:^(UIButton *customButton) {
            if (didBlock) didBlock(NO,title,customButton);
        }];
    }
    return barButtonItem;
}
- (void)onBackButtonClicked
{
    if (self.navigationController && self.navigationController.viewControllers.count > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES
                                 completion:NULL];
    }
}
#pragma mark get
- (id<ViewControllerBaseConfiguationDelegate>)delegate{
    return self.configuation;
}
- (ViewControllerBaseConfiguation *)configuation{
    if (!_configuation) {
        _configuation = [[ViewControllerBaseConfiguation alloc] initWithController:self];
    }
    return _configuation;
}
- (ViewControllerRightTapConfiguation *)rightBackTapConfiguation{
    if (!_rightBackTapConfiguation) {
        _rightBackTapConfiguation = [[ViewControllerRightTapConfiguation alloc] initWithController:self];
    }
    return _rightBackTapConfiguation;
}
- (ViewControllerNavBarHiddenConfiguation *)barHiddenConfiguation{
    if (!_barHiddenConfiguation) {
        _barHiddenConfiguation = [[ViewControllerNavBarHiddenConfiguation alloc] init];
    }
    return _barHiddenConfiguation;
}
#pragma mark set
- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
//    self.title = titleString;
    self.navigationItem.title = titleString;
}
- (void)setNavBankColor:(UIColor *)navBankColor{
    _navBankColor = navBankColor;
    self.navigationController.navigationBar.barTintColor = navBankColor;
}
- (void)setNavTitleClolr:(UIColor *)navTitleClolr{
    _navTitleClolr = navTitleClolr;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:navTitleClolr}];
}
- (void)setIsNavTranslucent:(BOOL)isNavTranslucent{
    _isNavTranslucent = isNavTranslucent;
    self.navigationController.navigationBar.translucent = isNavTranslucent;
}
- (void)setIsNavShaowLineShow:(BOOL)isNavShaowLineShow{
    _isNavShaowLineShow = isNavShaowLineShow;
    if (isNavShaowLineShow) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    }else{
        self.navigationController.navigationBar.backgroundColor = nil;
        self.navigationController.navigationBar.shadowImage = nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
