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
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) UILabel *introductionLabel;
@property (nonatomic, strong) UIImageView *crownImageView;
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
-(void)standInsideLetter:(NSInteger)number;
{
    if (number == 0) {
        self.numberLabel.hidden = YES;
    }else if (number >= 99)
    {
        self.numberLabel.text = @"99";
    }else{
        self.numberLabel.text =  [NSString stringWithFormat:@"%ld",(long)number];
    }
}
- (void)reloadData
{
    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@public/%@",Main_ServerImage,[XSaverTool objectForKey:UserIconImage]]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_default_avatar"]];
    if ([[XSaverTool objectForKey:Statevip] integerValue]) {
        self.crownImageView.image = [UIImage imageNamed:@"crown"];
    }else{
        self.crownImageView.image = [UIImage imageNamed:@"UNcrown"];
    }
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
    UIImageView * blackView = [[UIImageView alloc] init];
    blackView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, self.height);
    [blackView setImage:[UIImage imageNamed:@"MyBack"]];
    [self addSubview:blackView];

    UIButton *setUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setUpBtn.frame = CGRectMake(kSCREEN_WIDTH-50, 0, 44, 44);
    [setUpBtn setImage:[UIImage imageNamed:@"settingsNavIcon"] forState:UIControlStateNormal];
    setUpBtn.tag = 111111;
    [setUpBtn addTarget:self action:@selector(headPortraitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:setUpBtn];
    
    UIButton *emailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    emailBtn.frame = CGRectMake(10, 0, 44, 44);
    [emailBtn setImage:[UIImage imageNamed:@"timg"] forState:UIControlStateNormal];
    emailBtn.tag = 2222223;
    [emailBtn addTarget:self action:@selector(headPortraitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:emailBtn];
    
    UILabel *nnumberLabel = [[UILabel alloc] init];
    nnumberLabel.frame = CGRectMake(emailBtn.width, emailBtn.y+5, 15, 15);
    nnumberLabel.font = kCommonWithFont(10);
    nnumberLabel.backgroundColor = [UIColor redColor];
    nnumberLabel.textAlignment = NSTextAlignmentCenter;
    nnumberLabel.textColor = [UIColor whiteColor];
    //设置圆角
    nnumberLabel.layer.cornerRadius = 15/2;
    //将多余的部分切掉
    nnumberLabel.layer.masksToBounds = YES;
    [self addSubview:nnumberLabel];
    self.numberLabel = nnumberLabel;
    
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
    
    UIImageView *crownImageView = [[UIImageView alloc] init];
    crownImageView.frame = CGRectMake(button.x+button.width-20, button.y+button.height-20, 20, 20);
    [crownImageView setImage:[UIImage imageNamed:@"UNcrown"]];
    [self addSubview:crownImageView];
    self.crownImageView = crownImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(0, button.y+button.height+25/3, kSCREEN_WIDTH, 20);
    nameLabel.text = @"请填写昵称";
    nameLabel.font = kCommonWithFont(20);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *introductionLabel = [[UILabel alloc] init];
    introductionLabel.frame = CGRectMake(0, nameLabel.y+nameLabel.height+35/3, kSCREEN_WIDTH, 20);
    introductionLabel.text = @"简介：人生伟业的建立，不在能知，乃在能行。";
    introductionLabel.font = kFontOther;
    introductionLabel.textAlignment = NSTextAlignmentCenter;
    introductionLabel.textColor = [UIColor whiteColor];
    [self addSubview:introductionLabel];
    self.introductionLabel = introductionLabel;
}

- (void)headPortraitBtnClick:(UIButton *)btn
{
    [_delegate clickButton:btn];
}
@end
