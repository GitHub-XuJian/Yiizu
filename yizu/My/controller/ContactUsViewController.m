//
//  ContactUsViewController.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()<UITextViewDelegate>
{
    //意见内容
    UITextView *contentTextView;
    //在UITextView上面覆盖个UILable
    UILabel *promptLabel;
}
@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createView];
}
- (void)createView
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 64, kSCREEN_WIDTH, 76/3);
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
    button.frame = CGRectMake(contentTextView.width-40, contentTextView.height-30, 30, 20);
    button.titleLabel.font = [UIFont systemFontOfSize:30];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = kFontOther;
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    [contentTextView addSubview:button];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(0, contentTextView.y+contentTextView.height, kSCREEN_WIDTH, 76/3);
    label2.text = @"       联系客服";
    label2.backgroundColor = [UIColor colorWithRed:0.93f green:0.92f blue:0.91f alpha:1.00f];
    [self.view addSubview:label2];
    
    UILabel *labelPhone = [[UILabel alloc] init];
    labelPhone.frame = CGRectMake(0, label2.y+label2.height, kSCREEN_WIDTH, 76/3);
    labelPhone.text = @"        客服电话：024-8888-8888";
    labelPhone.textColor = kLightGrayTextColor;
    labelPhone.font = kFontOther;
    labelPhone.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:labelPhone];
    
}
- (void)sendClick:(UIButton *)btn
{
    NSLog(@"发送");
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
