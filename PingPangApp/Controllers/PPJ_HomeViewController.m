//
//  PPJ_HomeViewController.m
//  PingPangApp
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "PPJ_HomeViewController.h"

@interface PPJ_HomeViewController ()

@end

@implementation PPJ_HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setContro{
    self.titleString = @"乒乓球";
    @WeakObj(self);
//    [self addLeftBackButtonIteamWithDidBlock:^(UIButton *didButton) {
//        
//    }];
//    [self addRightButtonIteamByImageName:nil OrTitle:@"前进" AndTitleColor:[UIColor redColor] AndDidBlock:^(BOOL isImageButtom, NSString *sourceString, UIButton *didButton) {
//        UIViewController *con = [[NSClassFromString(@"WebViewController") alloc] init];
//        [selfWeak.navigationController pushViewController:con animated:YES];
//    }];
}
- (void)bankViewInit{
}
- (void)getModel{
}
- (void)relayoutSubViewContent{
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
