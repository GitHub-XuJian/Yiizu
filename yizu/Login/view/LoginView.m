//
//  LoginView.m
//  yizu
//
//  Created by 徐健 on 2017/10/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()<UITextFieldDelegate>

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    backImageView.frame = CGRectMake(0, 0, self.width, self.height);
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    
    UIButton *leftBtn = [self createButtonWithFrame:CGRectMake(10, 20, 44, 44) andImageStr:@"back" andTitleStr:@"" andBtnTag:Back andTitleColor:nil];
    [backImageView addSubview:leftBtn];
    
    UIButton *rightBtn = [self createButtonWithFrame:CGRectMake(kSCREEN_WIDTH-100,20, 90, 44) andImageStr:nil andTitleStr:@"新用户注册" andBtnTag:RegisterBtn andTitleColor:[UIColor blackColor]];
    [backImageView addSubview:rightBtn];
    
    UITextField *accountTextField = [[UITextField alloc] init];
    accountTextField.frame = CGRectMake(50, kSCREEN_HEIGHT/2-80/2, kSCREEN_WIDTH-100, 40);
    accountTextField.placeholder = @"请输入手机号";
    accountTextField.delegate = self;
//    accountTextField.text = @"13898388023";
    [backImageView addSubview:accountTextField];
    self.accountTextField = accountTextField;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(accountTextField.x, accountTextField.y+accountTextField.height+0.5, accountTextField.width, 0.5)];
    lineView.backgroundColor = kColorLine;
    [backImageView addSubview:lineView];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.frame = CGRectMake(accountTextField.x, accountTextField.y+accountTextField.height+5, accountTextField.width, accountTextField.height);
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.delegate = self;
//    passwordTextField.text = @"1394";
    passwordTextField.secureTextEntry = YES;
    [backImageView addSubview:passwordTextField];
    self.passWordTextField = passwordTextField;
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(passwordTextField.x, passwordTextField.y+passwordTextField.height+0.5, passwordTextField.width, 0.5)];
    lineView2.backgroundColor = kColorLine;
    [backImageView addSubview:lineView2];
    
    UIButton *loginBtn = [self createButtonWithFrame:CGRectMake(lineView2.x,lineView2.y+lineView2.height+40, lineView2.width, passwordTextField.height) andImageStr:nil andTitleStr:@"登录" andBtnTag:Login andTitleColor:[UIColor blackColor]];
    loginBtn.backgroundColor = kColorLine;
    [backImageView addSubview:loginBtn];
    
    UIButton *forgotPasswordBtn = [self createButtonWithFrame:CGRectMake(loginBtn.x,loginBtn.y+loginBtn.height+30, 70, 44) andImageStr:nil andTitleStr:@"忘记密码?" andBtnTag:ForgotPassword andTitleColor:[UIColor blackColor]];
    [backImageView addSubview:forgotPasswordBtn];
    
    NSArray *array = @[@"微信",@"QQ"];
    for (int i = 0; i < array.count; i++) {
        UIButton *thirdPartybtn = [self createButtonWithFrame:CGRectMake(kSCREEN_WIDTH/2-(44*array.count+20)/2+i*50,kSCREEN_HEIGHT-100, 44, 44) andImageStr:nil andTitleStr:array[i] andBtnTag:i+WeiXin andTitleColor:[UIColor blackColor]];
        thirdPartybtn.backgroundColor = [UIColor clearColor];
        [backImageView addSubview:thirdPartybtn];
    }
}
- (void)btnClickedAction:(UIButton *)btn
{
    if (_block) {
        _block((int)btn.tag,self.passWordTextField.text);
    }
}
- (void)btnClicked:(btnClicked)block
{
    _block = block;
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
