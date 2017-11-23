//
//  registeredView.m
//  yizu
//
//  Created by 徐健 on 2017/11/1.
//  Copyright © 2017年 XuJian. All rights reserved.
//
#define PasswordTextFieldTag    18888888
#define ConfirmPasswordTextFieldTag    188888881
#define PassWord_Digits    6

#import "registeredView.h"
#import "mytimer.h"
#import "AgreementView.h"

@interface registeredView ()<UITextFieldDelegate>
{
    NSString *_inputVcode;
    NSString *_oldPassword;
    NSString *_newPassword;
    BOOL _isAgreement;
}
@property (nonatomic,strong)UIButton *CodeBtn;//获取验证码
@property (nonatomic, strong) UITextField *verificationCodeText;
@property (nonatomic, strong) UITextField *phoneText;
@property (nonatomic, strong) UIImageView *backView;

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
        _isAgreement = YES;
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
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    backImageView.backgroundColor =[UIColor colorWithRed:0.95f green:0.95f blue:0.94f alpha:1.00f];;
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    self.backView =backImageView;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 20, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:leftBtn];
    
    UILabel *titleLabel= [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(kSCREEN_WIDTH/2-224/2/2, 20, 224/2, 44);
    titleLabel.text = @"新用户注册";
    titleLabel.font = kFontTopTitleBold;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [backImageView addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconRegistered"]];
    imageView.frame = CGRectMake(kSCREEN_WIDTH/2-205/2/2, titleLabel.y+titleLabel.height+86/2, 205/2, 205/2);
    [backImageView addSubview:imageView];
    
    UILabel *yizuLabel= [[UILabel alloc] init];
    yizuLabel.frame = CGRectMake(kSCREEN_WIDTH/2-224/2/2, imageView.y+imageView.height+34/2, 224/2, 44);
    yizuLabel.text = @"依足";
    yizuLabel.textAlignment = NSTextAlignmentCenter;
    [backImageView addSubview:yizuLabel];
    
    UITextField *emailTextField = [[UITextField alloc] init];
    emailTextField.frame = CGRectMake(kSCREEN_WIDTH/2-(kSCREEN_WIDTH-145/3*2)/2,yizuLabel.y+yizuLabel.height+94/2,kSCREEN_WIDTH-145/3*2,40);
    emailTextField.keyboardType = UIKeyboardTypeNumberPad;
    [backImageView addSubview:emailTextField];
    self.phoneText = emailTextField;
    [self addtextField:emailTextField Withplaceholder:@"请输入手机" andTag:0 andTextFieldtext:self.iphoneStr];
    
    UITextField *verificationCodeTextField = [[UITextField alloc] init];
    verificationCodeTextField.frame = CGRectMake(emailTextField.x,emailTextField.y+emailTextField.height+10,emailTextField.width,40);
    verificationCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [backImageView addSubview:verificationCodeTextField];
    self.verificationCodeText = verificationCodeTextField;
    [self addtextField:verificationCodeTextField Withplaceholder:@"请输入验证码" andTag:0 andTextFieldtext:@""];
    
    _CodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _CodeBtn.frame = CGRectMake(verificationCodeTextField.x+verificationCodeTextField.width-80, verificationCodeTextField.y, 80, verificationCodeTextField.height);
    self.isq?(_CodeBtn.userInteractionEnabled = NO):(_CodeBtn.userInteractionEnabled = YES);
    [_CodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_CodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _CodeBtn.titleLabel.font =kFontBodySubtitle;
    _CodeBtn.backgroundColor = [UIColor clearColor];
    [_CodeBtn addTarget:self action:@selector(CodeBtnClic:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:_CodeBtn];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.frame = CGRectMake(verificationCodeTextField.x,verificationCodeTextField.y+verificationCodeTextField.height+10,emailTextField.width,verificationCodeTextField.height);
    [backImageView addSubview:passwordTextField];
    [self addtextField:passwordTextField Withplaceholder:@"请输入新密码" andTag:PasswordTextFieldTag andTextFieldtext:@""];

    
    UITextField *passwordTextField2 = [[UITextField alloc] init];
    passwordTextField2.frame = CGRectMake(passwordTextField.x,passwordTextField.y+passwordTextField.height+10,passwordTextField.width,passwordTextField.height);
    [backImageView addSubview:passwordTextField2];
    [self addtextField:passwordTextField2 Withplaceholder:@"请确认新密码" andTag:ConfirmPasswordTextFieldTag andTextFieldtext:@""];

    //注册按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(passwordTextField2.x, passwordTextField2.y+passwordTextField2.height+20, passwordTextField2.width, passwordTextField2.height);
    [button setTitle:@"注册" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:button];
    
    AgreementView *view = [[AgreementView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2-200/2, kSCREEN_HEIGHT-147/3-22, 200, 20) andTitleColor:[UIColor blackColor]];
    view.block = ^(UIButton *classBtn) {
        _isAgreement = classBtn.selected;
    };
    [backImageView addSubview:view];
}
- (void)addtextField:(UITextField *)textField Withplaceholder:(NSString *)placeholder andTag:(NSInteger)textFieldTag andTextFieldtext:(NSString *)textStr{
    
    textField.text = textStr;
    textField.placeholder = placeholder;
    [textField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.textColor = [UIColor blackColor];
    textField.delegate = self;
    textField.tag = textFieldTag;
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    textField.leftView = textView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.frame = CGRectMake(textField.x, textField.y+textField.height, textField.width, 0.5);
    [self.backView addSubview:lineView];
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
            [self stopTimer];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self stopTimer];
    }];
}
- (void)stopTimer
{
    [[mytimer sharetimer] stopTimer];
    _CodeBtn.userInteractionEnabled = YES;
    [_CodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:self.phoneText]) {
        self.iphoneStr = textField.text;
    }
    if ([textField isEqual:_verificationCodeText]) {
        if (!textField.text.length) {
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
                if ([textField.text isEqualToString:[XSaverTool objectForKey:VerificationCode]]) {
                    
                }else{
                    jxt_showAlertTitle(@"验证码不正确");
                    textField.text = @"";
                }
            }
        _inputVcode = textField.text;
    }
    if (textField.tag == PasswordTextFieldTag) {
        if (textField.text.length >= PassWord_Digits) {
            _oldPassword = textField.text;
        }else if (textField.text.length > 0) {
            jxt_showToastMessage(@"请输入六位密码", 1);
            textField.text = @"";
        }
    }else if (textField.tag == ConfirmPasswordTextFieldTag) {
        if (textField.text.length >= PassWord_Digits) {
            _newPassword = textField.text;
        }else if (textField.text.length > 0) {
            jxt_showToastMessage(@"请输入六位密码", 1);
            textField.text = @"";
        }
    }
}
- (void)onClick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    if (_isAgreement) {
        if (!_oldPassword.length||!_newPassword.length) {
            jxt_showAlertTitle(@"请输入账号或密码");
            return;
        }
        if (![XSaverTool objectForKey:VerificationCode]) {
            jxt_showAlertTitle(@"请获取验证码");
            return;
        }
        if (!_inputVcode) {
            jxt_showAlertTitle(@"请输入验证码");
            return;
        }
        
        if ([_oldPassword isEqualToString:_newPassword]) {
            NSDictionary *dict = @{@"tel":self.iphoneStr,@"password":[EncapsulationMethod md5:_newPassword]};
            NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Register/register",Main_Server];
            [XAFNetWork POST:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                jxt_showToastMessage(responseObject[@"msg"], 1);
                if ([responseObject[@"code"] integerValue]) {
                    
                    [XSaverTool setObject:self.iphoneStr forKey:PhoneKey];
                    [[UIApplication sharedApplication].keyWindow endEditing:NO];
                    [[EncapsulationMethod viewController:self] dismissViewControllerAnimated:NO completion:nil];
                    
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
        }else{
            jxt_showToastMessage(@"两次密码不一致", 1);
        }
    }else{
        jxt_showAlertTitle(@"请同意协议");
    }
    
}
@end
