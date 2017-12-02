//
//  BankCardNextViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/20.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#define TextFieldTag   9909090
#define TextFieldName   @"TextFieldName"
#define TextFieldId   @"TextFieldId"
#define TextFieldTel   @"TextFieldTel"


#import "BankCardNextViewController.h"

@interface BankCardNextViewController ()<UITextFieldDelegate>
{
    NSDictionary *_dict;
    NSMutableDictionary *_bankCardDict;
}
@end

@implementation BankCardNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    _bankCardDict = [[NSMutableDictionary alloc] init];
    [self createData];
    if (!self.navigationController) {
        [self createBackBtn];
    }
}
- (void)createBackBtn
{
    SFNavView *navView = [[SFNavView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64) andTitle:@"银行卡" andLeftBtnTitle:@"返回" andRightBtnTitle:nil andLeftBtnBlock:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    } andRightBtnBlock:^{
        
    }];
    [self.view addSubview:navView];
}
- (void)createData
{
    /**
     * URL字符串编码
     */
    NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey]};
    NSString *urlStr = [[NSString stringWithFormat:@"%@Mobile/Bankcard/bankcardPerApi/data/%@",Main_Server,[EncapsulationMethod dictToJsonData:dict]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",responseObject);
        _dict = responseObject;
        if (responseObject[@"pername"]) {
            [_bankCardDict setObject:responseObject[@"pername"] forKey:TextFieldName];
        }
       if (responseObject[@"pername"]) {
            [_bankCardDict setObject:responseObject[@"tel"] forKey:TextFieldTel];
        }

        [self createUIView];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)createUIView
{
    NSArray *titleArray = @[@"银行卡号",@"银行卡类型",@"姓名",@"证件类型",@"证件号码",@"手机号"];
    NSArray *rightArray = @[_bankcard,_bancarname,_dict[@"pername"],@"身份证",@"",_dict[@"tel"]];
    NSArray *placeholderArray = @[@"",@"",@"请输入真实姓名",@"",@"请输入证件号码",@"请输入电话号"];

    float complete_H = 64+10;
    for (int i = 0; i<titleArray.count; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 74+(i*(50+5)), kSCREEN_WIDTH, 50);
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = YES;
        [self.view addSubview:view];
        complete_H += view.height;
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 90, 50);
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentRight;
        [view addSubview:label];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.delegate = self;
        textField.frame = CGRectMake(label.x+label.width+10, 0, kSCREEN_WIDTH-label.x-label.width-10-10, 50);
        textField.clearButtonMode=
        UITextFieldViewModeWhileEditing;
        textField.tag = TextFieldTag+i;
        [view addSubview:textField];
        if ([rightArray[i] length]>0) {
            textField.text = rightArray[i];
            textField.enabled = NO;
        }else{
            textField.placeholder = placeholderArray[i];
            textField.enabled = YES;
        }
        if (i>=4) {
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }else{
            textField.keyboardType = UIKeyboardTypeDefault;
        }
    }
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(kSCREEN_WIDTH/2-kSCREEN_WIDTH/2/2, complete_H+135/3, kSCREEN_WIDTH/2, 40);
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"nextStepImage"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(completeBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case TextFieldTag+2:{
            NSLog(@"姓名");
            [_bankCardDict setObject:textField.text forKey:TextFieldName];
            break;
        }
        case TextFieldTag+4:{
            NSLog(@"证件号");
            [_bankCardDict setObject:textField.text forKey:TextFieldId];

            break;
        }
        case TextFieldTag+5:{
            NSLog(@"手机号");
            [_bankCardDict setObject:textField.text forKey:TextFieldTel];

            break;
        }
        default:
            break;
    }
}
- (void)completeBtnclick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    if (![_bankCardDict[TextFieldName] length]) {
        jxt_showAlertTitle(@"请输入真实姓名");
        return;
    }
    if (![_bankCardDict[TextFieldId] length]) {
        jxt_showAlertTitle(@"请输入证件号码");
        return;
    }
    if (![_bankCardDict[TextFieldTel] length]) {
        jxt_showAlertTitle(@"请输入电话");
        return;
    }
    /**
     * URL字符串编码
     */
    NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey],@"bancarname":_bancarname,@"bankcard":_bankcard,@"idcard":_bankCardDict[TextFieldId],@"tel":_bankCardDict[TextFieldTel],@"pername":_bankCardDict[TextFieldName]};
    NSString *urlStr = [[NSString stringWithFormat:@"%@Mobile/Bankcard/bankcardPerApi/data/%@",Main_Server,[EncapsulationMethod dictToJsonData:dict]] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",responseObject);
        jxt_showAlertTitle(responseObject[@"message"]);
        if ([responseObject[@"result"] integerValue]) {
            [XSaverTool setObject:_bankCardDict[TextFieldTel] forKey:PhoneKey];
            [XSaverTool setObject:_bankCardDict[TextFieldTel] forKey:isPhone];
            
            if (self.navigationController) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                self.presentingViewController.view.alpha = 0;
                [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
