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
#import "DisplayCardViewController.h"
#import "ChangeViewController.h"

@interface MyWalletViewController ()<WalletViewDelegate>
@property (nonatomic, strong)  WalletView *walletView;
@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    
    [self createViewUI];
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
        [self.walletView reloadMonay:responseObject[@"balance"]];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)createViewUI
{
    WalletView *view = [[WalletView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, 200)];
    view.backgroundColor =[UIColor colorWithRed:0.99f green:0.97f blue:0.90f alpha:1.00f];
    view.delegate = self;
    [self.view addSubview:view];
    self.walletView = view;
}

- (void)clickWithTag:(NSInteger)viewTag
{
    switch (viewTag) {
        case 0:{
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
            break;
        }
        case 1:{
            NSLog(@"零钱");
            ChangeViewController *changeVC = [[ChangeViewController alloc] init];
            changeVC.title = @"零钱";
            [self.navigationController pushViewController:changeVC animated:YES];

            break;
        }
        case 2:{
            NSLog(@"积分");
            jxt_showAlertTitle(@"正在开发中，敬请期待");
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
