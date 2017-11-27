//
//  NoResultView.m
//  yizu
//
//  Created by myMac on 2017/11/2.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "NoResultView.h"

@implementation NoResultView


- (instancetype)init
{
    if(self=[super init]){
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    UIImageView* imaView=[[UIImageView alloc]init];
    imaView.frame=CGRectMake(kSCREEN_WIDTH/2-50, 170, 100, 100);
    imaView.image=[UIImage imageNamed:@"ooo"];
    [self addSubview:imaView];
    
    UILabel* lab=[[UILabel alloc]init];
    //lab.backgroundColor=[UIColor cyanColor];
    lab.frame=CGRectMake(kSCREEN_WIDTH/2-75, CGRectGetMaxY(imaView.frame), 150, 50);
    lab.text=@"未找到商家";
    lab.textColor=[UIColor grayColor];
    lab.font=[UIFont systemFontOfSize:15];
    lab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:lab];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
