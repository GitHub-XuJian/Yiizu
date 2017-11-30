//
//  ChangeViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/28.
//  Copyright © 2017年 XuJian. All rights reserved.
//
#define Btn1Tag   123123
#define Btn2Tag   1231232

#import "ChangeViewController.h"
#import "WithdrawalViewController.h"

@interface ChangeViewController ()
@property (nonatomic, strong) UILabel *moneyLabel;;
@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self createData];
}
- (void)createData
{
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Money/myMoneyApi",Main_Server];
    NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",responseObject[@"balance"]];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)createUI
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"AnyChange"];
    imageView.frame = CGRectMake(kSCREEN_WIDTH/2-100/2, 64+50, 100, 100);
    [self.view addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, imageView.y+imageView.height+10, kSCREEN_WIDTH, 30);
    titleLabel.text = @"我的零钱";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.frame = CGRectMake(0, titleLabel.y+titleLabel.height+10, kSCREEN_WIDTH, 50);
    moneyLabel.text = @"￥0";
    moneyLabel.font = [UIFont systemFontOfSize:50];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:moneyLabel];
    self.moneyLabel = moneyLabel;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame =CGRectMake(20, moneyLabel.y+moneyLabel.height+20, kSCREEN_WIDTH-40, 50);
    btn1.backgroundColor = [UIColor colorWithRed:0.17f green:0.68f blue:0.10f alpha:1.00f];
    btn1.tag = Btn1Tag;
    [btn1 setTitle:@"交易明细" forState:UIControlStateNormal];
    [btn1 addTarget: self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame =CGRectMake(20, btn1.y+btn1.height+20, kSCREEN_WIDTH-40, 50);
    btn2.tag = Btn2Tag;
    [btn2 setTitle:@"提现" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget: self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //边框宽度
    [btn2.layer setBorderWidth:1];
    btn2.layer.borderColor=kColorLine.CGColor;
    [self.view addSubview:btn2];
}
- (void)btnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case Btn1Tag:{
            
            break;
        }
        case Btn2Tag:{
            WithdrawalViewController *withdrawalVC = [[WithdrawalViewController alloc] init];
            withdrawalVC.title = @"提现";
            withdrawalVC.moneyStr = self.moneyLabel.text;
            [self.navigationController pushViewController:withdrawalVC animated:YES];
            break;
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
