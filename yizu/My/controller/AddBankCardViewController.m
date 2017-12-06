//
//  AddBankCardViewController.m
//  yizu
//
//  Created by 徐健 on 2017/11/20.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "BankCardNextViewController.h"

@interface AddBankCardViewController ()<UITextFieldDelegate>
{
    NSString *_backCardCode;
}
@property (strong, nonatomic) UITextField *bankCardNoField;
@property (nonatomic, strong) UILabel *label;
@end

@implementation AddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    _backCardCode = @"";
    [self createViewUI];
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
- (void)createViewUI
{
    NSArray *array = @[@"卡号",@"卡类型"];
    for (int i = 0 ; i < array.count; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 74+(i*(50+5)), kSCREEN_WIDTH, 50);
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 70, 50);
        label.text = array[i];
        label.textAlignment = NSTextAlignmentRight;
        [view addSubview:label];
        
        if (i == 0) {
            UITextField *textField = [[UITextField alloc] init];
            textField.delegate = self;
            textField.frame = CGRectMake(label.x+label.width+10, 0, kSCREEN_WIDTH-label.x-label.width-10-10, 50);
            textField.placeholder = @"请输入银行卡号";
            textField.clearButtonMode=
            UITextFieldViewModeWhileEditing;
            textField.keyboardType = UIKeyboardTypeNumberPad;
            [view addSubview:textField];
            self.bankCardNoField = textField;
        }else{
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(label.x+label.width+10, 0, kSCREEN_WIDTH-label.x-label.width-10-10, 50);
            label.textAlignment = NSTextAlignmentRight;
            [view addSubview:label];
            self.label = label;

            UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
            [singleTapGestureRecognizer setNumberOfTapsRequired:1];
            [view addGestureRecognizer:singleTapGestureRecognizer];
        }
    }
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(kSCREEN_WIDTH/2-kSCREEN_WIDTH/2/2, 100+135/3+64, kSCREEN_WIDTH/2, 40);
    [nextBtn addTarget:self action:@selector(nextBtnclick:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.backgroundColor = [UIColor colorWithRed:0.17f green:0.68f blue:0.10f alpha:1.00f];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
}
- (void)nextBtnclick:(UIButton *)btn
{
    [self.bankCardNoField resignFirstResponder];
    DLog(@"下一步 ===  卡号--%@  卡类型--%@",_backCardCode,[self returnBankName:_backCardCode]);
    /**
     * 检验银行卡号
     */
    BOOL isbankCard = [EncapsulationMethod isValidateBankCard:_backCardCode];
    if (!isbankCard) {
        jxt_showAlertTitle(@"请输入正确的卡号");
        return;
    }
    BankCardNextViewController *bankCardVC = [[BankCardNextViewController alloc] init];
    bankCardVC.title = self.title;
    bankCardVC.bankcard = _backCardCode;
    bankCardVC.bancarname = [self returnBankName:_backCardCode];
    if (self.navigationController) {
        [self.navigationController pushViewController:bankCardVC animated:YES];
    }else{
        [self presentViewController:bankCardVC animated:YES completion:nil];
    }
}
- (void)singleTap:(UITapGestureRecognizer*)recognizer
{
   
}
#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (string.length) {
        if (_backCardCode.length >= 19) {
        }else{
            _backCardCode = [_backCardCode stringByAppendingString:string];
        }
    }else{
        _backCardCode = [_backCardCode substringToIndex:_backCardCode.length-1];
    }
    DLog(@"%@",_backCardCode);

    NSString *str123 = [self returnBankName:_backCardCode];
    DLog(@"%@",str123);
    self.label.text = str123;
    NSString *text = [self.bankCardNoField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    // 限制长度
    if (newString.length >= 24) {
        return NO;
    }
    
    [self.bankCardNoField setText:newString];
    
    return NO;
}

- (NSString *)returnBankName:(NSString*) idCard{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
    NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *bankBin = resultDic.allKeys;
    
    //6位Bin号
    NSString* cardbin_6;
    if (idCard.length >= 6) {
       cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    }else{
        cardbin_6 = idCard;
    }
    //8位Bin号
    NSString* cardbin_8;
    if (idCard.length >= 8) {
       cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];
    }else{
        cardbin_8 = idCard;
    }

    if ([bankBin containsObject:cardbin_6]) {
        return [resultDic objectForKey:cardbin_6];
    }else if ([bankBin containsObject:cardbin_8]){
        return [resultDic objectForKey:cardbin_8];
    }else if(cardbin_6.length >= 6 || cardbin_8.length >= 8){
        jxt_showAlertTitle(@"不支持此卡种");
        return @"";
    }
    return @"";
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    DLog(@"123131231");
    _backCardCode = @"";
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
