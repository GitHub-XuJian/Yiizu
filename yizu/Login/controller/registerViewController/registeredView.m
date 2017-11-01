//
//  registeredView.m
//  yizu
//
//  Created by 徐健 on 2017/11/1.
//  Copyright © 2017年 XuJian. All rights reserved.
//
#define PasswordTextFieldTag    18888888
#define ConfirmPasswordTextFieldTag    188888881

#import "registeredView.h"
#import "mytimer.h"

@interface registeredView ()<UITextFieldDelegate>
{
    NSString *_inputVcode;
    NSString *_oldPassword;
    NSString *_newPassword;

}
@property (nonatomic,strong)UIButton *CodeBtn;//获取验证码
@property (nonatomic, strong) UITextField *verificationCodeText;
@property (nonatomic, strong) UITextField *phoneText;

@property (nonatomic,assign)BOOL isq;

@end

@implementation registeredView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"mytimertongzhi" object:nil];
    }
    return self;
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

- (void)createUI
{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    backImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 20, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:leftBtn];
    
    UITextField *emailTextField = [[UITextField alloc] init];
    emailTextField.frame = CGRectMake(20,100,kSCREEN_WIDTH-40,40);
    emailTextField.placeholder = @"请输入手机";
    [emailTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    emailTextField.textColor = [UIColor blackColor];
    emailTextField.layer.borderColor= [UIColor blackColor].CGColor;
    emailTextField.layer.borderWidth= 1.0f;
    emailTextField.delegate = self;
    emailTextField.text = self.iphoneStr;
    emailTextField.enabled = YES;
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    emailTextField.leftView = textView;
    emailTextField.leftViewMode = UITextFieldViewModeAlways;
    [backImageView addSubview:emailTextField];
    self.phoneText = emailTextField;
    
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
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.frame = CGRectMake(verificationCodeTextField.x,verificationCodeTextField.y+verificationCodeTextField.height+20,emailTextField.width,verificationCodeTextField.height);
    passwordTextField.placeholder = @"请输入新密码";
    [passwordTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.layer.borderColor= [UIColor blackColor].CGColor;
    passwordTextField.layer.borderWidth= 1.0f;
    passwordTextField.delegate = self;
    passwordTextField.tag = PasswordTextFieldTag;
    UIView *textView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    passwordTextField.leftView = textView2;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [backImageView addSubview:passwordTextField];
    
    UITextField *passwordTextField2 = [[UITextField alloc] init];
    passwordTextField2.frame = CGRectMake(passwordTextField.x,passwordTextField.y+passwordTextField.height+20,passwordTextField.width,passwordTextField.height);
    passwordTextField2.placeholder = @"请确认新密码";
    [passwordTextField2 setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    passwordTextField2.textColor = [UIColor blackColor];
    passwordTextField2.tag = ConfirmPasswordTextFieldTag;
    passwordTextField2.layer.borderColor= [UIColor blackColor].CGColor;
    passwordTextField2.layer.borderWidth= 1.0f;
    passwordTextField2.delegate = self;
    UIView *textView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    passwordTextField2.leftView = textView3;
    passwordTextField2.leftViewMode = UITextFieldViewModeAlways;
    [backImageView addSubview:passwordTextField2];
    
    //登录按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(passwordTextField2.x, passwordTextField2.y+passwordTextField2.height+20, passwordTextField2.width, passwordTextField2.height);
    [button setTitle:@"注册" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:button];
}
- (void)leftBtnClick
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];

    [[EncapsulationMethod viewController:self] dismissViewControllerAnimated:YES completion:nil];
}
//获取验证码
-(void)CodeBtnClic:(UIButton*)sender{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    if (!self.iphoneStr.length) {
        jxt_showToastMessage(@"请输入手机号", 1);
        return;
    }
    //倒计时
    [[mytimer sharetimer] makeTimer];
    NSDictionary *dict = @{@"tel":self.iphoneStr};
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Register/regyzm",Main_Server];
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        jxt_showToastMessage(responseObject[@"msg"], 1);
        NSInteger code = [responseObject[@"code"] integerValue];
        if (code == 1) {
            self.phoneText.textColor = kLightGrayTextColor;
            self.phoneText.enabled = NO;
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
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.phoneText]) {
        self.iphoneStr = textField.text;
    }
    if ([textField isEqual:_verificationCodeText]) {
            NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[XSaverTool objectForKey:VerificationCodeTime] doubleValue]];
            NSDate * now = [NSDate date];
            NSTimeInterval timeBetween = [now timeIntervalSinceDate:date];
            NSLog(@"%f",timeBetween);
            NSInteger sec = (NSInteger)timeBetween;
            NSLog(@"%ld",(long)sec);
            
            if (sec>300) {
                jxt_showAlertTitle(@"验证码超时");
            }else{
                if ([textField.text isEqualToString:[XSaverTool objectForKey:VerificationCode]]) {
                    
                }else{
                    jxt_showAlertTitle(@"验证码不正确");
                    textField.text = @"";
                }
            }
        _inputVcode = textField.text;
    }
    if (textField.tag == PasswordTextFieldTag) {
        if (textField.text.length >= 8) {
            _oldPassword = textField.text;
        }else if (textField.text.length > 0) {
            jxt_showToastMessage(@"请输入八位密码", 1);
            textField.text = @"";
        }
    }else if (textField.tag == ConfirmPasswordTextFieldTag) {
        if (textField.text.length >= 8) {
            _newPassword = textField.text;
        }else if (textField.text.length > 0) {
            jxt_showToastMessage(@"请输入八位密码", 1);
            textField.text = @"";
        }
    }
}
- (void)onClick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    
    if (![XSaverTool objectForKey:VerificationCode]) {
        jxt_showAlertTitle(@"请获取验证码");
        return;
    }
    if (!_inputVcode) {
        jxt_showAlertTitle(@"请输入验证码");
        return;
    }
    if (!_oldPassword.length||!_newPassword.length) {
        jxt_showAlertTitle(@"请输入账号或密码");
        return;
    }
    if ([_oldPassword isEqualToString:_newPassword]) {
        NSDictionary *dict = @{@"tel":self.iphoneStr,@"password":[EncapsulationMethod md5:_newPassword]};
        NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Register/register",Main_Server];
        [XAFNetWork POST:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            jxt_showToastMessage(responseObject[@"msg"], 1);
            if ([responseObject[@"code"] integerValue]) {
                
                [[UIApplication sharedApplication].keyWindow endEditing:NO];
                [[EncapsulationMethod viewController:self] dismissViewControllerAnimated:NO completion:nil];
                
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        jxt_showToastMessage(@"两次密码不一致", 1);
    }
    
}
@end
