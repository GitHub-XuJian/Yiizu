//
//  ActivityViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityViewController.h"
#import "ChartViewController.h"
@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kSCREEN_WIDTH/2-100/2, kSCREEN_HEIGHT/2-100/2, 100, 100);
    [btn setTitle:@"画图页面" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn];
}
- (void)btnClick:(UIButton *)btn
{
    ChartViewController *chartVC = [[ChartViewController alloc] init];
    [self.navigationController pushViewController:chartVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
