//
//  LoginView.m
//  yizu
//
//  Created by 徐健 on 2017/10/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "LoginView.h"
#import "AgreementView.h"

@interface LoginView ()<UITextFieldDelegate>
{
    BOOL _isAgreement;
}
@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        _isAgreement = YES;
    }
    return self;
}
- (void)createUI
{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beijing1"]];
    backImageView.frame = CGRectMake(0, 0, self.width, self.height);
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    
    UIButton *leftBtn = [self createButtonWithFrame:CGRectMake(10, 20, 44, 44) andImageStr:@"arrow-L - Assistor" andTitleStr:@"" andBtnTag:Back andTitleColor:nil];
    [backImageView addSubview:leftBtn];
    
    UIButton *rightBtn = [self createButtonWithFrame:CGRectMake(kSCREEN_WIDTH-100,20, 90, 44) andImageStr:nil andTitleStr:@"新用户注册" andBtnTag:RegisterBtn andTitleColor:[UIColor whiteColor]];
    [backImageView addSubview:rightBtn];
    
    UITextField *accountTextField = [[UITextField alloc] init];
    accountTextField.frame = CGRectMake(50, 806/3, kSCREEN_WIDTH-100, 40);
    accountTextField.placeholder = @"请输入手机号";
    accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    [accountTextField setValue:kColorLine forKeyPath:@"_placeholderLabel.textColor"];
    accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountTextField.delegate = self;
    accountTextField.textColor = [UIColor whiteColor];
    accountTextField.text = [XSaverTool objectForKey:PhoneKey];
    [backImageView addSubview:accountTextField];
    self.accountTextField = accountTextField;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(accountTextField.x, accountTextField.y+accountTextField.height+0.5, accountTextField.width, 0.5)];
    lineView.backgroundColor = kColorLine;
    [backImageView addSubview:lineView];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.frame = CGRectMake(accountTextField.x, accountTextField.y+accountTextField.height+5, accountTextField.width, accountTextField.height);
    passwordTextField.placeholder = @"请输入密码";
    [passwordTextField setValue:kColorLine forKeyPath:@"_placeholderLabel.textColor"];
    passwordTextField.delegate = self;
    passwordTextField.textColor = [UIColor whiteColor];
//    passwordTextField.text = @"1394";
    passwordTextField.secureTextEntry = YES;
    [backImageView addSubview:passwordTextField];
    self.passWordTextField = passwordTextField;
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(passwordTextField.x, passwordTextField.y+passwordTextField.height+0.5, passwordTextField.width, 0.5)];
    lineView2.backgroundColor = kColorLine;
    [backImageView addSubview:lineView2];
    
    UIButton *loginBtn = [self createButtonWithFrame:CGRectMake(lineView2.x,lineView2.y+lineView2.height+82/3, lineView2.width, passwordTextField.height) andImageStr:nil andTitleStr:@"登录" andBtnTag:Login andTitleColor:[UIColor blackColor]];
    loginBtn.backgroundColor = kColorLine;
    [backImageView addSubview:loginBtn];
    
    UIButton *forgotPasswordBtn = [self createButtonWithFrame:CGRectMake(loginBtn.x,loginBtn.y+loginBtn.height+101/3, 70, 44) andImageStr:nil andTitleStr:@"忘记密码?" andBtnTag:ForgotPassword andTitleColor:[UIColor whiteColor]];
    [backImageView addSubview:forgotPasswordBtn];
    
    UIButton *weixinbtn = [self createButtonWithFrame:CGRectMake(kSCREEN_WIDTH/2-128/2,kSCREEN_HEIGHT-226/3-44, 44, 44) andImageStr:@"button_WeiXin2" andTitleStr:nil andBtnTag:WeiXin andTitleColor:[UIColor blackColor]];
    weixinbtn.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:weixinbtn];
    
    UIButton *qqbtn = [self createButtonWithFrame:CGRectMake(weixinbtn.x+weixinbtn.width+120/3,weixinbtn.y, 44, 44) andImageStr:@"button_QQ2" andTitleStr:nil andBtnTag:QQ andTitleColor:[UIColor blackColor]];
    qqbtn.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:qqbtn];

    AgreementView *view = [[AgreementView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2-200/2, kSCREEN_HEIGHT-147/3-22, 200, 20) andTitleColor:[UIColor whiteColor]];
    view.block = ^(UIButton *classBtn) {
        _isAgreement = classBtn.selected;
    };
    [backImageView addSubview:view];
    
}

- (void)btnClickedAction:(UIButton *)btn
{
    if (btn.tag == Login) {
        if (_isAgreement) {
            if (_block) {
                _block((int)btn.tag,self.passWordTextField.text);
            }
            
        }else{
            jxt_showAlertTitle(@"请同意协议");
        }
    }else{
        if (_block) {
            _block((int)btn.tag,self.passWordTextField.text);
        }
    }
}
- (void)btnClicked:(btnClicked)block
{
    _block = block;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"123131231");
    if (textField == self.accountTextField) {
        self.accountTextField.text = @"";
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.accountTextField) {
        if (![EncapsulationMethod isValidatePhone:textField.text]) {
            jxt_showAlertTitle(@"请输入正确的手机号");
            return;
        }
    }
}
- (UIButton *)createButtonWithFrame:(CGRect)frame andImageStr:(NSString *)imageStr andTitleStr:(NSString *)titleStr andBtnTag:(BtnloginType)typeTag andTitleColor:(UIColor *)titleColor{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:titleStr forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.tag = typeTag;
    btn.titleLabel.font = kFontOther;
    [btn addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
