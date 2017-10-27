
//
//  SFRootVC.m
//  电视直播
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//


#import "SFRootVC.h"
#import "CustomTabBarController.h"


@interface SFRootVC()
@end

@implementation SFRootVC

+ (UIViewController *)chooseWindowRootVC{

    UIViewController *rootVc;
//    if ([XSaverTool boolForKey:IsLogin]) {
        // 进入主框架
        rootVc = [[CustomTabBarController alloc] init];
//    }else{
        // 切换主界面
        // 切换界面方式  1.push 2.tabBarVC  3.modale
//        loginViewController * login = [[loginViewController alloc] init];
//        login.successfulBlock = ^(){
//            // 想让新特性界面销毁
//            // 切换窗口的跟控制器
//            CustomTabBarController *tabBarVC = [[CustomTabBarController alloc] init];
//            SFKeyWindow.rootViewController =  tabBarVC;
//        };
//        login.failedBlock = ^(){
//            
//        };
//        rootVc = login;
//    }
    return rootVc;
}

@end
