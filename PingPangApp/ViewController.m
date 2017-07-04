//
//  ViewController.m
//  PingPangApp
//
//  Created by jing on 17/5/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ViewController.h"
#import "ButtonBase.h"
#import "CeShiCar.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    CeShiCar *car = [CeShiCar click];
//    CeShiCar *car2 = [CeShiCar clickTwo];
//    CeShiCar *car3 = [CeShiCar alloc];
//    CeShiCar *car4 = [car3 init];
//
//    car.class;
}
- (void)setContro{
    self.title = @"首页";
    @WeakObj(self);
    [self addLeftBackButtonIteamWithDidBlock:^(UIButton *didButton) {
        
    }];
    [self addRightButtonIteamByImageName:nil OrTitle:@"前进" AndTitleColor:[UIColor redColor] AndDidBlock:^(BOOL isImageButtom, NSString *sourceString, UIButton *didButton) {
        UIViewController *con = [[NSClassFromString(@"WebViewController") alloc] init];
        [selfWeak.navigationController pushViewController:con animated:YES];
    }];
    UIView *changeView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 375, 80)];
    UILabel *topLabel = [[UILabel alloc] initWithFrame:changeView.bounds];
    topLabel.backgroundColor = [UIColor redColor];
    topLabel.text = @"第一个view";
    topLabel.userInteractionEnabled = YES;
    
    UILabel *buttomLabel = [[UILabel alloc] initWithFrame:changeView.bounds];
    buttomLabel.backgroundColor = [UIColor greenColor];
    buttomLabel.text = @"第二个view";
    buttomLabel.userInteractionEnabled = YES;

    ButtonBase *leftButton = [[ButtonBase alloc] initWithFrame:topLabel.bounds];
    [leftButton setDidBlock:^(ButtonBase *button) {
        [UIView transitionFromView:topLabel toView:buttomLabel duration:1.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:nil];
    }];
    ButtonBase *rightButton = [[ButtonBase alloc] initWithFrame:buttomLabel.bounds];
    [rightButton setDidBlock:^(ButtonBase *button) {
        [UIView transitionFromView:buttomLabel toView:topLabel duration:1.0f options:UIViewAnimationOptionTransitionFlipFromRight completion:nil];
    }];
    
    [topLabel addSubview:leftButton];
    [buttomLabel addSubview:rightButton];
    [changeView addSubview:buttomLabel];
    [changeView addSubview:topLabel];
    [self.view addSubview:changeView];

    
    
    

    
}
- (void)bankViewInit{
    NSString *string = @"\"json\"";
    NSLog(@"%@",string);
    NSString *newString = [string stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSLog(@"%@",newString);
}
- (void)getModel{
    
//    UICollectionView *view;
//    UICollectionViewCell *cell = [view dequeueReusableCellWithReuseIdentifier:@"xxxx" forIndexPath:[[NSIndexPath alloc] init]];
//    UIButton *button;
//    if (cell.contentView.subviews.lastObject.tag == 999) {
//        // 已经添加过了
//        button = cell.contentView.subviews.lastObject;
//    }else{
//        // 没有添加过
//        button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.tag = 999;
//        [cell.contentView addSubview:button];
//        // 下面设置button的属性
//    }
}
- (void)relayoutSubViewContent{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
