//
//  registerViewController.m
//  registrationDebarkation
//
//  Created by 邵峰 on 2017/4/7.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import "registerViewController.h"
#import "registerInterface.h"
#import "IQKeyboardManager.h"
//#import "SFNetWorkManager.h"
//#import "SFProgressHUD.h"
#import "UUID.h"

@interface registerViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) registerInterface *registerView;
@end

@implementation registerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:84];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    //监听输入框内文字改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChangeValue:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
}



- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadRegisterInterface];
    

}
// 验证邮箱格式
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (void)loadRegisterInterface
{
    _registerView = [registerInterface loadRegisterView];
    _registerView.frame = self.view.frame;
    [_registerView btnClicked:^(UIButton *btn) {
        if (btn ==_registerView.backBtn) {
            [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else  {
            
            NSString *email = _registerView.accountTF.text;
            NSString *passWord =_registerView.passwordTF.text;
            NSString *passWord2 = _registerView.confirmPasswordTF.text;
            NSString *sessionId = [UUID getUUID];
            NSDictionary *param = NSDictionaryOfVariableBindings(email,passWord,passWord2,sessionId);

            __weak typeof(self) weakself = self;
//            [SFNetWorkManager requestWithType:HttpRequestTypePost withUrlString:[NSString stringWithFormat:@"%@jsonService/user/reg.json",Main_Server] withParaments:param withSuccessBlock:^(NSDictionary *object) {
//
//                NSLog(@"%@",object);
//                NSNumber *ruslt =[object valueForKey:@"code"] ;
//                NSInteger code = [ruslt integerValue];
//                switch (code) {
//                    case 0:{
//                        [SFProgressHUD showMessage:@"注册成功" inView:weakself.registerView afterDelayTime:3.0];
//                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//                            [self dismissViewControllerAnimated:YES completion:nil];
//                        });
//
//                        break;
//                    }
//
//                    case 1:
//                        [SFProgressHUD showMessage:@"邮箱已注册" inView:weakself.registerView afterDelayTime:3.0];
//                        break;
//
//                    case 2:
//                        [SFProgressHUD showMessage:@"邮箱不能为空" inView:weakself.registerView afterDelayTime:3.0];
//                        break;
//                    case 3:
//                        [SFProgressHUD showMessage:@"密码不能为空" inView:weakself.registerView afterDelayTime:3.0];
//                        break;
//                    case 4:
//                        [SFProgressHUD showMessage:@"邮箱格式不正确" inView:weakself.registerView afterDelayTime:3.0];
//                        break;
//                    case 5:
//                        [SFProgressHUD showMessage:@"密码应该在5-10位之间" inView:weakself.registerView afterDelayTime:3.0];
//                        break;
//                    case 6:
//                        [SFProgressHUD showMessage:@"两次密码不一致" inView:weakself.registerView afterDelayTime:3.0];
//                        break;
//                    default:
//                        break;
//                }
//
//
//            } withFailureBlock:^(NSError *error) {
//                NSLog(@"%@",error);
//            } progress:^(float progress) {
//                //
//            }];
        }
    }];
    [self.view addSubview:_registerView];
}

//监听输入框内值得改变
- (void)textFieldDidChangeValue:(NSNotification *)notification{
    if (_registerView.accountTF.text.length && _registerView.passwordTF.text.length && _registerView.confirmPasswordTF.text.length) {
        _registerView.registerBtn.enabled = YES;
    }else{
        _registerView.registerBtn.enabled = NO;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
