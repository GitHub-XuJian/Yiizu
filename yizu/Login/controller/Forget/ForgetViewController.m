//
//  ForgetViewController.m
//  registrationDebarkation
//
//  Created by 邵峰 on 2017/4/13.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import "ForgetViewController.h"
#import "resetPassword.h"
#import "XSaverTool.h"

@interface ForgetViewController ()
@property(nonatomic, strong) resetPassword *resetPasswordView;
@end

@implementation ForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadResetPasswordView];
}

- (void)loadResetPasswordView
{
    _resetPasswordView = [resetPassword loadResetPasswordView];
    _resetPasswordView.frame = self.view.frame;
    [self.view addSubview:_resetPasswordView];
    [_resetPasswordView btnClicked:^(UIButton *btn) {
        if (btn ==_resetPasswordView.backBtn) {
            [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
//            __weak typeof(self) weakself = self;
//            if (!weakself.resetPasswordView.account.text && !weakself.resetPasswordView.OldPassword.text && !weakself.resetPasswordView.NewPassword.text ) {
//                if ([weakself.resetPasswordView.NewPassword.text isEqualToString:weakself.resetPasswordView.confirmNewPassword.text]) {
//
//
//                    NSString *userid = [SFSaveTool objectForKey:UserIDKey];
//                    // id:2c92a8ee5bae4482015bc4c8aab00001
//                    NSString *oldpassWord =_resetPasswordView.OldPassword.text;
//                    NSString *newpassWord = _resetPasswordView.NewPassword.text;
//                    NSDictionary *param = NSDictionaryOfVariableBindings(userid,oldpassWord,newpassWord);
//                    [SFNetWorkManager requestWithType:HttpRequestTypePost withUrlString:@"jsonService/user/updatePwd.json" withParaments:param withSuccessBlock:^(NSDictionary *object) {
//
//                        NSNumber *ruslt =[object valueForKey:@"code"] ;
//                        NSInteger code = [ruslt integerValue];
//
//                        switch (code) {
//                            case 0:{
//                                NSLog(@"密码修改成功");
//                                [SFProgressHUD show:@"密码修改成功" inView:weakself.resetPasswordView mode:(SFProgressMode *)SFProgressModeSuccess];
//                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                                    [self dismissViewControllerAnimated:YES completion:nil];
//                                });
//
//                                break;
//                            }
//                            case 1:
//                                NSLog(@"密码修改失败");
//                            case 2:
//                                NSLog(@"旧密码不正确");
//                            case 3:
//                                NSLog(@"旧密码不能为空");
//                            case 4:
//                                NSLog(@"新密码不能为空");
//                            case 5:
//                                NSLog(@"ID不能为空");
//                            default:
//                                break;
//                        }
//                    } withFailureBlock:^(NSError *error) {
//
//                        NSLog(@"%@",error);
//                    } progress:^(float progress) {
//
//                    }];
//
//
//                }else {
//                    [SFProgressHUD showMessage:@"两次密码不一致" inView:weakself.resetPasswordView afterDelayTime:3.0];
//
//                }
//            }else {
//                NSLog(@"请输入密码");
//            }

            
        }
    }];
}


@end
