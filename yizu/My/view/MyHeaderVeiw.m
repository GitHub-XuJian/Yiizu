//
//  MyHeaderVeiw.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MyHeaderVeiw.h"
#import "LoginViewController.h"
#import "PersonalInformationViewController.h"

@interface MyHeaderVeiw ()
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *introductionLabel;
@end
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
- (void)reloadData
{
    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@public/%@",Main_ServerImage,[XSaverTool objectForKey:UserIconImage]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_default_avatar"]];

    if ([[XSaverTool objectForKey:Nickname] length]) {
        self.nameLabel.text = [XSaverTool objectForKey:Nickname];
    }else{
        self.nameLabel.text = @"请输入昵称";
    }

    if ([[XSaverTool objectForKey:Personxq] length]) {
        self.introductionLabel.text = [XSaverTool objectForKey:Personxq];
    }else{
        self.introductionLabel.text = @"请输入简介";
    }
}
- (void)createHeaderView
{
    UIView * blackView = [[UIView alloc] init];
    blackView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, self.height/2);
    blackView.backgroundColor =[UIColor blackColor];
    [self addSubview:blackView];

    UIButton *setUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setUpBtn.frame = CGRectMake(kSCREEN_WIDTH-50, 20, 44, 44);
    [setUpBtn setImage:[UIImage imageNamed:@"settingsNavIcon"] forState:UIControlStateNormal];
    setUpBtn.tag = 111111;
    setUpBtn.backgroundColor = [UIColor blackColor];
    [setUpBtn addTarget:self action:@selector(headPortraitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:setUpBtn];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.width/2-60/2, self.height/2-60/2, 120/2,120/2);
    button.tag = 222222;
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(headPortraitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.clipsToBounds=YES;
    button.layer.cornerRadius=120/2/2;
    //边框宽度
    [button.layer setBorderWidth:0.5];
    button.layer.borderColor=[UIColor whiteColor].CGColor;
    [self addSubview:button];
    self.iconBtn = button;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(0, button.y+button.height+25/3, kSCREEN_WIDTH, 20);
    nameLabel.text = @"请填写昵称";
    nameLabel.font = kCommonWithFont(20);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *introductionLabel = [[UILabel alloc] init];
    introductionLabel.frame = CGRectMake(0, nameLabel.y+nameLabel.height+35/3, kSCREEN_WIDTH, 20);
    introductionLabel.text = @"简介：人生伟业的建立，不在能知，乃在能行。";
    introductionLabel.font = kFontOther;
    introductionLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:introductionLabel];
    self.introductionLabel = introductionLabel;
}

- (void)headPortraitBtnClick:(UIButton *)btn
{
    [_delegate clickButton:btn];
}
@end
