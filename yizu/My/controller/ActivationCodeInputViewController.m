//
//  ActivationCodeInputViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#define TextFieldTag  10000000
#define ActivationTextFieldTag  13100001
#define ValidationTextFieldTag  10302002

#import "ActivationCodeInputViewController.h"

@interface ActivationCodeInputViewController ()<UITextFieldDelegate>
{
    CGFloat _scrollerContentSize_H;
    NSString *_activationStr;
    NSString *_validationStr;
    NSInteger _textFieldTagAdd;
    NSMutableArray *_codeArray;
}
@property (nonatomic, strong) NSMutableDictionary *dataDict;
@property (nonatomic, strong) UIButton *activationButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ActivationCodeInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    _textFieldTagAdd = 0;
    _codeArray = [[NSMutableArray alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataDict =[NSMutableDictionary dictionaryWithDictionary: @{@"personid":@"",@"statevip":@"",@"pername": @"",@"tel":@"",@"paynum":@"", @"code":@[]}];
    [self createViewUI];
}
- (void)createViewUI
{
    // 2.创建UIImageView（图片）
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back_activate_import"]];
    backImageView.frame = CGRectMake(0,64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64);
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    
    // 1.创建UIScrollView
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, backImageView.height); // frame中的size指UIScrollView的可视范围
    self.scrollView.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:self.scrollView];
    
    
    
    NSString *titleStr = @"首次输入兑换码请务必填写个人真实信息输入唯一兑换码,点击激活按钮，并提交个人信息返现成功将扣除手续费；5%（点第三方托管平台收取）";
    CGFloat titleLabel_H = [EncapsulationMethod calculateRowHeight:titleStr andTexFont:13 andMaxWidth:kSCREEN_WIDTH-60];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(90/3, 55/3, kSCREEN_WIDTH-60, titleLabel_H);
    titleLabel.numberOfLines = 0;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = titleStr;
    [self.scrollView addSubview:titleLabel];
    _scrollerContentSize_H += (titleLabel.x+titleLabel.height);
    
    NSArray *array = @[@"真实姓名",@"常用手机号",@"支付宝账号"];
    for (int i = 0; i < array.count; i++) {
        CGFloat label_W = kSCREEN_WIDTH-60;
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(90/3,_scrollerContentSize_H+(75/3), label_W, 30);
        label.text = array[i];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = kFontOther;
        [self.scrollView addSubview:label];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(label.x, label.y+label.height+5, label.width, 40);
        textField.delegate = self;
        textField.tag = TextFieldTag+i;
        textField.background = [UIImage imageNamed:@"asd"];
        [self.scrollView addSubview:textField];
        _scrollerContentSize_H += 80;
    }
    _scrollerContentSize_H += (75/3);
    [self createActivationCode];
    [self createActivationBtn];
    // 设置UIScrollView的滚动范围（内容大小）
    self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, _scrollerContentSize_H+50);
    
}
- (void)createActivationBtn
{
    self.activationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.activationButton.frame = CGRectMake(90/3, _scrollerContentSize_H, kSCREEN_WIDTH-60, 40);
    [self.activationButton addTarget:self action:@selector(activationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.activationButton setTitle:@"激活" forState:UIControlStateNormal];
    [self.activationButton setBackgroundImage:[UIImage imageNamed:@"jihuo"] forState:UIControlStateNormal];
    self.activationButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:self.activationButton];
}
- (void)createActivationCode
{
    CGFloat label_W = (kSCREEN_WIDTH-60)/3;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(90/3,_scrollerContentSize_H, label_W, 30);
    label.text = @"验证码";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = kFontOther;
    [self.scrollView addSubview:label];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(label.x, label.y+label.height+5, label.width, 40);
    textField.delegate = self;
    textField.tag = ValidationTextFieldTag+_textFieldTagAdd;
    textField.background = [UIImage imageNamed:@"asd"];
    [self.scrollView addSubview:textField];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(label.x+label.width+40/3,_scrollerContentSize_H, kSCREEN_WIDTH-60-label.width-40/3, 30);
    label2.text = @"激活码";
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor whiteColor];
    label2.font = kFontOther;
    [self.scrollView addSubview:label2];
    
    UITextField *textField2 = [[UITextField alloc] init];
    textField2.frame = CGRectMake(label2.x, label2.y+label2.height+5, label2.width, 40);
    textField2.delegate = self;
    textField2.tag = ActivationTextFieldTag+_textFieldTagAdd;
    textField2.background = [UIImage imageNamed:@"asd"];
    [self.scrollView addSubview:textField2];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(textField2.x+textField2.width-100, textField2.y+textField2.height, 100, 20);
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitle:@"【添加】" forState:UIControlStateNormal];
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = kFontOther;
    [self.scrollView addSubview:addBtn];
    _scrollerContentSize_H = (addBtn.y+addBtn.height);
    
}
- (void)addBtnClick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    NSLog(@"%@ 验证码：%@。 激活码：%@",btn.titleLabel.text,_validationStr,_activationStr);
    if (_activationStr.length>0 && _validationStr.length>0) {
        NSDictionary *dict = @{@"yzm": _validationStr,@"jhm":_activationStr};
        NSString *jsonDictStr = [EncapsulationMethod dictToJsonData:dict];
        NSString *urlStr = [[NSString stringWithFormat:@"%@Mobile/Code/codeState/code/%@",Main_Server,jsonDictStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        [XAFNetWork GET:urlStr params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            jxt_showAlertTitle([responseObject objectForKey:@"message"]);
            if ([[responseObject objectForKey:@"result"] integerValue]) {
                [_codeArray addObject:jsonDictStr];
                UITextField *textField = (UITextField *)[self.view viewWithTag:ActivationTextFieldTag+_textFieldTagAdd];
                textField.enabled = NO;
                textField.textColor = kLightGrayTextColor;
                UITextField *textField2 = (UITextField *)[self.view viewWithTag:ValidationTextFieldTag+_textFieldTagAdd];
                textField2.enabled = NO;
                textField2.textColor = kLightGrayTextColor;
                
                /**
                 * 没点击一次验证码和激活码tag值加一
                 */
                _textFieldTagAdd++;
                _activationStr = @"";
                _validationStr = @"";
                [self createActivationCode];
                self.activationButton.frame = CGRectMake(90/3, _scrollerContentSize_H, kSCREEN_WIDTH-60, 40);
                self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, _scrollerContentSize_H+50);
                [self.scrollView setContentOffset:CGPointMake(0,_scrollerContentSize_H-kSCREEN_HEIGHT+64+50) animated:YES];
                
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }else{
        jxt_showAlertTitle(@"请输入验证码或激活码");
    }
}
- (void)activationBtnClick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    [self.dataDict setObject:[XSaverTool objectForKey:UserIDKey] forKey:@"personid"];
    [self.dataDict setObject:[NSString stringWithFormat:@"%d",[XSaverTool boolForKey:Statevip]] forKey:@"statevip"];
    
    if ([[self.dataDict objectForKey:@"pername"] length] == 0) {
        jxt_showAlertTitle(@"请输入真实姓名");
        return;
    }else if ([[self.dataDict objectForKey:@"tel"] length] == 0) {
        jxt_showAlertTitle(@"请输入常用手机号");
        return;
    }else if ([[self.dataDict objectForKey:@"paynum"] length] == 0) {
        jxt_showAlertTitle(@"请输入支付宝账号");
        return;
    }else if (!_validationStr.length){
        if (![self.dataDict objectForKey:@"code"]) {
            jxt_showAlertTitle(@"请输入验证码");
            return;
        }
    }else if (!_activationStr.length){
        if (![self.dataDict objectForKey:@"code"]) {
            jxt_showAlertTitle(@"请输入激活码");
            return;
        }
    }
    NSLog(@"%@ %@ %@",btn.titleLabel.text,self.dataDict,_codeArray);
    if (_validationStr.length && _activationStr.length) {
        NSDictionary *dict = @{@"yzm": _validationStr,@"jhm":_activationStr};
        NSDictionary *arrayDict = [_codeArray lastObject];
        if (![arrayDict isEqual:dict]) {
            [_codeArray addObject:dict];
        }
    }
    
    [self.dataDict setObject:_codeArray forKey:@"code"];
    NSString *jsonDictStr = [EncapsulationMethod dictToJsonData:self.dataDict];
    NSString *urlStr = [[NSString stringWithFormat:@"%@Mobile/Code/CodeApi/data/%@",Main_Server,jsonDictStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [SVProgressHUD showWithStatus:@"正在激活"];
    [XAFNetWork GET:urlStr params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        jxt_showAlertTitle([responseObject objectForKey:@"message"]);
        if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"结束编辑");
    switch (textField.tag) {
        case 0+TextFieldTag:{
            [self.dataDict setObject:textField.text forKey:@"pername"];
            break;
        }
        case 1+TextFieldTag:{
            [self.dataDict setObject:textField.text forKey:@"tel"];
            break;
        }
        case 2+TextFieldTag:{
            [self.dataDict setObject:textField.text forKey:@"paynum"];
            break;
        }
        default:
            break;
    }

    if (textField.tag == ValidationTextFieldTag +_textFieldTagAdd) {
        _validationStr = textField.text;
    }else if (textField.tag == ActivationTextFieldTag +_textFieldTagAdd) {
        _activationStr = textField.text;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
