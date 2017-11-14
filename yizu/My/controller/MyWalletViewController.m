//
//  MyWalletViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/3.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MyWalletViewController.h"

@interface MyWalletViewController ()

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    
    [self createViewUI];
}
- (void)createViewUI
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 64, kSCREEN_WIDTH, 661/3);
    view.backgroundColor =[UIColor colorWithRed:0.30f green:0.30f blue:0.30f alpha:1.00f];
    [self.view addSubview:view];
    
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.frame = CGRectMake(0, 126/3, view.width, 43/3);
    accountLabel.text = @"账户余额";
    accountLabel.font = [UIFont systemFontOfSize:18];
    accountLabel.textAlignment =NSTextAlignmentCenter;
    accountLabel.textColor = [UIColor whiteColor];
    [view addSubview:accountLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
