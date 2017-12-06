//
//  SFValidationEmailViewController.m
//  ContactsManager
//
//  Created by 徐健 on 17/7/14.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import "SFValidationEmailViewController.h"
#import "mytimer.h"
#import "OldAndNewPassWordViewController.h"

@interface SFValidationEmailViewController ()<UITextFieldDelegate>
{
    NSString *_inputVcode;
}
@property (nonatomic,strong)UIButton *CodeBtn;//获取验证码
@property (nonatomic,assign)BOOL isq;
@property (nonatomic, strong) UITextField *emailText;
@property (nonatomic, strong) UITextField *verificationCodeText;
@property (nonatomic, strong) UIImageView *backView;
@end

@implementation SFValidationEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    if (!self.navigationController) {
        [self createBackBtn];
    }
    [self createUI];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"mytimertongzhi" object:nil];
}
- (void)createBackBtn
{
    SFNavView *navView = [[SFNavView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64) andTitle:self.validationStr andLeftBtnTitle:@"返回" andRightBtnTitle:nil andLeftBtnBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    } andRightBtnBlock:^{
        
    }];
    [self.view addSubview:navView];
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
    self.backView = backImageView;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 20, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:leftBtn];
    
    UITextField *emailTextField = [[UITextField alloc] init];
    emailTextField.frame = CGRectMake(kSCREEN_WIDTH/2-(kSCREEN_WIDTH-145/3*2)/2,100,kSCREEN_WIDTH-145/3*2,40);
    [backImageView addSubview:emailTextField];
    self.emailText = emailTextField;
    [self addtextField:emailTextField Withplaceholder:@"请输入手机" andTag:0 andTextFieldtext:self.emailStr];
    
    UITextField *verificationCodeTextField = [[UITextField alloc] init];
    verificationCodeTextField.frame = CGRectMake(emailTextField.x,emailTextField.y+emailTextField.height+20,emailTextField.width,40);
    [backImageView addSubview:verificationCodeTextField];
    self.verificationCodeText = verificationCodeTextField;
    [self addtextField:verificationCodeTextField Withplaceholder:@"请输入验证码" andTag:0 andTextFieldtext:@""];
    
    
    _CodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _CodeBtn.frame = CGRectMake((verificationCodeTextField.x+verificationCodeTextField.width)-80, verificationCodeTextField.y,80, verificationCodeTextField.height);
    self.isq?(_CodeBtn.userInteractionEnabled = NO):(_CodeBtn.userInteractionEnabled = YES);
    [_CodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_CodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _CodeBtn.titleLabel.font =kFontBodySubtitleBold;
    _CodeBtn.backgroundColor = [UIColor clearColor];
    [_CodeBtn addTarget:self action:@selector(CodeBtnClic:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:_CodeBtn];
    
    //登录按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(verificationCodeTextField.x, verificationCodeTextField.y+verificationCodeTextField.height+20, verificationCodeTextField.width, 40);
    [button setTitle:self.isValidation?@"确定":@"下一步" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"nextstep"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:button];
}
- (void)onClick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];

    if (!_inputVcode) {
        jxt_showAlertTitle(@"请输入验证码");
        return;
    }
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[XSaverTool objectForKey:VerificationCodeTime] doubleValue]];
    NSDate * now = [NSDate date];
    NSTimeInterval timeBetween = [now timeIntervalSinceDate:date];
    DLog(@"%f",timeBetween);
    NSInteger sec = (NSInteger)timeBetween;
    DLog(@"%ld",(long)sec);
    
    if (sec>300) {
        jxt_showAlertTitle(@"验证码超时");
    }else{
        if ([_inputVcode isEqualToString:[XSaverTool objectForKey:VerificationCode]]) {
            if (self.isValidation) {
                if (self.isBindingPhone) {
                    NSDictionary *dict = @{@"tel":self.emailText.text,@"personid":[XSaverTool objectForKey:UserIDKey]};
                    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Mine/modifMobile",Main_Server];
                    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                        DLog(@"%@",responseObject);
                        jxt_showToastMessage(responseObject[@"msg"], 1);
                        NSInteger code = [responseObject[@"code"] integerValue];
                        if (code == 1) {
                            [XSaverTool setObject:self.emailText.text forKey:isPhone];
                            [XSaverTool setObject:self.emailText.text forKey:PhoneKey];
                            
                            [self.navigationController popToRootViewControllerAnimated:YES];;
                        }
                    } fail:^(NSURLSessionDataTask *task, NSError *error) {
                        jxt_showToastMessage(@"修改失败",1);
                    }];
                }else{
                    NSDictionary *dict = @{@"tel":self.emailText.text,@"sunshine":[UUID getUUID]};
                    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Login/yanzheng",Main_Server];
                    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                        DLog(@"%@",responseObject);
                        jxt_showToastMessage(responseObject[@"msg"], 1);
                        NSInteger code = [responseObject[@"code"] integerValue];
                        if (code == 1) {
                            [XSaverTool setObject:self.emailText.text forKey:isPhone];
                            [XSaverTool setObject:self.emailText.text forKey:PhoneKey];
                            
                            _validationBlock(responseObject);
                            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
                        }
                    } fail:^(NSURLSessionDataTask *task, NSError *error) {
                        jxt_showToastMessage(@"登录失败",1);
                    }];
                }
               
            }else{
                OldAndNewPassWordViewController *onpVC = [[OldAndNewPassWordViewController alloc] init];
                onpVC.phoneStr = self.emailText.text;
                onpVC.block = ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                };
                [self presentViewController:onpVC animated:YES completion:nil];
            }
           
        }else{
            jxt_showAlertTitle(@"验证码不正确");
        }
    }
}
//获取验证码
-(void)CodeBtnClic:(UIButton*)sender{
    if (_emailText.text.length == 0) {
        jxt_showAlertTitle(@"手机号不能为空");
    }else{
        //倒计时
        [[mytimer sharetimer] makeTimer];
        NSDictionary *dict = @{@"tel":self.emailText.text};
        NSString *yzmStr;
        if (self.isValidation) {
            yzmStr = @"Mobile/Login/alteryzm";
        }else{
            yzmStr = @"Mobile/Login/trueyzm";
        }
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",Main_Server,yzmStr];
        [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            DLog(@"%@",responseObject);
            jxt_showToastMessage(responseObject[@"msg"], 1);
            NSInteger code = [responseObject[@"code"] integerValue];
            if (code == 1) {
                self.emailText.enabled = NO;
                self.emailText.textColor = kLightGrayTextColor;
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
- (void)addtextField:(UITextField *)textField Withplaceholder:(NSString *)placeholder andTag:(NSInteger)textFieldTag andTextFieldtext:(NSString *)textStr{
    
    textField.text = textStr;
    textField.placeholder = placeholder;
    textField.keyboardType = UIKeyboardTypeNumberPad;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
