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
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ActivationCodeInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    _textFieldTagAdd = 1;
    _scrollerContentSize_H = 100;
    _codeArray = [[NSMutableArray alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.dataDict =[NSMutableDictionary dictionaryWithDictionary: @{@"personid":@"",@"statevip":@"",@"code":@[]}];
    [self createViewUI];
}

- (void)leftBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createViewUI
{
    // 2.创建UIImageView（图片）
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ActivateBackground"]];
    backImageView.frame = CGRectMake(0,0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    backImageView.userInteractionEnabled = YES;
    [self.view addSubview:backImageView];
    
    // 1.创建UIScrollView
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, backImageView.height); // frame中的size指UIScrollView的可视范围
    self.scrollView.backgroundColor = [UIColor clearColor];
    [backImageView addSubview:self.scrollView];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 20, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backImageView addSubview:leftBtn];
    
    
    [self createActivationCode];
    [self createActivationBtn];
    
    // 设置UIScrollView的滚动范围（内容大小）
    self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, _scrollerContentSize_H+50);
    
}
- (void)createActivationBtn
{
    self.activationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.activationButton.frame = CGRectMake(100, _scrollerContentSize_H, kSCREEN_WIDTH-200, 30);
    [self.activationButton addTarget:self action:@selector(activationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.activationButton setImage:[UIImage imageNamed:@"activationBtn"] forState:UIControlStateNormal];
    self.activationButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.activationButton];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"888r"]];
    imageView.frame = CGRectMake(20, kSCREEN_HEIGHT-170, kSCREEN_WIDTH-40, 150);
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
}
- (void)createActivationCode
{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(50, _scrollerContentSize_H, kSCREEN_WIDTH-100, 30);
    textField.delegate = self;
    textField.placeholder = @"店面编码";
    textField.tag = ValidationTextFieldTag+_textFieldTagAdd;
    textField.background = [UIImage imageNamed:@"asd"];
    [self.scrollView addSubview:textField];
    
    UITextField *textField2 = [[UITextField alloc] init];
    textField2.frame = CGRectMake(textField.x, textField.y+textField.height+20, textField.width, 30);
    textField2.delegate = self;
    textField2.placeholder = @"卡券激活码";
    textField2.tag = ActivationTextFieldTag+_textFieldTagAdd;
    textField2.background = [UIImage imageNamed:@"asd"];
    [self.scrollView addSubview:textField2];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(textField2.x+textField2.width-100, textField2.y+textField2.height, 100, 30);
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitle:@"【添加】" forState:UIControlStateNormal];
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = kFontOther;
    [self.scrollView addSubview:addBtn];
    
    _scrollerContentSize_H = (addBtn.y+addBtn.height);
    
}
- (void)addBtnClick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    NSLog(@"%@ 验证码：%@。 激活码：%@",btn.titleLabel.text,_validationStr,_activationStr);
    if (_activationStr.length>0 && _validationStr.length>0) {
        NSDictionary *dict = @{@"personid":[XSaverTool objectForKey:UserIDKey],@"statevip":[XSaverTool objectForKey:Statevip],@"nownum":[NSString stringWithFormat:@"%ld",(long)_textFieldTagAdd],@"yzm": _validationStr,@"jhm":_activationStr};
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
                if (kSCREEN_HEIGHT-self.activationButton.y-self.activationButton.height-self.imageView.x <  140) {
                    self.imageView.frame = CGRectMake(self.imageView.x, self.activationButton.y+self.activationButton.height+20, self.imageView.width, self.imageView.height);
                    
                }
                self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, _scrollerContentSize_H+self.imageView.height+self.activationButton.height+30);
                if (_scrollerContentSize_H > kSCREEN_HEIGHT-64) {
                    [self.scrollView setContentOffset:CGPointMake(0,_scrollerContentSize_H-kSCREEN_HEIGHT+64+self.activationButton.height+self.imageView.height+30) animated:YES];
                    
                }
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
    if (!_validationStr.length){
        if ([[self.dataDict objectForKey:@"code"] count] == 0) {
            jxt_showAlertTitle(@"请输入验证码或激活码");
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
