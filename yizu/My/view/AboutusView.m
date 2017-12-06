//
//  AboutusView.m
//  yizu
//
//  Created by 徐健 on 2017/11/7.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#define ViewTag 1234567

#import "AboutusView.h"
#import "WebViewController.h"

@interface AboutusView ()
@property (nonatomic, strong) NSArray *array2;
@end
@implementation AboutusView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AboutUSBack"]];
    backImageView.frame = CGRectMake(0, 0, self.width, self.height);
    backImageView.userInteractionEnabled = YES;
    [self addSubview:backImageView];
    
    CGFloat label_W = [EncapsulationMethod calculateRowWidth:@"版本：1.0" andFont:18 andHight:30];
    UILabel *versionNumberLabel = [[UILabel alloc] init];
    versionNumberLabel.frame = CGRectMake(kSCREEN_WIDTH/2-label_W/2, 550/3, label_W, 30);
    versionNumberLabel.text = @"版本：1.0";
    [self addSubview:versionNumberLabel];
    
    NSArray *array = @[@"客服热线",@"代理合作",@"商家合作"];
    _array2 = @[@"4001-877-599",@"024-67875156",@"024-67875156"];
    for (int i = 0; i < array.count; i++) {
        UIView * view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 770/3+i*41, kSCREEN_WIDTH, 40);
        view.backgroundColor = [UIColor whiteColor];
        view.tag = ViewTag+i;
        view.userInteractionEnabled = YES;
        [self addSubview:view];
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mTitlePress:)];
        [view addGestureRecognizer:recognizer];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(44/3, 0, 118/2, 40);
        label.text = array[i];
        label.font = kFontOther;
        [view addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.frame = CGRectMake(kSCREEN_WIDTH - 40/3 - kSCREEN_WIDTH/2, 0, kSCREEN_WIDTH/2, 40);
        label2.text = _array2[i];
        label2.textAlignment = NSTextAlignmentRight;
        label2.font = kFontOther;
        [view addSubview:label2];
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kSCREEN_HEIGHT-130, kSCREEN_WIDTH, 20);
    [btn setTitle:@"《依足用户须知》" forState:UIControlStateNormal];
    btn.titleLabel.font = kFontOther;
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(mTitlePress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.frame = CGRectMake(0, btn.y+btn.height, kSCREEN_WIDTH, 20);
    label3.text = @"辽宁金佰贝网络科技有限公司   版权所有";
    label3.textAlignment = NSTextAlignmentCenter;
    label3.font = kFontOther;
    [self addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.frame = CGRectMake(0, label3.y+label3.height, kSCREEN_WIDTH, 20);
    label4.text = @"Copyr i ght ⭕️2017 YIZU AI Right Reserved.";
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = kFontOther;
    [self addSubview:label4];
}

//调用方法
-(void)mTitlePress:(id)recognizer{
    DLog(@"View点击事件");
    if ([recognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tempLP = (UITapGestureRecognizer *)recognizer;
        [EncapsulationMethod callPhoneStr:_array2[tempLP.view.tag-ViewTag]];
    }else if([recognizer isKindOfClass:[UIButton class]]){
        WebViewController *webViewVC = [[WebViewController alloc] init];
        webViewVC.urlStr = [NSString stringWithFormat:@"%@Home/Hereto/bang",Main_Server];
        webViewVC.title = @"用户协议";
        [[EncapsulationMethod viewController:self].navigationController pushViewController:webViewVC animated:YES];
    }
}

@end
