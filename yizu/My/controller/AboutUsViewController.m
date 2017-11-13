//
//  AboutUsViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//
#define ViewTag 1234567     // 关于我们页Viewtag值

#import "AboutUsViewController.h"
#import "AboutusView.h"
#import "WebViewController.h"

@interface AboutUsViewController ()
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createView];
}
- (void)createView
{
    AboutusView *usView = [[AboutusView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
    [self.view addSubview:usView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
