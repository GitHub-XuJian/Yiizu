//
//  loginInterface.m
//  registrationDebarkation
//
//  Created by 邵峰 on 2017/4/6.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import "loginInterface.h"

@implementation loginInterface

+(instancetype)loadLoginView
{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];

}

-(void)awakeFromNib
{
    [super awakeFromNib];
    /***
     *  记录上次登录用户账户
     */
//    self.accountTF.text = [SFSaveTool objectForKey:EmailKey];
    self.accountTF.text = @"2@2.com";
    self.passwordTF.text = @"111111";
    
    self.loginBtn.tag = login;
    self.registerBtn.tag = registerBtn;
    self.forgetBtn.tag = forgetBtn;
    self.qqbook.tag = QQ;
    self.weixin.tag = WeiXin;
    self.skip.tag = VisitorsLogin;
    
}

- (void)btnClicked:(btnClicked)block
{
    _block = block;
}
- (IBAction)BtnClickedAction:(UIButton *)sender {
    
    if ([EncapsulationMethod isValidateEmail:self.accountTF.text]==YES) {
        if (_block) {
            _block((int)sender.tag,self.passwordTF.text);
        }
    }else{
        jxt_showAlertTitle(NSLocalizedString(@"Validation_PleaseEnterCorrectEmail",nil));
    }
    
}

@end
