//
//  OldAndNewPassWordViewController.m
//  yizu
//
//  Created by 徐健 on 2017/10/31.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#define PasswordTextFieldTag   10000000
#define ConfirmPasswordTextFieldTag   10000001
#define PassWord_Digits   6

#import "OldAndNewPassWordViewController.h"

@interface OldAndNewPassWordViewController ()<UITextFieldDelegate>
{
    NSString *_oldPassword;
    NSString *_newPassword;
}
@end

@implementation OldAndNewPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];

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
    [emailTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    emailTextField.textColor = [UIColor grayColor];
    emailTextField.layer.borderColor= [UIColor blackColor].CGColor;
    emailTextField.layer.borderWidth= 1.0f;
    emailTextField.delegate = self;
    emailTextField.text = self.phoneStr;
    emailTextField.enabled = NO;
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    emailTextField.leftView = textView;
    emailTextField.leftViewMode = UITextFieldViewModeAlways;
    [backImageView addSubview:emailTextField];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.frame = CGRectMake(20,emailTextField.y+emailTextField.height+20,emailTextField.width,40);
    passwordTextField.placeholder = @"请输入新密码";
    [passwordTextField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.layer.borderColor= [UIColor blackColor].CGColor;
    passwordTextField.layer.borderWidth= 1.0f;
    passwordTextField.delegate = self;
    passwordTextField.tag = PasswordTextFieldTag;
    UIView *textView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    passwordTextField.leftView = textView1;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [backImageView addSubview:passwordTextField];
    
    UITextField *passwordTextField2 = [[UITextField alloc] init];
    passwordTextField2.frame = CGRectMake(20,passwordTextField.y+passwordTextField.height+20,emailTextField.width,40);
    passwordTextField2.placeholder = @"请确认新密码";
    [passwordTextField2 setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    passwordTextField2.textColor = [UIColor blackColor];
    passwordTextField2.tag = ConfirmPasswordTextFieldTag;
    passwordTextField2.layer.borderColor= [UIColor blackColor].CGColor;
    passwordTextField2.layer.borderWidth= 1.0f;
    passwordTextField2.delegate = self;
    UIView *textView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    passwordTextField2.leftView = textView2;
    passwordTextField2.leftViewMode = UITextFieldViewModeAlways;
    [backImageView addSubview:passwordTextField2];
    
    //登录按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(passwordTextField2.x, passwordTextField2.y+passwordTextField2.height+20, kSCREEN_WIDTH-40, 40);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:button];
}
- (void)onClick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    if ([_oldPassword isEqualToString:_newPassword]) {
        NSDictionary *dict = @{@"tel":self.phoneStr,@"password":[EncapsulationMethod md5:_newPassword]};
        NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Login/Rpass",Main_Server];
        [XAFNetWork POST:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            jxt_showToastMessage(responseObject[@"msg"], 1);
            if ([responseObject[@"code"] integerValue]) {
                
                if (self.navigationController) {
                    [XSaverTool setObject:_newPassword forKey:Password];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
    }else{
        jxt_showToastMessage(@"两次密码不一致", 1);
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
