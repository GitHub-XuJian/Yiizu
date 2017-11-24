
//
//  SFRootVC.m
//  电视直播
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//


#import "SFRootVC.h"
#import "CustomTabBarController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "ActivityViewController.h"
#import "MallViewController.h"
#import "MyViewController.h"
#import "ActivityPageController.h"

@interface SFRootVC()
@end

@implementation SFRootVC

+ (UITabBarController *)chooseWindowRootVC{

    
    // 1.首页
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UIViewController* homeVC=[sb instantiateInitialViewController];
    CustomNavigationController *nav1 = [[CustomNavigationController alloc] initWithRootViewController:homeVC];

    // 4.活动
//    ActivityViewController *activityVC = [[ActivityViewController alloc] init];
//    activityVC.title = @"活动";
    UIStoryboard* sb2=[UIStoryboard storyboardWithName:@"Activity" bundle:nil];
    UIViewController* activityVC=[sb2 instantiateInitialViewController];
    CustomNavigationController *nav2 = [[CustomNavigationController alloc] initWithRootViewController:activityVC];

    // 2.商城
    MallViewController *mallVC = [[MallViewController alloc] init];
    mallVC.title = @"特权";
    CustomNavigationController *nav3 = [[CustomNavigationController alloc] initWithRootViewController:mallVC];

    // 3.我的
    MyViewController *myVC = [[MyViewController alloc] init];
    CustomNavigationController *nav4 = [[CustomNavigationController alloc] initWithRootViewController:myVC];

    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[nav1, nav2, nav3, nav4];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    return tabBarController;
}
+ (LLTabBar *)tabbarinitWithController:(UITabBarController *)controller
{
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:controller.tabBar.bounds];
    
    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"首页", kLLTabBarItemAttributeNormalImageName : @"UnHome", kLLTabBarItemAttributeSelectedImageName : @"Home", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"热门", kLLTabBarItemAttributeNormalImageName : @"UnActivity", kLLTabBarItemAttributeSelectedImageName : @"Activity", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"激活", kLLTabBarItemAttributeNormalImageName : @"middleIcon", kLLTabBarItemAttributeSelectedImageName : @"middleIcon", kLLTabBarItemAttributeType : @(LLTabBarItemRise)},
                                    @{kLLTabBarItemAttributeTitle : @"特权", kLLTabBarItemAttributeNormalImageName : @"UnMall", kLLTabBarItemAttributeSelectedImageName : @"Mall", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"我的", kLLTabBarItemAttributeNormalImageName : @"UnMy", kLLTabBarItemAttributeSelectedImageName : @"My", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
    
    
    [controller.tabBar addSubview:tabBar];
    return tabBar;
}

@end
