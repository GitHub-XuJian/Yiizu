//
//  MembersTableViewCell.m
//  yizu
//
//  Created by 徐健 on 2017/11/10.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MembersTableViewCell.h"
#import "ActivationCodePayViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface MembersTableViewCell()<PWCustomSheetDelegate,WXApiDelegate>
{
    NSDictionary *_cellDict;
}
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *classBtn;

@end

@implementation MembersTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [classBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [classBtn setTitle:@"开通" forState:UIControlStateNormal];
        [classBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        classBtn.backgroundColor = [UIColor colorWithRed:0.87f green:0.68f blue:0.33f alpha:1.00f];;
        //设置圆角
        classBtn.layer.cornerRadius = 10;
        //将多余的部分切掉
        classBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:classBtn];
        self.classBtn = classBtn;

    }
    return self;
}
- (void)setCellDict:(NSDictionary *)cellDict
{
    _cellDict = cellDict;
    if ([cellDict[@"title"] isEqualToString:@"VIP套餐"]) {
        self.nameLabel.text = cellDict[@"title"];
    }else{
        NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:cellDict[@"title"]];
        //获取要调整颜色的文字位置,调整颜色
        NSRange range1=[[hintString string]rangeOfString: [NSString stringWithFormat:@"%ld",[cellDict[@"money"] integerValue]/100]];
        [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.87f green:0.68f blue:0.33f alpha:1.00f] range:range1];
        
        self.nameLabel.attributedText = hintString;
    }
    self.classBtn.hidden = [cellDict[@"button"] integerValue];
    [self createFrame];
}
- (void)createFrame
{
    self.nameLabel.frame = CGRectMake(10, 0, self.width/2, 135/2);
    self.classBtn.frame = CGRectMake(kSCREEN_WIDTH-70, 135/2/2-30/2, 60, 30);
}

- (void)btnClick:(UIButton *)btn
{
    if (IsLoginState) {
        NSArray * ar = @[@"微信支付",@"支付宝支付",@"激活码支付"];
        PWCustomSheet * sheet = [[PWCustomSheet alloc]initWithButtons:ar];
        sheet.delegate =self;
        [self.window addSubview:sheet];
    }else{
        jxt_showAlertTitle(@"请登录");
    }
    
}
-(void)clickButton:(UIButton *)button
{
    NSLog(@"%@",button.titleLabel.text);
    if (IsLoginState) {
        switch (button.tag) {
            case 0:{            // 微信支付
                NSDictionary *dict =@{@"tian":_cellDict[@"tian"],@"total":_cellDict[@"money"],@"subject":@"购买会员"};
                NSString *urlStr = [NSString stringWithFormat:@"%@weixin/index.php",Main_ServerImage];
                [SVProgressHUD showWithStatus:@"正在转到微信支付..."];
                [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSLog(@"%@",responseObject);
                    [SVProgressHUD dismiss];
                    if (responseObject) {
                        [self createWXPayReq:responseObject];
                        [XSaverTool setObject:responseObject[@"out_trade_no"] forKey:WXOut_trade_no];
                    }
                } fail:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"%@",error);
                }];
                break;
            }
            case 1:{            // 支付宝支付
                NSDictionary *dict = @{@"total":_cellDict[@"money"],@"subject":@"购买会员",@"body":@"购买会员",@"tian":_cellDict[@"tian"]};
                NSString *urlStr = [NSString stringWithFormat:@"%@zhifubao/zhifubao.php",Main_ServerImage];
                [SVProgressHUD showWithStatus:@"正在加载..."];
                [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                    [SVProgressHUD dismiss];
                    NSLog(@"%@",responseObject);
                    [self createPayTreasure:responseObject];
                    
                } fail:^(NSURLSessionDataTask *task, NSError *error) {
                    
                }];
                break;
            }
            case 2:{            // 激活码支付
                ActivationCodePayViewController *acpVC = [[ActivationCodePayViewController alloc] init];
                acpVC.title = @"激活码支付";
                acpVC.moneyDict = _cellDict;
                [[EncapsulationMethod viewController:self].navigationController pushViewController:acpVC animated:YES];
                break;
            }
            default:
                break;
        }
    }else{
        jxt_showAlertTitle(@"请登录");
    }
}
- (void)createPayTreasure:(NSDictionary *)dict
{
    [[AlipaySDK defaultService] payOrder:dict[@"json"] fromScheme:@"zhifubao2017102009402694" callback:^(NSDictionary *resultDic) {
        NSLog(@"%@",resultDic);
    }];
}

- (void)createWXPayReq:(NSDictionary *)dict
{
    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayid"];
    req.nonceStr            = [dict objectForKey:@"noncestr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [dict objectForKey:@"package"];
    req.sign                = [dict objectForKey:@"sign"];
    [WXApi sendReq:req];
    //日志输出
    NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
