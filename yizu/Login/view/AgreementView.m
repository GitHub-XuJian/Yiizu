//
//  AgreementView.m
//  yizu
//
//  Created by 徐健 on 2017/11/6.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "AgreementView.h"
#import "WebViewController.h"

@implementation AgreementView

- (instancetype)initWithFrame:(CGRect)frame andTitleColor:(UIColor *)titleColor
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI:titleColor];
    }
    return self;
}
- (void)createUI:(UIColor *)titleColor
{
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = CGRectMake(0, self.height/2-11/2, 11, 11);
    [checkBtn setBackgroundImage:[UIImage imageNamed:@"CheckBox"] forState:UIControlStateNormal];
    checkBtn.selected = YES;
    [checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [checkBtn setImage:[UIImage imageNamed:@"CheckBox"] forState:UIControlStateNormal];
    [checkBtn setImage:[UIImage imageNamed:@"CheckBox2"] forState:UIControlStateSelected];
    [self addSubview:checkBtn];
    
    CGFloat rect = [EncapsulationMethod calculateRowWidth:@"登陆依足，标识您同意平台" andFont:10 andHight:self.height];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(checkBtn.x+checkBtn.width+5, 0, rect, self.height);
    label.text = @"登陆依足，标识您同意平台";
    label.font = kFontMini;
    label.textColor = titleColor;
    [self addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(label.x+label.width, label.y, self.width-label.width, self.height);
    [btn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [btn setTitleColor:kColorblue forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(agreementBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = kFontMini;
    [self addSubview:btn];
}
- (void)agreementBtnclick:(UIButton *)btn
{
    WebViewController *webViewVC = [[WebViewController alloc] init];
    webViewVC.urlStr = [NSString stringWithFormat:@"%@Home/Hereto/bang",Main_Server];
    [[EncapsulationMethod viewController:self] presentViewController:webViewVC animated:YES completion:nil];
    
}
- (void)checkBtnClick:(UIButton *)btn
{
    btn.selected =! btn.selected;
    _block(btn);
}
@end
