//
//  ActivationCodeInputViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#define TextFieldTag  10000000
#define TctivationTextFieldTag  1002001

#import "ActivationCodeInputViewController.h"

@interface ActivationCodeInputViewController ()<UITextFieldDelegate>

@end

@implementation ActivationCodeInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createViewUI];
}
- (void)createViewUI
{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back_activate_import"]];
    backImageView.frame = CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64);
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    
    NSString *titleStr = @"首次输入兑换码请务必填写个人真实信息输入唯一兑换码,点击激活按钮，并提交个人信息返现成功将扣除手续费；5%（点第三方托管平台收取）";
    CGFloat titleLabel_H = [EncapsulationMethod calculateRowHeight:titleStr andTexFont:13 andMaxWidth:kSCREEN_WIDTH-60];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(90/3, 55/3, kSCREEN_WIDTH-60, titleLabel_H);
    titleLabel.numberOfLines = 0;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = titleStr;
    [backImageView addSubview:titleLabel];
    
    NSArray *array = @[@"消费店面",@"真实姓名",@"常用手机号",@"支付宝账号",@"验证码",@"激活"];
    CGFloat label_Y = (kSCREEN_HEIGHT-64-titleLabel_H-75/3-100)/6;
    for (int i = 0; i < array.count; i++) {
        if (i == 5) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(90/3, titleLabel.y+titleLabel.height+(75/3)+123/3 + i*label_Y, kSCREEN_WIDTH-60, label_Y-30-10);
            [button addTarget:self action:@selector(activationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"jihuo"] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [backImageView addSubview:button];
            
        }else{
            CGFloat label_W ;
            if (i == 4) {
                label_W = (kSCREEN_WIDTH-60)/3;
            }else{
                label_W = kSCREEN_WIDTH-60;
            }
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(90/3,titleLabel.y+titleLabel.height+(75/3) + i*label_Y, label_W, 30);
            label.text = array[i];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            label.font = kFontOther;
            [backImageView addSubview:label];
            
            UITextField *textField = [[UITextField alloc] init];
            textField.frame = CGRectMake(label.x, label.y+label.height+5, label.width, label_Y-label.height-10);
            textField.tag = TextFieldTag+i;
            textField.background = [UIImage imageNamed:@"asd"];
            [backImageView addSubview:textField];
            
            if (i == 4) {
                UILabel *label2 = [[UILabel alloc] init];
                label2.frame = CGRectMake(label.x+label.width+40/3,titleLabel.y+titleLabel.height+(75/3) + i*label_Y, kSCREEN_WIDTH-60-label.width-40/3, 30);
                label2.text = @"激活码";
                label2.backgroundColor = [UIColor clearColor];
                label2.textColor = [UIColor whiteColor];
                label2.font = kFontOther;
                [backImageView addSubview:label2];
                
                UITextField *textField2 = [[UITextField alloc] init];
                textField2.frame = CGRectMake(label2.x, label2.y+label2.height+5, label2.width, label_Y-label2.height-10);
                textField2.tag = TctivationTextFieldTag;
                textField2.background = [UIImage imageNamed:@"asd"];
                [backImageView addSubview:textField2];
                
                UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                addBtn.frame = CGRectMake(textField2.x+textField2.width-100, textField2.y+textField2.height, 100, 20);
                [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [addBtn setTitle:@"【添加】" forState:UIControlStateNormal];
                addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                addBtn.titleLabel.font = kFontOther;
                [backImageView addSubview:addBtn];
            }
        }
    }
}
- (void)addBtnClick:(UIButton *)btn
{
    NSLog(@"%@",btn.titleLabel.text);
}
- (void)activationBtnClick:(UIButton *)btn
{
    NSLog(@"%@",btn.titleLabel.text);
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
