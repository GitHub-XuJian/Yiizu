//
//  MembersTableViewCell.m
//  yizu
//
//  Created by 徐健 on 2017/11/10.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MembersTableViewCell.h"
#import "PWCustomSheet.h"
#import "ActivationCodePayViewController.h"

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
        [classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [classBtn setTitle:@"开通" forState:UIControlStateNormal];
        [classBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [classBtn.layer setBorderWidth:0.5];
        classBtn.layer.borderColor=[UIColor blackColor].CGColor;
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
    self.nameLabel.text = cellDict[@"title"];
    self.classBtn.hidden = [cellDict[@"button"] integerValue];
    [self createFrame];
}
- (void)createFrame
{
    self.nameLabel.frame = CGRectMake(10, 0, self.width/2, 135/2);
    self.classBtn.frame = CGRectMake(kSCREEN_WIDTH-60, 135/2/2-30/2, 50, 30);
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
    switch (button.tag) {
        case 0:{            // 微信支付
            NSDictionary *dict =@{@"total":@"1",@"subject":@"购买会员"};
            NSString *urlStr = [NSString stringWithFormat:@"%@weixin/index.php",Main_ServerImage];
            [SVProgressHUD showWithStatus:@"正在转到微信支付..."];
            [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                [SVProgressHUD dismiss];
                if (responseObject) {
                    [self createWXPayReq:responseObject];
                }
            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
            break;
        }
        case 1:{            // 支付宝支付
            
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
