//
//  CustomTabBarController.m
//  ContactsManager
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CustomTabBarController.h"
#import "HomeViewController.h"
#import "ActivityViewController.h"
#import "MallViewController.h"
#import "MyViewController.h"

#import "CustomNavigationController.h"

#import "ActivityPageController.h"
@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.首页
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UIViewController* homeVC=[sb instantiateInitialViewController];
    [self addChildVC:homeVC title:@"首页" image:@"UnHome" selectedImage:@"Home"];
    // 4.活动
    ActivityViewController *activityVC = [[ActivityViewController alloc] init];
    [self addChildVC:activityVC title:@"活动" image:@"UnActivity" selectedImage:@"Activity"];
    // 2.商城
    MallViewController *mallVC = [[MallViewController alloc] init];
    [self addChildVC:mallVC title:@"商城" image:@"UnMall" selectedImage:@"Mall"];
    // 3.我的
    MyViewController *myVC = [[MyViewController alloc] init];
    [self addChildVC:myVC title:@"我的" image:@"UnMy" selectedImage:@"My"];

}
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    //1.设置子控制器的标题
    childVC.title = title;
    
    //设置tabbarItem文字属性
    NSMutableDictionary *tabbarItemTitleAttributesNormal = [NSMutableDictionary dictionary];
    tabbarItemTitleAttributesNormal[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [childVC.tabBarItem setTitleTextAttributes:tabbarItemTitleAttributesNormal forState:UIControlStateNormal];
    
    NSMutableDictionary *tabbarItemTitleAttributes = [NSMutableDictionary dictionary];
    tabbarItemTitleAttributes[NSForegroundColorAttributeName] = KColor_NavigationBar;
    tabbarItemTitleAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [childVC.tabBarItem setTitleTextAttributes:tabbarItemTitleAttributes forState:UIControlStateSelected];
    
    //2.设置tabbarItem图片
    
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [childVC.tabBarItem setImageInsets:UIEdgeInsetsMake(1, 0, -1,0)];
    
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:childVC];
    
    //3.添加到tabbarController
    [self addChildViewController:nav];
}


@end
