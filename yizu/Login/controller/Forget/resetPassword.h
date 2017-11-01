//
//  registerInterface.h
//  registrationDebarkation
//
//  Created by 邵峰 on 2017/4/6.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^btnClicked)(UIButton *btn);
@interface resetPassword : UIView
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *OldPassword;
@property (weak, nonatomic) IBOutlet UITextField *NewPassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmNewPassword;

@property(nonatomic, copy) btnClicked block;
- (void)btnClicked:(btnClicked)block;
+(instancetype)loadResetPasswordView;
@end
