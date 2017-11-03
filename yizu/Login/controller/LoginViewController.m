//
//  LoginViewController.m
//  yizu
//
//  Created by 徐健 on 2017/10/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "WXApi.h"
#import "registerViewController.h"
#import "ForgetViewController.h"
#import "SFValidationEmailViewController.h"
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
                    if (code == 1) {
                        [XSaverTool setObject:_loginView.accountTextField.text forKey:PhoneKey];
                        [XSaverTool setObject:password forKey:Password];
                        [XSaverTool setObject:responseObject[@"personid"] forKey:UserIDKey];
                        [XSaverTool setBool:code forKey:IsLogin];
                        [XSaverTool setObject:responseObject[@"personid"] forKey:UserIconImage];
                        _successfulBlock();
                        [self dismissViewControllerAnimated:YES completion:nil];

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
                NSString *accessToken = [XSaverTool objectForKey:WX_ACCESS_TOKEN];
                NSString *openID = [XSaverTool objectForKey:WX_OPEN_ID];
                // 如果已经请求过微信授权登录，那么考虑用已经得到的access_token
                if (accessToken && openID) {
                    
                    NSString *refreshToken = [XSaverTool objectForKey:WX_REFRESH_TOKEN];
                    NSString *refreshUrlStr = [NSString stringWithFormat:@"%@/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@", WX_BASE_URL, WXPatient_App_ID, refreshToken];
                    [SVProgressHUD showWithStatus:@"正在登录"];

                    [XAFNetWork GET:refreshUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                        NSLog(@"请求reAccess的response = %@", responseObject);
                        NSDictionary *refreshDict = [NSDictionary dictionaryWithDictionary:responseObject];
                        NSString *reAccessToken = [refreshDict objectForKey:WX_ACCESS_TOKEN];
                        // 如果reAccessToken为空,说明reAccessToken也过期了,反之则没有过期
                        if (reAccessToken) {
                            // 更新access_token、refresh_token、open_id
                            [XSaverTool setObject:reAccessToken forKey:WX_ACCESS_TOKEN];
                            [XSaverTool setObject:[refreshDict objectForKey:WX_OPEN_ID] forKey:WX_OPEN_ID];
                            [XSaverTool setObject:[refreshDict objectForKey:WX_REFRESH_TOKEN] forKey:WX_REFRESH_TOKEN];
                            // 当存在reAccessToken不为空时直接执行wechatLoginByRequestForUserInfo方法
                            [self wechatLoginByRequestForUserInfo];
                        }
                        else {
                            [self wechatLogin];
                        }
                    } fail:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"用refresh_token来更新accessToken时出错 = %@", error);

                    }];
                }
                else {
                    [self wechatLogin];
                }
                break;
            }
            default:
                break;
        }
    }];
    [self.view addSubview:_loginView];
}

- (void)wechatLogin {
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope = @"snsapi_userinfo";
        req.state = @"GSTDoctorApp";
        [WXApi sendReq:req];
    }
    else {
        [self setupAlertController];
    }
}

#pragma mark - 设置弹出提示语
- (void)setupAlertController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}

//授权后回调 WXApiDelegate
-(void)onResp:(BaseReq *)resp
{
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    // 向微信请求授权后,得到响应结果
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if (aresp.errCode== 0) {
        NSString *accessUrlStr = [NSString stringWithFormat:@"%@/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WX_BASE_URL, WXPatient_App_ID, WXPatient_App_Secret, aresp.code];
        [SVProgressHUD showWithStatus:@"正在登录"];

        [XAFNetWork GET:accessUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"请求access的response = %@", responseObject);
            NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:responseObject];
            NSString *accessToken = [accessDict objectForKey:WX_ACCESS_TOKEN];
            NSString *openID = [accessDict objectForKey:WX_OPEN_ID];
            NSString *refreshToken = [accessDict objectForKey:WX_REFRESH_TOKEN];
            // 本地持久化，以便access_token的使用、刷新或者持续
            if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
                [XSaverTool setObject:accessToken forKey:WX_ACCESS_TOKEN];
                [XSaverTool setObject:openID forKey:WX_OPEN_ID];
                [XSaverTool setObject:refreshToken forKey:WX_REFRESH_TOKEN];
            }
            [self wechatLoginByRequestForUserInfo];
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"获取access_token时出错 = %@", error);
            
        }];
    }else{
        jxt_showAlertTitle(@"用户取消授权");
    }
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        
    }
}
// 获取用户个人信息（UnionID机制）
- (void)wechatLoginByRequestForUserInfo {
    
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    NSString *userUrlStr = [NSString stringWithFormat:@"%@/userinfo?access_token=%@&openid=%@", WX_BASE_URL, accessToken, openID];
    
    [XAFNetWork GET:userUrlStr params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"请求用户信息的response = %@", responseObject);
        
        NSDictionary *dict = @{@"nickname":responseObject[@"nickname"],
                               @"sex":responseObject[@"sex"],
                               @"openid":responseObject[@"openid"],
                               @"headimgurl":responseObject[@"headimgurl"],
                               @"city":responseObject[@"city"]};
        NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Login/weixinreceive", Main_Server];
        [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            [SVProgressHUD dismiss];

            jxt_showToastTitle(responseObject[@"msg"], 1);
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code) {
                [XSaverTool setObject:_loginView.accountTextField.text forKey:PhoneKey];
                [XSaverTool setObject:responseObject[@"personid"] forKey:UserIDKey];
                [XSaverTool setBool:code forKey:IsLogin];
                [XSaverTool setObject:responseObject[@"personid"] forKey:UserIconImage];
                _successfulBlock();
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"获取用户信息时出错 = %@", error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
