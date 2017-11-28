//
//  LBTabBarController.m
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import "LBTabBarController.h"

#import "HomeViewController.h"
#import "ActivityViewController.h"
#import "MallViewController.h"
#import "MyViewController.h"
#import "ActivityPageController.h"
#import "CustomNavigationController.h"
#import "ActivationCodeInputViewController.h"
#import "LBTabBar.h"
#import "UIImage+Image.h"


@interface LBTabBarController ()<LBTabBarDelegate>

@end

@implementation LBTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor colorWithRed:1.00f green:0.42f blue:0.19f alpha:1.00f];;
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpAllChildVc];

    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];


}


#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{

    // 1.首页
    UIStoryboard* sb=[UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UIViewController* homeVC=[sb instantiateInitialViewController];
    [self setUpOneChildVcWithVc:homeVC Image:@"UnHome" selectedImage:@"Home" title:@"首页"];

    // 4.活动
    UIStoryboard* sb2=[UIStoryboard storyboardWithName:@"Activity" bundle:nil];
    UIViewController* activityVC=[sb2 instantiateInitialViewController];
    [self setUpOneChildVcWithVc:activityVC Image:@"UnActivity" selectedImage:@"Activity" title:@"热门"];

    // 2.商城
    MallViewController *mallVC = [[MallViewController alloc] init];
    [self setUpOneChildVcWithVc:mallVC Image:@"UnMall" selectedImage:@"Mall" title:@"特权"];

    // 3.我的
    MyViewController *myVC = [[MyViewController alloc] init];
    [self setUpOneChildVcWithVc:myVC Image:@"UnMy" selectedImage:@"My" title:@"我的"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    CustomNavigationController *nav = [[CustomNavigationController alloc] initWithRootViewController:Vc];


    Vc.view.backgroundColor = [self randomColor];

    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;

    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    Vc.tabBarItem.selectedImage = mySelectedImage;

    Vc.tabBarItem.title = title;

    Vc.navigationItem.title = title;

    [self addChildViewController:nav];
    
}



#pragma mark - ------------------------------------------------------------------
#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
{
    NSLog(@"激活");
    if ([XSaverTool boolForKey:IsLogin]) {
        if ([[XSaverTool objectForKey:Identity] integerValue] == 1){
            ActivationCodeInputViewController *activationVC = [[ActivationCodeInputViewController alloc] init];
            [self presentViewController:activationVC animated:YES completion:nil];
        }else{
            jxt_showAlertTitle(@"请补全信息");
        }
    }else{
        jxt_showAlertTwoButton(@"提示", @"请登录", @"确定", ^(NSInteger buttonIndex) {
            LoginViewController *loginViewC = [[LoginViewController alloc] init];
            loginViewC.successfulBlock = ^{
                self.tabBarController.selectedIndex = 0;
            };
            loginViewC.failedBlock = ^{
                
            };
            [self presentViewController:loginViewC animated:YES completion:nil];
        }, @"取消", ^(NSInteger buttonIndex) {
            
        });
    }


}


- (UIColor *)randomColor
{
    return kMAIN_BACKGROUND_COLOR;

}

@end
