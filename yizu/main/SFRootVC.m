
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
#import "GuideViewController.h"

@interface SFRootVC()
@end

@implementation SFRootVC

+ (UIViewController *)chooseWindowRootVC{

    // 当有版本更新,或者第一次安装的时候显示新特性界面;
    // 1.获取当前版本号
    NSString *currVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    // 2.上一次版本号
    NSString *lastVersion = [XSaverTool objectForKey:SFVersion];
    NSLog(@"当前版本号%@ 上一次 %@",currVersion,lastVersion);
    UIViewController *rootVc;
    
    //if (![currVersion isEqualToString:lastVersion]) {
        // 进入引导页界面
       // rootVc=[GuideViewController new];

   // }else{
       // if ([XSaverTool boolForKey:IsLogin]) {
            // 进入主框架
    //rootVc = [[LBTabBarController alloc] init];
      //  }else{
//            // 切换主界面
//
      // }
   // }
    
    return rootVc;
}
@end
