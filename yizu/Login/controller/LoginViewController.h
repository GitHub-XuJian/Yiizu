//
//  LoginViewController.h
//  yizu
//
//  Created by 徐健 on 2017/10/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LoginSuccessfulBlock)();
typedef void (^LoginFailedBlock)();
@interface LoginViewController : UIViewController
@property (nonatomic, strong) LoginSuccessfulBlock successfulBlock;
@property (nonatomic, strong) LoginFailedBlock failedBlock;

@end
