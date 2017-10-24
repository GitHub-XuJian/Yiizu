
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

    // 进入主框架
    UIViewController *rootVc = [[CustomTabBarController alloc] init];
    return rootVc;
}

@end
