//
//  MallViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MallViewController.h"
#import "MembershipActivationCodeView.h"
#import "MembersView.h"
#import "TradingView.h"

@interface MallViewController ()
@property (nonatomic, strong) MembershipActivationCodeView *macView;
@property (nonatomic, strong) MembersView *mView;
@property (nonatomic, strong) TradingView *tView;
@end

@implementation MallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiXinPayNotificationAction:) name:@"WeiXinPayNotification" object:nil];

    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUIView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.mView reloadData];
}
- (void)createUIView
{
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"会员",@"交易", nil];
    self.macView = [[MembershipActivationCodeView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, 50) andTitleArray:titleArray andClassBlock:^(UIButton *classBtn) {
        NSLog(@"%@",classBtn.titleLabel.text);
        if ([titleArray[classBtn.tag] isEqualToString:@"会员"]) {
            if (self.mView) {
                [self.mView removeFromSuperview];
            }
            self.mView = [[MembersView alloc] initWithFrame:CGRectMake(0, 64+50, kSCREEN_WIDTH, kSCREEN_HEIGHT-64-50-50)];
            self.mView.backgroundColor = kMAIN_BACKGROUND_COLOR;
            [self.view addSubview:self.mView];
        }else{
            if (self.tView) {
                [self.tView removeFromSuperview];
            }
            self.tView = [[TradingView alloc] init];
            self.tView.backgroundColor = kMAIN_BACKGROUND_COLOR;
            self.tView.frame = CGRectMake(0, 64+50, kSCREEN_WIDTH, kSCREEN_HEIGHT-64-50-50);
            [self.view addSubview:self.tView];
        }
    }];
    [self.view addSubview:self.macView];
}
- (void)WeiXinPayNotificationAction:(NSNotification *)notification{
    
    NSLog(@"%@",notification.object);
    BaseResp*resp =(BaseResp*)notification.object;
    PayResp*response=(PayResp*)resp;
    NSLog(@"%@",response.returnKey);
    switch(response.errCode){
        case WXSuccess:
            //服务器端查询支付通知或查询API返回的结果再提示成功
            NSLog(@"支付成功");
            break;
        default:
            NSLog(@"支付失败，retcode=%d",resp.errCode);
            
            break;
    }
    
    NSLog(@"---接收到通知---");
    [[NSNotificationCenter defaultCenter] removeObserver:@"WeiXinPayNotification" name:nil object:self];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
