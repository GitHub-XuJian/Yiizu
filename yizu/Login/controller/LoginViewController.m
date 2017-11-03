//
//  LoginViewController.m
//  yizu
//
//  Created by 徐健 on 2017/10/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "registerViewController.h"
#import "ForgetViewController.h"
#import "SFValidationEmailViewController.h"
#import "WXApi.h"
#import <UMSocialCore/UMSocialCore.h>

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
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [_loginView btnClicked:^(BtnloginType buttonType, NSString *password) {
        
        switch (buttonType) {
            case Login:{
                NSLog(@"登录");
                if (!_loginView.accountTextField.text.length) {
                    jxt_showAlertTitle(@"请输入手机号");
                    return ;
                }else if(!password.length){
                    jxt_showAlertTitle(@"请输入密码");
                    return ;
                }
                [SVProgressHUD showWithStatus:@"正在登录"];
                NSDictionary *dict = @{@"tel":_loginView.accountTextField.text,@"password":[EncapsulationMethod md5:password],@"sunshine":[UUID getUUID]};
                NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Login/Login",Main_Server];
                [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                    [SVProgressHUD dismiss];
                    NSLog(@"%@",responseObject);
                    jxt_showToastMessage(responseObject[@"msg"], 1);
                    NSInteger code = [responseObject[@"code"] integerValue];
                    switch (code) {
                        case 1:{
                            [XSaverTool setObject:_loginView.accountTextField.text forKey:PhoneKey];
                            [XSaverTool setObject:password forKey:Password];
                            [XSaverTool setBool:code forKey:IsLogin];
                            [XSaverTool setBool:[responseObject[@"statevip"] integerValue] forKey:Statevip];
                            [XSaverTool setObject:responseObject[@"personid"] forKey:UserIDKey];
                            [XSaverTool setObject:responseObject[@"headimgurl"] forKey:UserIconImage];
                            _successfulBlock();
                            [self dismissViewControllerAnimated:YES completion:nil];
                            break;
                        }
                        case 3:{
                            
                            break;
                        }
                        default:
                            break;
                    }
                    

                } fail:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"%@",error);
                }];
                break;
            }
            case RegisterBtn:{
                NSLog(@"注册");
                registerViewController *registerVC = [[registerViewController alloc] init];
                registerVC.phoneStr = _loginView.accountTextField.text;
                [self presentViewController:registerVC animated:YES completion:nil];
                break;
            }
            case Back:{
                NSLog(@"返回");

                [self dismissViewControllerAnimated:YES completion:nil];
                break;
            }
            case ForgotPassword:{
                NSLog(@"忘记密码");
                SFValidationEmailViewController *validationVC = [[SFValidationEmailViewController alloc] init];
                validationVC.emailStr = _loginView.accountTextField.text;
                [self presentViewController:validationVC animated:YES completion:nil];

                break;
            }
            case QQ:{
                NSLog(@"QQ");

                break;
            }
            case WeiXin:{
                NSLog(@"微信");
                    [self wechatLogin];
                break;
            }
            default:
                break;
        }
    }];
    [self.view addSubview:_loginView];
}
- (void)wechatLogin
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            jxt_showAlertTitle(@"已取消授权");
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            /**
             * 获取完数据登录自己平台
             */
            NSDictionary *dict = @{@"nickname":resp.name,
                                   @"sex":resp.unionGender,
                                   @"openid":resp.openid,
                                   @"headimgurl":resp.iconurl,
                                   @"city":resp.originalResponse[@"city"]};
            NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Login/weixinreceive", Main_Server];
            [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                [SVProgressHUD dismiss];
                
                jxt_showToastTitle(responseObject[@"msg"], 1);
                NSInteger code = [responseObject[@"code"] integerValue];
                switch (code) {
                    case 1:{
                        [XSaverTool setObject:_loginView.accountTextField.text forKey:PhoneKey];
                        [XSaverTool setObject:responseObject[@"personid"] forKey:UserIDKey];
                        [XSaverTool setObject:_loginView.passWordTextField.text forKey:Password];
                        [XSaverTool setBool:[responseObject[@"statevip"] integerValue] forKey:Statevip];
                        [XSaverTool setBool:code forKey:IsLogin];
                        [XSaverTool setObject:responseObject[@"headimgurl"] forKey:UserIconImage];
                        _successfulBlock();
                        [self dismissViewControllerAnimated:YES completion:nil];
                        break;
                    }
                    default:
                        break;
                }
                
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
