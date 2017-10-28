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
    VisitorsLogin,           // 游客登录
    Sina,
    WeiXin,
    QQ                     
};
typedef void(^btnClicked)(BtnloginType buttonType,NSString *password);

@interface LoginView : UIView
@property(nonatomic, copy) btnClicked block;
- (void)btnClicked:(btnClicked)block;
@end
