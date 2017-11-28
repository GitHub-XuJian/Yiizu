
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
#import "LBTabBarController.h"

@interface SFRootVC()
@end

@implementation SFRootVC

+ (UIViewController *)chooseWindowRootVC{
    
    UIViewController *rootVc;
    
//    if (![currVersion isEqualToString:lastVersion]) {
//        // 进入引导页界面
//
//    }else{
//        if ([XSaverTool boolForKey:IsLogin]) {
            // 进入主框架
    rootVc = [[LBTabBarController alloc] init];
//        }else{
//            // 切换主界面
//           
//        }
//    }
    
    return rootVc;
}
@end
