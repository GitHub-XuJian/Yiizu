//
//  LoginView.h
//  yizu
//
//  Created by 徐健 on 2017/10/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,BtnloginType)
{
    Login = 100,             // 登录
    RegisterBtn,             // 注册
    Back,                    // 返回
    ForgotPassword,          // 忘记密码
    WeiXin,
    QQ                     
};
typedef void(^btnClicked)(BtnloginType buttonType,NSString *password);

@interface LoginView : UIView
@property(nonatomic, copy) btnClicked block;
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *passWordTextField;

- (void)btnClicked:(btnClicked)block;
@end
