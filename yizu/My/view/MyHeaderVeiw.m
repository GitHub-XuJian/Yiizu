//
//  MyHeaderVeiw.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MyHeaderVeiw.h"
#import "LoginViewController.h"

@implementation MyHeaderVeiw

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.90f green:0.89f blue:0.87f alpha:1.00f];;
        [self createHeaderView];
    }
    return self;
}
- (void)createHeaderView
{
    UIView * blackView = [[UIView alloc] init];
    blackView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, self.height/2);
    blackView.backgroundColor =[UIColor blackColor];
    [self addSubview:blackView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.width/2-60/2, self.height/2-60/2, 120/2,120/2);
    [button setImage:[UIImage imageNamed:@"icon_default_avatar"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(headPortraitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.clipsToBounds=YES;
    button.layer.cornerRadius=120/2/2;
    //边框宽度
    [button.layer setBorderWidth:0.5];
    button.layer.borderColor=[UIColor whiteColor].CGColor;
    [self addSubview:button];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(0, button.y+button.height+25/3, kSCREEN_WIDTH, 20);
    nameLabel.text = @"请填写昵称";
    nameLabel.font = kFontOther;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    
    UILabel *introductionLabel = [[UILabel alloc] init];
    introductionLabel.frame = CGRectMake(0, nameLabel.y+nameLabel.height+35/3, kSCREEN_WIDTH, 20);
    introductionLabel.text = @"简介：人生伟业的建立，不在能知，乃在能行。";
    introductionLabel.font = kFontMini;
    introductionLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:introductionLabel];
}
- (void)headPortraitBtnClick:(UIButton *)btn
{
    LoginViewController *loginViewC = [[LoginViewController alloc] init];
    loginViewC.successfulBlock = ^{
        
    };
    loginViewC.failedBlock = ^{
        
    };
    [[EncapsulationMethod viewController:self] presentViewController:loginViewC animated:YES completion:nil];

//    [[EncapsulationMethod viewController:self].navigationController pushViewController:loginViewC animated:YES];
}
@end
