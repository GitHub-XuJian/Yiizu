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
            case VisitorsLogin:{
                NSLog(@"游客登录");
                [self dismissViewControllerAnimated:YES completion:nil];
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
                    [self wechatLogin];
                break;
            }
            default:
                break;
        }
    }];
    [self.view addSubview:_loginView];
}
- (void)wechatLogin {
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

#pragma mark - 设置弹出提示语
- (void)setupAlertController {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}

// 授权后回调
// AppDelegate.m
- (void)onResp:(BaseResp *)resp {
    // 向微信请求授权后,得到响应结果
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *temp = (SendAuthResp *)resp;
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
