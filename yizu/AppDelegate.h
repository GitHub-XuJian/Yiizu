//
//  AppDelegate.h
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property float autoSizeScaleX;
@property float autoSizeScaleY;

@property (strong, nonatomic) UIWindow *window;
+ (AppDelegate *)shareDelegate;
- (void)tabbarSelectedWithIndex:(NSInteger)index;
@end

