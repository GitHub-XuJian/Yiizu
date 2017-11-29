//
//  CustomNavigationController.m
//  ContactsManager
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()
{
    CGFloat _navigationBarAlpha;
}
@end

@implementation CustomNavigationController

//1.设置UIBarButtonItem的主题样式 白色字体

+ (void)initialize
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    
    // 设置普通状态
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    //[item setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
}

//2.设置导航背景颜色
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationBar.barStyle = UIBarStyleBlack;
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bgNavigation"] forBarMetrics:UIBarMetricsDefault];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 显示导航条
    [self setNavigationBarHidden:NO animated:NO];

//    _navigationBarAlpha = self.navigationBar.subviews.firstObject.alpha;
//    self.navigationBar.subviews.firstObject.alpha = 1;

    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置导航栏按钮
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        [button setTitle:@"返回" forState:UIControlStateNormal];
//        [button sizeToFit];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [button addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)popView
{
//    self.navigationBar.subviews.firstObject.alpha = _navigationBarAlpha;
    [self popViewControllerAnimated:YES];
}
@end
