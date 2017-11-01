//
//  SFValidationEmailViewController.m
//  ContactsManager
//
//  Created by 徐健 on 17/7/14.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import "SFValidationEmailViewController.h"
#import "mytimer.h"
#import "UUID.h"
#import "OldAndNewPassWordViewController.h"

@interface SFValidationEmailViewController ()<UITextFieldDelegate>
{
    NSString *_inputVcode;
}
@property (nonatomic,strong)UIButton *CodeBtn;//获取验证码
@property (nonatomic,assign)BOOL isq;
@property (nonatomic, strong) UITextField *emailText;
@property (nonatomic, strong) UITextField *verificationCodeText;
@end

@implementation SFValidationEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    [self createUI];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"mytimertongzhi" object:nil];
}

- (void)leftBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createUI
{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    backImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 20, 44, 44);
    //            [leftBtn setTitle:leftBtnStr forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:leftBtn];
    
    UITextField *emailTextField = [[UITextField alloc] init];
    emailTextField.frame = CGRectMake(20,100,kSCREEN_WIDTH-40,40);
    emailTextField.placeholder = @"请输入手机";
//    [emailTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
//    emailTextField.textColor = [UIColor grayColor];
    emailTextField.layer.borderColor= [UIColor blackColor].CGColor;
    emailTextField.layer.borderWidth= 1.0f;
    emailTextField.delegate = self;
    emailTextField.text = self.emailStr;
    emailTextField.enabled = YES;
//    emailTextField.text = @"13898388023@163.com";
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    emailTextField.leftView = textView;
    emailTextField.leftViewMode = UITextFieldViewModeAlways;
    [backImageView addSubview:emailTextField];
    self.emailText = emailTextField;
    
    UITextField *verificationCodeTextField = [[UITextField alloc] init];
    verificationCodeTextField.frame = CGRectMake(20,emailTextField.y+emailTextField.height+20,(kSCREEN_WIDTH-60)/2,40);
    verificationCodeTextField.placeholder = @"请输入验证码";
    [verificationCodeTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    verificationCodeTextField.textColor = [UIColor blackColor];
    verificationCodeTextField.layer.borderColor= [UIColor blackColor].CGColor;
    verificationCodeTextField.layer.borderWidth= 1.0f;
    verificationCodeTextField.delegate = self;
    UIView *textView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    verificationCodeTextField.leftView = textView1;
    verificationCodeTextField.leftViewMode = UITextFieldViewModeAlways;
    [backImageView addSubview:verificationCodeTextField];
    self.verificationCodeText = verificationCodeTextField;
    
    _CodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _CodeBtn.frame = CGRectMake(verificationCodeTextField.x+verificationCodeTextField.width+20, verificationCodeTextField.y, kSCREEN_WIDTH-60-verificationCodeTextField.width, verificationCodeTextField.height);
    self.isq?(_CodeBtn.userInteractionEnabled = NO):(_CodeBtn.userInteractionEnabled = YES);
    [_CodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_CodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _CodeBtn.backgroundColor = [UIColor colorWithRed:0.196 green:0.525 blue:0.788 alpha:1.000];
    [_CodeBtn addTarget:self action:@selector(CodeBtnClic:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:_CodeBtn];
    
    //登录按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(verificationCodeTextField.x, verificationCodeTextField.y+verificationCodeTextField.height+20, kSCREEN_WIDTH-40, 40);
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:button];
}
- (void)onClick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];

    if (![XSaverTool objectForKey:VerificationCode]) {
        jxt_showAlertTitle(@"请输入验证码");
        return;
    }
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[XSaverTool objectForKey:VerificationCodeTime] doubleValue]];
    NSDate * now = [NSDate date];
    NSTimeInterval timeBetween = [now timeIntervalSinceDate:date];
    NSLog(@"%f",timeBetween);
    NSInteger sec = (NSInteger)timeBetween;
    NSLog(@"%ld",(long)sec);
    
    if (sec>300) {
        jxt_showAlertTitle(@"验证码超时");
    }else{
        if ([_inputVcode isEqualToString:[XSaverTool objectForKey:VerificationCode]]) {
            OldAndNewPassWordViewController *onpVC = [[OldAndNewPassWordViewController alloc] init];
            onpVC.phoneStr = self.emailStr;
            [self presentViewController:onpVC animated:YES completion:nil];
        }else{
            jxt_showAlertTitle(@"验证码不正确");
        }
    }
}
//获取验证码
-(void)CodeBtnClic:(UIButton*)sender{
    if (_emailText.text.length == 0) {
        jxt_showAlertTitle(@"邮箱不能为空");
    }else{
        //倒计时
        [[mytimer sharetimer] makeTimer];
        NSDictionary *dict = @{@"tel":self.emailText.text};
        NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Login/trueyzm",Main_Server];
        [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            jxt_showToastMessage(responseObject[@"msg"], 1);
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 1) {
                [XSaverTool setObject:responseObject[@"yzm"] forKey:VerificationCode];
                [XSaverTool setObject:responseObject[@"sendtime"] forKey:VerificationCodeTime];
            }else{
                [[mytimer sharetimer] stopTimer];
                _CodeBtn.userInteractionEnabled = YES;
                [_CodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];

    }
    
}
#pragma mark LWJTimerNotifi
- (void)tongzhi:(NSNotification *)text{
    
    [_CodeBtn setTitle:[NSString stringWithFormat:@"%@s",text.userInfo[@"time"]] forState:UIControlStateNormal];
    if ([text.userInfo[@"num"] isEqualToString:@"0"]) {
        _CodeBtn.userInteractionEnabled = NO;
        
    }else{
        _CodeBtn.userInteractionEnabled = YES;
        [_CodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.verificationCodeText]) {
        _inputVcode = textField.text;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
