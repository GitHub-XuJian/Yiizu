//
//  WithdrawalViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/21.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "WithdrawalViewController.h"

@interface WithdrawalViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *label;
@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    _moneyStr=[_moneyStr stringByReplacingOccurrencesOfString:@"￥"withString:@""];

    [self createdata];
}
- (void)createdata
{
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Bankcard/bankcardTFApi",Main_Server];
    NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        [self createView:responseObject];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)createView:(NSDictionary *)dict
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 64+30, kSCREEN_WIDTH, 30);
    label.text = @"转出至";
    [self.view addSubview:label];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, label.y+label.height+10, kSCREEN_WIDTH, 60)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BankCard"]];
    imageView.frame = CGRectMake(20, 5, 50, 50);
    [backView addSubview:imageView];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(imageView.x+imageView.width+10, 0, kSCREEN_WIDTH-(imageView.x+imageView.width+10), 60);
    label2.text = [NSString stringWithFormat:@"%@(%@)",dict[@"bancarname"],dict[@"bankcard"]];
    [backView addSubview:label2];
    
    UIView *backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, backView.y+backView.height+20, kSCREEN_WIDTH, 60)];
    backView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView2];

    UILabel *label3 = [[UILabel alloc] init];
    label3.frame = CGRectMake(20, 0, 50, 60);
    label3.text = @"金额";
    [backView2 addSubview:label3];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(label3.x+label3.width+40, 10, kSCREEN_WIDTH-label3.x-label3.width-40, 40);
    textField.placeholder = @"请输入金额";
    textField.delegate = self;
    textField.keyboardType = UIKeyboardTypeDecimalPad;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [backView2 addSubview:textField];
    self.textField = textField;
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.frame = CGRectMake(label3.x, backView2.y+backView2.height, 150, 30);
    label4.text = [NSString stringWithFormat:@"可提现金额: %@ 元",_moneyStr];
    label4.textColor = [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];
    label4.font = kFontOther;
    [self.view addSubview:label4];
    self.label = label4;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(label4.x+label4.width, label4.y, 100, label4.height);
    [btn setTitle:@"全部提现" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(allWithdrawalBtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = kFontOther;
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(label4.x, label4.y+label4.height+30, kSCREEN_WIDTH-label4.x*2, 40);
    [btn1 setTitle:@"确认" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor colorWithRed:0.17f green:0.68f blue:0.10f alpha:1.00f];
    [btn1 addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}
- (void)allWithdrawalBtnClick
{
    [self.textField  resignFirstResponder];
    self.textField.text = _moneyStr;
}
- (void)confirmBtnClick
{
    NSLog(@"%f %f",[self.textField.text floatValue],[_moneyStr floatValue]);

    [self.textField  resignFirstResponder];
    if (self.textField.text.length) {
        if ([self.textField.text floatValue] > [_moneyStr floatValue]) {
            jxt_showAlertMessage(@"超出本次可提现金额");
        }else{
            [SVProgressHUD show];
            NSString *urlStr = [NSString stringWithFormat:@"%@daishou/jpp_phpdemo_20170915/demo/CollectingPayment.php",Main_ServerImage];
            NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey],@"total":[NSString stringWithFormat:@"%f",[self.textField.text floatValue]*100]};
            [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"%@",responseObject);
                [SVProgressHUD dismiss];

                if (responseObject) {
                    jxt_showAlertMessage(responseObject[@"rspMessage"]);
                }else{
                    jxt_showAlertMessage(@"系统忙，请稍后再试");
                }
                if ([responseObject[@"orderSts"] isEqualToString:@"P"] ||[responseObject[@"orderSts"] isEqualToString:@"S"]  ) {
                    [self.navigationController popViewControllerAnimated:YES];
                }

            } fail:^(NSURLSessionDataTask *task, NSError *error) {
                [SVProgressHUD dismiss];

            }];
        }
    }else{
        jxt_showAlertMessage(@"请输入金额");
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSLog(@"%@",textField.text);
    if ([textField.text floatValue] > [_moneyStr floatValue]) {
        self.label.text = @"输入金额超过零钱余额";
        self.label.textColor = [UIColor redColor];
    }else{
        self.label.text = [NSString stringWithFormat:@"可提现金额: %@ 元",_moneyStr];
        self.label.textColor = [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
