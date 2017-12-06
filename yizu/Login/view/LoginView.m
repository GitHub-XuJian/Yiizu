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
    
    UIButton *leftBtn = [self createButtonWithFrame:CGRectMake(10, 20, 44, 44) andImageStr:@"back" andTitleStr:@"" andBtnTag:Back andTitleColor:nil];
    [backImageView addSubview:leftBtn];
    
    UITextField *accountTextField = [[UITextField alloc] init];
    accountTextField.frame = CGRectMake(50, 806/3, kSCREEN_WIDTH-100, 40);
    accountTextField.placeholder = @"请输入手机号";
    accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountTextField.delegate = self;
    accountTextField.backgroundColor = [UIColor whiteColor];
    accountTextField.text = [XSaverTool objectForKey:PhoneKey];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    accountTextField.leftView = view;
    accountTextField.leftViewMode = UITextFieldViewModeAlways;
    //设置圆角
    accountTextField.layer.cornerRadius = 10/2;
    //将多余的部分切掉
    accountTextField.layer.masksToBounds = YES;
    [backImageView addSubview:accountTextField];
    self.accountTextField = accountTextField;
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.frame = CGRectMake(accountTextField.x, accountTextField.y+accountTextField.height+15, accountTextField.width, accountTextField.height);
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.delegate = self;
    passwordTextField.secureTextEntry = YES;
    UIView *passwordview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 40)];
    passwordTextField.leftView = passwordview;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    //设置圆角
    passwordTextField.layer.cornerRadius = 10/2;
    //将多余的部分切掉
    passwordTextField.layer.masksToBounds = YES;
    [backImageView addSubview:passwordTextField];
    self.passWordTextField = passwordTextField;

    UIButton *loginBtn = [self createButtonWithFrame:CGRectMake(passwordTextField.x,passwordTextField.y+passwordTextField.height+82/3, passwordTextField.width, passwordTextField.height) andImageStr:nil andTitleStr:@"登录" andBtnTag:Login andTitleColor:[UIColor colorWithRed:0.62f green:0.11f blue:0.19f alpha:1.00f]];
    //设置圆角
    loginBtn.layer.cornerRadius = passwordTextField.height/2;
    //将多余的部分切掉
    loginBtn.layer.masksToBounds = YES;
    loginBtn.backgroundColor = kColorLine;
    [backImageView addSubview:loginBtn];
    
    UIButton *forgotPasswordBtn = [self createButtonWithFrame:CGRectMake(loginBtn.x,loginBtn.y+loginBtn.height+10, 70, 44) andImageStr:nil andTitleStr:@"忘记密码?" andBtnTag:ForgotPassword andTitleColor:[UIColor colorWithRed:0.62f green:0.11f blue:0.19f alpha:1.00f]];
    [backImageView addSubview:forgotPasswordBtn];
    
    UIButton *rightBtn = [self createButtonWithFrame:CGRectMake(kSCREEN_WIDTH-50-80,forgotPasswordBtn.y, 80, 44) andImageStr:nil andTitleStr:@"新用户注册" andBtnTag:RegisterBtn andTitleColor:[UIColor colorWithRed:0.62f green:0.11f blue:0.19f alpha:1.00f]];
    [backImageView addSubview:rightBtn];
    
    UIButton *weixinbtn = [self createButtonWithFrame:CGRectMake(kSCREEN_WIDTH/2-128/2,kSCREEN_HEIGHT-226/3-44, 44, 44) andImageStr:@"button_WeiXin2" andTitleStr:nil andBtnTag:WeiXin andTitleColor:[UIColor blackColor]];
    weixinbtn.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:weixinbtn];
    
    UIButton *qqbtn = [self createButtonWithFrame:CGRectMake(weixinbtn.x+weixinbtn.width+120/3,weixinbtn.y, 44, 44) andImageStr:@"button_QQ2" andTitleStr:nil andBtnTag:QQ andTitleColor:[UIColor blackColor]];
    qqbtn.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:qqbtn];

    AgreementView *agreementView = [[AgreementView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2-210/2, kSCREEN_HEIGHT-147/3, 210, 40) andTitleColor:[UIColor whiteColor]];
    agreementView.block = ^(UIButton *classBtn) {
        _isAgreement = classBtn.selected;
    };
    [backImageView addSubview:agreementView];
    
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
    DLog(@"123131231");
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
    btn.titleLabel.font = kFontBodySubtitle;
    [btn addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
@end
