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
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

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
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(kSCREEN_WIDTH-150, _scrollerContentSize_H, 100, 30);
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setTitle:@"【添加】" forState:UIControlStateNormal];
    addBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = kFontOther;
    [self.scrollView addSubview:addBtn];
    self.addBtn = addBtn;
    
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(50, _scrollerContentSize_H, 100, 30);
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setTitle:@"【删除】" forState:UIControlStateNormal];
    deleteBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = kFontOther;
    deleteBtn.hidden = YES;
    [self.scrollView addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    
    self.activationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.activationButton.frame = CGRectMake(100, deleteBtn.y+deleteBtn.height+10, kSCREEN_WIDTH-200, 40);
    [self.activationButton addTarget:self action:@selector(activationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.activationButton setImage:[UIImage imageNamed:@"activationBtn"] forState:UIControlStateNormal];
    self.activationButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.activationButton];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"888r"]];
    imageView.frame = CGRectMake(20, kSCREEN_HEIGHT-170, kSCREEN_WIDTH-40, 150);
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
}
- (void)deleteBtnClick:(UIButton *)btn
{
    UITextField *textField = (UITextField *)[self.view viewWithTag:ActivationTextFieldTag+_textFieldTagAdd];
    _scrollerContentSize_H -= textField.height;
    [textField removeFromSuperview];
    UITextField *textField2 = (UITextField *)[self.view viewWithTag:ValidationTextFieldTag+_textFieldTagAdd];
    _scrollerContentSize_H -= textField2.height;
    [textField2 removeFromSuperview];
    _scrollerContentSize_H -= 15;
    /**
     * 没点击一次验证码和激活码tag值加一
     */
    _textFieldTagAdd--;
    _activationStr = @"";
    _validationStr = @"";
    if (_textFieldTagAdd > 1) {
        self.deleteBtn.hidden = NO;
    }else{
        self.deleteBtn.hidden = YES;
    }
    self.addBtn.frame = CGRectMake(kSCREEN_WIDTH-150, _scrollerContentSize_H, 100, 30);
    self.deleteBtn.frame = CGRectMake(50, _scrollerContentSize_H, 100, 30);
    self.activationButton.frame = CGRectMake(90/3, self.deleteBtn.y+self.deleteBtn.height, kSCREEN_WIDTH-60, 40);
    
    if (kSCREEN_HEIGHT-self.activationButton.y-self.activationButton.height-self.imageView.x <  140) {
        self.imageView.frame = CGRectMake(self.imageView.x, self.activationButton.y+self.activationButton.height+20, self.imageView.width, self.imageView.height);
        
    }else{
        self.imageView.frame = CGRectMake(20, kSCREEN_HEIGHT-170, kSCREEN_WIDTH-40, 150);
    }
    self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, _scrollerContentSize_H+self.imageView.height+self.activationButton.height+100);
    if (_scrollerContentSize_H > kSCREEN_HEIGHT-64) {
        [self.scrollView setContentOffset:CGPointMake(0,_scrollerContentSize_H-kSCREEN_HEIGHT+64+self.activationButton.height+self.imageView.height+30) animated:YES];
        
    }
}
- (void)createActivationCode
{
    UITextField *textField = [[UITextField alloc] init];
    textField.frame = CGRectMake(50, _scrollerContentSize_H, kSCREEN_WIDTH-100, 40);
    textField.delegate = self;
    textField.placeholder = @"店面编码";
    textField.tag = ValidationTextFieldTag+_textFieldTagAdd;
    textField.background = [UIImage imageNamed:@"asd"];
    [self.scrollView addSubview:textField];
    
    UITextField *textField2 = [[UITextField alloc] init];
    textField2.frame = CGRectMake(textField.x, textField.y+textField.height+5, textField.width, 40);
    textField2.delegate = self;
    textField2.placeholder = @"卡券激活码";
    textField2.tag = ActivationTextFieldTag+_textFieldTagAdd;
    textField2.background = [UIImage imageNamed:@"asd"];
    [self.scrollView addSubview:textField2];
    
    _scrollerContentSize_H = (textField2.y+textField2.height)+10;
    
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
            if ([[responseObject objectForKey:@"result"] integerValue] == 1) {
                NSDictionary *dict = @{@"yzm": _validationStr,@"jhm":_activationStr};
                [_codeArray addObject:dict];
                UITextField *textField = (UITextField *)[self.view viewWithTag:ActivationTextFieldTag+_textFieldTagAdd];
                textField.enabled = NO;
                textField.textColor = kLightGrayTextColor;
                UITextField *textField2 = (UITextField *)[self.view viewWithTag:ValidationTextFieldTag+_textFieldTagAdd];
                textField2.enabled = NO;
                textField2.textColor = kLightGrayTextColor;
                
                [self scrollViewFrame];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }else{
        jxt_showAlertTitle(@"请输入验证码或激活码");
    }
}
- (void)scrollViewFrame
{
    /**
     * 没点击一次验证码和激活码tag值加一
     */
    _textFieldTagAdd++;
    _activationStr = @"";
    _validationStr = @"";
    [self createActivationCode];
    if (_textFieldTagAdd > 1) {
        self.deleteBtn.hidden = NO;
    }else{
        self.deleteBtn.hidden = YES;
    }
    self.addBtn.frame = CGRectMake(kSCREEN_WIDTH-150, _scrollerContentSize_H, 100, 30);
    self.deleteBtn.frame = CGRectMake(50, _scrollerContentSize_H, 100, 30);
    self.activationButton.frame = CGRectMake(90/3, self.deleteBtn.y+self.deleteBtn.height, kSCREEN_WIDTH-60, 40);
    
    if (kSCREEN_HEIGHT-self.activationButton.y-self.activationButton.height-self.imageView.x <  140) {
        self.imageView.frame = CGRectMake(self.imageView.x, self.activationButton.y+self.activationButton.height+20, self.imageView.width, self.imageView.height);
        
    }
    self.scrollView.contentSize = CGSizeMake(kSCREEN_WIDTH, _scrollerContentSize_H+self.imageView.height+self.activationButton.height+100);
    if (_scrollerContentSize_H > kSCREEN_HEIGHT-64) {
        [self.scrollView setContentOffset:CGPointMake(0,_scrollerContentSize_H-kSCREEN_HEIGHT+64+self.activationButton.height+self.imageView.height+30) animated:YES];
        
    }
}

- (void)activationBtnClick:(UIButton *)btn
{
    [self.view endEditing:NO];
    
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
        jxt_showAlertOneButton(@"提示", responseObject[@"message"], @"确定", ^(NSInteger buttonIndex) {
            if ([responseObject[@"result"] integerValue] == 1) {
                _block();
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        });
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD dismiss];
        
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
