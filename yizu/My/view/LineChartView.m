//
//  LineChartView.m
//  yizu
//
//  Created by 徐健 on 2017/11/7.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "LineChartView.h"
@interface LineChartView ()
{
    NSInteger i;
    NSTimer *_timer;
}
@property (nonatomic, strong) UILabel *subLabelLeft;
@property (nonatomic, strong) UILabel *subLabelRight;

@end
@implementation LineChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIView];
    }
    return self;
}
- (void)reloadWith:(NSDictionary *)recentlyDict and:(NSDictionary *)farthestDict
{
    _recentlyDict = recentlyDict;
    _farthestDict = farthestDict;
    [self createCoverView];
    [self updata];
}
- (void)updata
{
    self.subLabelLeft.text = [NSString stringWithFormat:@"%@天",_recentlyDict[@"time"]];
    self.subLabelRight.text = [NSString stringWithFormat:@"%@天",_farthestDict[@"time"]];;
}
- (void)createUIView
{
    //边框宽度
    [self.layer setBorderWidth:0.5];
    self.layer.borderColor=kColorLine.CGColor;
    
    UILabel *titleLabelLeft = [[UILabel alloc] init];
    titleLabelLeft.frame = CGRectMake(0, 0, self.width/2, 30);
    titleLabelLeft.text = @"最近补贴进度";
    titleLabelLeft.textAlignment = NSTextAlignmentCenter;
    titleLabelLeft.font = kFontOther;
    [self addSubview:titleLabelLeft];
    /**
     * 画线
     */
    for (int i = 0;i < 16; i++) {
        UIView *backLeftView = [[UIView alloc] init];
        backLeftView.frame = CGRectMake(10, self.height-30-i*10, self.width/2-15, 5);
        //设置圆角
        backLeftView.layer.cornerRadius = 5;
        //将多余的部分切掉
        backLeftView.layer.masksToBounds = YES;
        backLeftView.backgroundColor = kColorLine;
        [self addSubview:backLeftView];
    }
    
    UILabel *subLabelLeft = [[UILabel alloc] init];
    subLabelLeft.frame = CGRectMake(0, self.height-30, self.width/2, 30);
    subLabelLeft.text = @"天";
    subLabelLeft.textAlignment = NSTextAlignmentCenter;
    subLabelLeft.font = kFontOther;
    [self addSubview:subLabelLeft];
    self.subLabelLeft = subLabelLeft;
    
    UILabel *titleLabelRight = [[UILabel alloc] init];
    titleLabelRight.frame = CGRectMake(titleLabelLeft.x+titleLabelLeft.width, 0, self.width/2, 30);
    titleLabelRight.text = @"最远补贴进度";
    titleLabelRight.textAlignment = NSTextAlignmentCenter;
    titleLabelRight.font = kFontOther;
    [self addSubview:titleLabelRight];
    
    /**
     * 画线
     */
    for (int i = 0;i < 16; i++) {
        UIView *backRightView = [[UIView alloc] init];
        backRightView.frame = CGRectMake(self.width/2+5, self.height-30-i*10, self.width/2-15, 5);
        //设置圆角
        backRightView.layer.cornerRadius = 5;
        //将多余的部分切掉
        backRightView.layer.masksToBounds = YES;
        backRightView.backgroundColor = kColorLine;
        [self addSubview:backRightView];
        
    }
    UILabel *subLabelRight = [[UILabel alloc] init];
    subLabelRight.frame = CGRectMake(self.width/2, self.height-30, self.width/2, 30);
    subLabelRight.text = @"天";
    subLabelRight.textAlignment = NSTextAlignmentCenter;
    subLabelRight.font = kFontOther;
    [self addSubview:subLabelRight];
    self.subLabelRight = subLabelRight;
}
- (void)timerAction
{
    if (i<[self CalculatePercentage:_recentlyDict]) {
        UIView *backLeftView = [[UIView alloc] init];
        backLeftView.frame = CGRectMake(10, self.height-30-i*10, self.width/2-15, 5);
        //设置圆角
        backLeftView.layer.cornerRadius = 5;
        //将多余的部分切掉
        backLeftView.layer.masksToBounds = YES;
        backLeftView.backgroundColor = [UIColor greenColor];
        [self addSubview:backLeftView];
    }
    if (i<[self CalculatePercentage:_farthestDict]) {
        
        UIView *backRightView = [[UIView alloc] init];
        backRightView.frame = CGRectMake(self.width/2+5, self.height-30-i*10, self.width/2-15, 5);
        //设置圆角
        backRightView.layer.cornerRadius = 5;
        //将多余的部分切掉
        backRightView.layer.masksToBounds = YES;
        backRightView.backgroundColor = [UIColor redColor];
        [self addSubview:backRightView];
    }
    
    if (i>=[self CalculatePercentage:_farthestDict]) {
        [_timer invalidate];
    }
    i++;
}
- (void)createCoverView
{
    i = 0;
    _timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}
- (float)CalculatePercentage:(NSDictionary *)dict
{
    float time = [dict[@"time"] longValue];
    float numtime =[dict[@"numtime"] longValue];
    float num = time*16/numtime;
    return num;
}
@end
