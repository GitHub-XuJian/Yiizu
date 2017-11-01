//
//  registerInterface.m
//  registrationDebarkation
//
//  Created by 邵峰 on 2017/4/6.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import "resetPassword.h"

@interface resetPassword ()

@end

@implementation resetPassword

+(instancetype)loadResetPasswordView{
  return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject]; 
}
- (void)btnClicked:(btnClicked)block
{
    _block = block;
}
- (IBAction)BtnAction:(UIButton *)sender {
    if (_block) {
        _block(sender);
    }
}
@end
