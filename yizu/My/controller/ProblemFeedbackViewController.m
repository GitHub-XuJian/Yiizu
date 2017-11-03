//
//  ProblemFeedbackViewController.m
//  yizu
//
//  Created by 徐健 on 2017/10/28.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ProblemFeedbackViewController.h"

@interface ProblemFeedbackViewController ()<UITextFieldDelegate,UITextViewDelegate>
{
    //意见内容
    UITextView *contentTextView;
    //在UITextView上面覆盖个UILable
    UILabel *promptLabel;
    NSString *_name;
    NSString *_content;
}
@end

@implementation ProblemFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kMAIN_BACKGROUND_COLOR;
    [self createView];
}
- (void)createView
{
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(0, 64, kSCREEN_WIDTH, 76/3);
    label2.text = @"       姓名";
    label2.backgroundColor = [UIColor colorWithRed:0.93f green:0.92f blue:0.91f alpha:1.00f];
    [self.view addSubview:label2];
    
    UITextField *nameTextField = [[UITextField alloc] init];
    nameTextField.frame = CGRectMake(0, label2.y+label2.height, kSCREEN_WIDTH, 40);
    nameTextField.placeholder = @"       请输入姓名";
    nameTextField.delegate = self;
    nameTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameTextField];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, nameTextField.y+nameTextField.height+10, kSCREEN_WIDTH, 76/3);
    label.text = @"       问题反馈";
    label.backgroundColor = [UIColor colorWithRed:0.93f green:0.92f blue:0.91f alpha:1.00f];
    [self.view addSubview:label];
    
    //意见内容
    contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, label.y+label.height, kSCREEN_WIDTH, 355/3)];
    contentTextView.font = kFontOther;
    contentTextView.delegate = self;
    [self.view addSubview:contentTextView];
    
    //在UITextView上面覆盖个UILable
    promptLabel = [[UILabel alloc] init];
    promptLabel.frame =CGRectMake(5,5,kSCREEN_WIDTH-70/3,25);
    promptLabel.text = @"       有什么问题，和我们说说吧，我们会立刻解决的哦！";
    promptLabel.enabled = NO;
    promptLabel.backgroundColor = [UIColor clearColor];
    promptLabel.font =  [UIFont systemFontOfSize:13];
    promptLabel.textColor = [UIColor redColor];
    [contentTextView addSubview:promptLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(contentTextView.width-50, contentTextView.y+contentTextView.height, 40, 30);
    button.titleLabel.font = [UIFont systemFontOfSize:30];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = kFontOther;
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    //边框宽度
    [button.layer setBorderWidth:0.5];
    button.layer.borderColor=kColorLine.CGColor;
    [self.view addSubview:button];
    
}
- (void)sendClick:(UIButton *)btn
{
    [[UIApplication sharedApplication].keyWindow endEditing:NO];
    NSLog(@"发送");
    if (_name.length == 0) {
        jxt_showAlertTitle(@"请输入姓名");
    }else if (_content.length == 0) {
        jxt_showAlertTitle(@"请输入反馈问题");
    }else{
        NSDictionary *dict = @{@"name":_name,@"info":_content,@"time":[EncapsulationMethod getCurrentTimes]};
        NSString *urlStr = [[NSString stringWithFormat:@"%@Mobile/Support/information",Main_Server] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([responseObject[@"wenti"] isEqualToString:@"success"]) {
                jxt_showAlertTitle(@"反馈成功");
            }else{
                jxt_showAlertTitle(@"反馈失败");
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        promptLabel.hidden = NO;
    }else{
        promptLabel.hidden = YES;
    }
    //首行缩进
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;    //行间距
    //    paragraphStyle.maximumLineHeight = 60;   /**最大行高*/
    paragraphStyle.firstLineHeadIndent = 70/3;    /**首行缩进宽度*/
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:13],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
    _content = textView.text;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _name = textField.text;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
