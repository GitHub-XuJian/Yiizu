//
//  AgreementView.m
//  yizu
//
//  Created by 徐健 on 2017/11/6.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "AgreementView.h"
#import "WebViewController.h"
#import "UIButtonArea.h"

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
    UIButtonArea *checkBtn = [UIButtonArea buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = CGRectMake(0, self.height/2-20/2, 20, 20);
    [checkBtn setBackgroundImage:[UIImage imageNamed:@"CheckBox"] forState:UIControlStateNormal];
    checkBtn.selected = YES;
    [checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [checkBtn setImage:[UIImage imageNamed:@"CheckBox"] forState:UIControlStateNormal];
    [checkBtn setImage:[UIImage imageNamed:@"CheckBox2"] forState:UIControlStateSelected];
    [self addSubview:checkBtn];
    
    CGFloat rect = [EncapsulationMethod calculateRowWidth:@"已阅读并接受" andFont:16 andHight:self.height];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(checkBtn.x+checkBtn.width, 00, rect, self.height);
    label.text = @"已阅读并接受";
    label.font = kFontBodyTitle;
    label.textColor = titleColor;
    [self addSubview:label];
    
    UIButtonArea *btn = [UIButtonArea buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(label.x+label.width, label.y, self.width-label.width, self.height);
    [btn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:0.62f green:0.11f blue:0.19f alpha:1.00f] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn addTarget:self action:@selector(agreementBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = kFontBodyTitle;
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
