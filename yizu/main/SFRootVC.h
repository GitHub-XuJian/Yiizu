//
//  SFRootVC.h
//  电视直播
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LLTabBar.h"
@interface SFRootVC : NSObject


+ (UITabBarController *)chooseWindowRootVC;
+ (LLTabBar *)tabbarinitWithController:(UITabBarController *)controller;
@end
