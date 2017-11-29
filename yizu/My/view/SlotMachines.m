//
//  SlotMachines.m
//  yizu
//
//  Created by 徐健 on 2017/11/29.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "SlotMachines.h"
@interface SlotMachines ()
{
    NSInteger _time;
}
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *labelzong;
@property (nonatomic , strong)NSTimer *timer;
@property (nonatomic, strong) UIButton *determineBtn;


@end
@implementation SlotMachines

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _time = 0;
        [self createUIView];
        [self createTime];
    }
    return self;
}
- (void)createTime
{
    _timer =  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(function:) userInfo:nil repeats:YES];
}
- (void)function:(NSTimer *)timer
{
    self.label1.text = [NSString stringWithFormat:@"%u",arc4random() % 100];
    self.label2.text = [NSString stringWithFormat:@"%u",arc4random() % 100];
    if (_time >= 50) {
        self.label1.text = [NSString stringWithFormat:@"%@",_dict[@"paymoney"]];
        self.label2.text = [NSString stringWithFormat:@"%@",_dict[@"nextmoney"]];
        self.labelzong.text = [NSString stringWithFormat:@"%@",_dict[@"payzong"]];
        self.determineBtn.enabled = YES;
        //取消定时器
        [timer invalidate];
        timer = nil;
    }else{
        _time++;
    }
}
- (void)createUIView
{
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame = CGRectMake(80, 150, kSCREEN_WIDTH-160, 80);
    imageView1.image = [UIImage imageNamed:@"Slotmachines1"];
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.frame = CGRectMake(50, imageView1.y+imageView1.height, kSCREEN_WIDTH-150, 50);
    imageView2.image = [UIImage imageNamed:@"Slotmachines2"];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView2];
    
    UILabel *zongLabel = [[UILabel alloc] init];
    zongLabel.frame = CGRectMake(imageView2.x+imageView2.width, imageView2.y, kSCREEN_WIDTH-imageView2.width-50, 50);
    zongLabel.text = @"";
    zongLabel.textColor = [UIColor colorWithRed:0.98f green:0.87f blue:0.04f alpha:1.00f];
    zongLabel.font =  [UIFont fontWithName:@"PingFangTC-Light" size:30];
    [self addSubview:zongLabel];
    self.labelzong = zongLabel;
    
    UIImageView *imageView3 = [[UIImageView alloc] init];
    imageView3.frame = CGRectMake(60, imageView2.y+imageView2.height, kSCREEN_WIDTH-120, 50);
    imageView3.image = [UIImage imageNamed:@"Slotmachines3"];
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView3];
    
    UIImageView *imageView4 = [[UIImageView alloc] init];
    imageView4.frame = CGRectMake(60, imageView3.y+imageView3.height+10, kSCREEN_WIDTH-120, 210);
    imageView4.image = [UIImage imageNamed:@"Slotmachines4"];
    imageView4.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView4];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(18, 18, (imageView4.width-20)/3, imageView4.height-36);
    label1.text = @"";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor colorWithRed:0.98f green:0.87f blue:0.04f alpha:1.00f];
    label1.font =  [UIFont fontWithName:@"PingFangTC-Light" size:50];
    [imageView4 addSubview:label1];
    self.label1 = label1;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(imageView4.width-15-(imageView4.width-20)/3, 18, (imageView4.width-20)/3, imageView4.height-36);
    label2.text = @"";
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor colorWithRed:0.98f green:0.87f blue:0.04f alpha:1.00f];
    label2.font =  [UIFont fontWithName:@"PingFangTC-Light" size:50];
    [imageView4 addSubview:label2];
    self.label2 = label2;

    UIButton *determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    determineBtn.frame = CGRectMake(296/3, imageView4.y+imageView4.height+10, kSCREEN_WIDTH-296/3*2, 40);
    [determineBtn addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
    determineBtn.enabled = NO;
    [determineBtn setImage:[UIImage imageNamed:@"Slotmachinesdetermine"] forState:UIControlStateNormal];
    [self addSubview:determineBtn];
    self.determineBtn = determineBtn;
}
- (void)determineBtnClick
{
    [self removeFromSuperview];
}
@end
