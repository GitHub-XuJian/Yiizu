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

@interface AboutUsViewController ()<AboutusViewDelegate>
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
    usView.delegate = self;
    [self.view addSubview:usView];
}
- (void)clickButton:(id)recognizer
{
    if ([recognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        UILongPressGestureRecognizer *tempLP = (UILongPressGestureRecognizer *)recognizer;
        if (tempLP.view.tag == ViewTag) {
            WebViewController *webViewVC = [[WebViewController alloc] init];
            [self.navigationController pushViewController:webViewVC animated:YES];
        }
    }else if([recognizer isKindOfClass:[UIButton class]]){
        WebViewController *webViewVC = [[WebViewController alloc] init];
        [self.navigationController pushViewController:webViewVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
