//
//  LoginViewController.m
//  yizu
//
//  Created by 徐健 on 2017/10/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController ()
@property (nonatomic, strong) LoginView *loginView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadLoginInterface];
}
- (void)loadLoginInterface
{
    _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [_loginView btnClicked:^(BtnloginType buttonType, NSString *password) {
        switch (buttonType) {
            case Login:{
                NSLog(@"登录");
                break;
            }
            case RegisterBtn:{
                NSLog(@"注册");

                break;
            }
            case Back:{
                NSLog(@"返回");

                [self dismissViewControllerAnimated:YES completion:nil];
                break;
            }
            case ForgotPassword:{
                NSLog(@"忘记密码");

                break;
            }
            case VisitorsLogin:{
                NSLog(@"游客登录");

                break;
            }
            case QQ:{
                NSLog(@"QQ");

                break;
            }
            case Sina:{
                NSLog(@"新浪");
                
                break;
            }
            case WeiXin:{
                NSLog(@"微信");

                break;
            }
            default:
                break;
        }
    }];
    [self.view addSubview:_loginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
