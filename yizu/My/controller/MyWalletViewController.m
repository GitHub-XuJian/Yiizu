//
//  MyWalletViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/3.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#define BtnTag   12345678

#import "MyWalletViewController.h"
#import "WalletView.h"
#import "AddBankCardViewController.h"
#import "WithdrawalViewController.h"
#import "DisplayCardViewController.h"

@interface MyWalletViewController ()
@property (nonatomic, strong)  WalletView *walletView;
@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    
    [self createRightBtn];
    [self createViewUI];
    [self createData];
    
}
- (void)createData
{
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Money/myMoneyApi",Main_Server];
    NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [self.walletView reloadMonay:responseObject[@"balance"]];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)createRightBtn
{
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    releaseButton.frame = CGRectMake(0, 0, 70, 44);
    [releaseButton setTitle:@"交易明细" forState:normal];
    [releaseButton addTarget:self action:@selector(TransactionDetails) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
}
- (void)TransactionDetails
{
    
}
- (void)createViewUI
{
    WalletView *view = [[WalletView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, 661/3)];
    view.backgroundColor =[UIColor colorWithRed:0.30f green:0.30f blue:0.30f alpha:1.00f];
    [self.view addSubview:view];
    self.walletView = view;
    
    NSArray *array = @[@"提现",@"银行卡"];
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0+i*kSCREEN_WIDTH/2, view.y+view.height, kSCREEN_WIDTH/2, 185/3);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        btn.tag = BtnTag+i;
        [btn setTitleColor:kTITLETEXTCOLOR forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if (i == 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(btn.x+btn.width-0.5, 16/3, 0.5, btn.height-16/3-16/3)];
            lineView.backgroundColor = kColorLine;
            [btn addSubview:lineView];
        }
    }
}
- (void)btnClick:(UIButton *)btn
{
    if (btn.tag == BtnTag) {
        NSLog(@"提现");
        WithdrawalViewController *withdrawalVC = [[WithdrawalViewController alloc] init];
        withdrawalVC.title = @"提现";
        [self.navigationController pushViewController:withdrawalVC animated:YES];

    }else{
        NSLog(@"银行卡");
        NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Bankcard/bankcardTFApi",Main_Server];
        NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
        [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"bankcard"] length] == 0) {
                AddBankCardViewController *addBankCardVC = [[AddBankCardViewController alloc] init];
                addBankCardVC.title = @"银行卡";
                [self.navigationController pushViewController:addBankCardVC animated:YES];
            }else{
                DisplayCardViewController *displayCardVC = [[DisplayCardViewController alloc] init];
                displayCardVC.title = @"银行卡";
                displayCardVC.cardDict = responseObject;
                [self.navigationController pushViewController:displayCardVC animated:YES];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
       
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
