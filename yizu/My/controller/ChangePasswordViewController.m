//
//  ChangePasswordViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/16.
//  Copyright © 2017年 XuJian. All rights reserved.
//
#define OldPasswordTag  999999
#define NewPasswordTag  888888
#define NewNewPasswordTag  777777

#define PassWord_Digits  6



#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>
{
    NSString *_oldPassword;
    NSString *_newPassword;
    NSString *_oldoldPassword;

}
@property (nonatomic, strong) UIImageView *backView;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    [self createUI];

}

- (void)createUI
{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    backImageView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    self.backView = backImageView;
    
    UITextField *emailTextField = [[UITextField alloc] init];
    emailTextField.frame = CGRectMake(kSCREEN_WIDTH/2-(kSCREEN_WIDTH-100)/2,100,kSCREEN_WIDTH-100,40);
    [backImageView addSubview:emailTextField];
    [self addtextField:emailTextField Withplaceholder:@"请输入旧密码" andTag:OldPasswordTag andTextFieldtext:@""];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.frame = CGRectMake(emailTextField.x,emailTextField.y+emailTextField.height+20,emailTextField.width,40);
    [backImageView addSubview:passwordTextField];
    [self addtextField:passwordTextField Withplaceholder:@"请输入新密码" andTag:NewPasswordTag andTextFieldtext:@""];

    UITextField *passwordTextField2 = [[UITextField alloc] init];
    passwordTextField2.frame = CGRectMake(emailTextField.x,passwordTextField.y+passwordTextField.height+20,emailTextField.width,40);
    [backImageView addSubview:passwordTextField2];
    [self addtextField:passwordTextField2 Withplaceholder:@"请确认新密码" andTag:NewNewPasswordTag andTextFieldtext:@""];
    
    //登录按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(passwordTextField2.x, passwordTextField2.y+passwordTextField2.height+20, emailTextField.width, 40);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"nextstep"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:button];
}
- (void)onClick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    if (!_oldoldPassword.length) {
        jxt_showAlertTitle(@"请输入旧密码");
        return;
    }
    if (!_oldPassword.length) {
        jxt_showAlertTitle(@"请输入新密码");
        return;
    }
    if (!_newPassword.length) {
        jxt_showAlertTitle(@"请输入确认新密码");
        return;
    }
    if ([_oldPassword isEqualToString:_newPassword]) {
        NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey],@"password":[EncapsulationMethod md5:_oldoldPassword],@"Repassword":[EncapsulationMethod md5:_newPassword]};
        NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Mine/modifypass",Main_Server];
        [XAFNetWork POST:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            DLog(@"%@",responseObject);
            jxt_showToastMessage(responseObject[@"msg"], 1);
            if ([responseObject[@"code"] integerValue]) {
                [XSaverTool setObject:_newPassword forKey:Password];
                [self.navigationController popViewControllerAnimated:YES];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            DLog(@"%@",error);
        }];
    }else{
        jxt_showToastMessage(@"两次密码不一致", 1);
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == OldPasswordTag) {
        _oldoldPassword = textField.text;
    }else if (textField.tag == NewPasswordTag) {
        if (textField.text.length >= PassWord_Digits) {
            _oldPassword = textField.text;
        }else if (textField.text.length > 0) {
            jxt_showToastMessage(@"请输入六位密码", 1);
            textField.text = @"";
        }
    }else if (textField.tag == NewNewPasswordTag) {
        if (textField.text.length >= PassWord_Digits) {
            _newPassword = textField.text;
        }else if (textField.text.length > 0) {
            jxt_showToastMessage(@"请输入六位密码", 1);
            textField.text = @"";
        }
    }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
