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
#import "ActivationCodeInputViewController.h"

@interface MallViewController ()
@property (nonatomic, strong) MembershipActivationCodeView *macView;
@property (nonatomic, strong) MembersView *mView;
@property (nonatomic, strong) TradingView *tView;
@end

@implementation MallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WeiXinPayNotificationAction:) name:@"WeiXinPayNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZhiFuBaoPayNotificationAction:) name:@"ZhiFuBaoPayNotification" object:nil];
    
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
        DLog(@"%@",classBtn.titleLabel.text);
        if ([titleArray[classBtn.tag] isEqualToString:@"会员"]) {
            if (self.mView) {
                [self.mView removeFromSuperview];
            }
            self.mView = [[MembersView alloc] initWithFrame:CGRectMake(0, 64+50, kSCREEN_WIDTH, kSCREEN_HEIGHT-64-50-50)];
            self.mView.backgroundColor = kMAIN_BACKGROUND_COLOR;
            [self.view addSubview:self.mView];
            [self.mView reloadData];
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
    
    DLog(@"%@",notification.object);
    BaseResp*resp =(BaseResp*)notification.object;
    PayResp*response=(PayResp*)resp;
    DLog(@"%@",response.returnKey);
    switch(response.errCode){
        case WXSuccess:{
            //服务器端查询支付通知或查询API返回的结果再提示成功
            DLog(@"支付成功");
            
            NSString *urlStr =[NSString stringWithFormat:@"%@weixin/order.php",Main_ServerImage];
            NSDictionary *dict = @{@"out_trade_no":[XSaverTool objectForKey:WXOut_trade_no]};
            [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                DLog(@"%@",responseObject);
                if ([responseObject[@"result_code"] isEqualToString:@"SUCCESS"]){
                    if ([responseObject[@"trade_state"] isEqualToString:@"SUCCESS"]) {
                        
                        
                        NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey],@"tian":responseObject[@"tian"],@"ordernum":responseObject[@"out_trade_no"],@"ordercuurt":responseObject[@"total"],@"orderbuy":@"微信"};
                        
                        NSString *urlStr = [[NSString stringWithFormat:@"%@Mobile/Member/payMember/data/%@",Main_Server,[EncapsulationMethod dictToJsonData:dict]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                        
                        [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                            DLog(@"%@",responseObject);
                            jxt_showAlertTitle(responseObject[@"message"]);
                            if ([responseObject[@"result"] integerValue]) {
                                NSDictionary *dataDict = responseObject[@"data"];
                                [XSaverTool setObject:dataDict[@"vipendtime"] forKey:VipEndtime];
                                [XSaverTool setObject:dataDict[@"statevip"] forKey:Statevip];
                                [self.mView reloadData];
                            }
                        } fail:^(NSURLSessionDataTask *task, NSError *error) {
                            
                        }];
                    }
                }
                
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
            break;
        }
        default:
            DLog(@"支付失败，retcode=%d",resp.errCode);
            
            break;
    }
    
    DLog(@"---接收到通知---");
    [[NSNotificationCenter defaultCenter] removeObserver:@"WeiXinPayNotification" name:nil object:self];
}
- (void)ZhiFuBaoPayNotificationAction:(NSNotification *)notification{
    DLog(@"%@",notification.object);
    NSString *resuleStr = notification.object[@"result"];
    id jsonDict = [EncapsulationMethod toArrayOrNSDictionary:resuleStr];
    DLog(@"%@",jsonDict);
    NSDictionary *alipayDict = jsonDict[@"alipay_trade_app_pay_response"];
    
    NSDictionary *dict = @{@"trade_no":alipayDict[@"trade_no"],@"out_trade_no":alipayDict[@"out_trade_no"]};
    
    NSString *urlStr = [NSString stringWithFormat:@"%@zhifubao/order.php",Main_ServerImage];
    
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        DLog(@"%@",responseObject);
        
        if ([responseObject[@"result"] isEqualToString:@"SUCCESS"]){
            
            NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey],@"tian":responseObject[@"tian"],@"ordernum":alipayDict[@"out_trade_no"],@"ordercuurt":alipayDict[@"total_amount"],@"orderbuy":@"支付宝"};
            
            NSString *urlStr = [[NSString stringWithFormat:@"%@Mobile/Member/payMember/data/%@",Main_Server,[EncapsulationMethod dictToJsonData:dict]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            
            [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                DLog(@"%@",responseObject);
                jxt_showAlertTitle(responseObject[@"message"]);
                if ([responseObject[@"result"] integerValue]) {
                    NSDictionary *dataDict = responseObject[@"data"];
                    [XSaverTool setObject:dataDict[@"vipendtime"] forKey:VipEndtime];
                    [XSaverTool setObject:dataDict[@"statevip"] forKey:Statevip];
                    [self.mView reloadData];
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    DLog(@"---接收到通知---");
    [[NSNotificationCenter defaultCenter] removeObserver:@"ZhiFuBaoPayNotification" name:nil object:self];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
