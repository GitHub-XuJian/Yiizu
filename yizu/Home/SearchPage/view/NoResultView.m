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
    imaView.frame=CGRectMake(self.frame.size.width/2+50, 70, 100, 100);
    //imaView.image=[UIImage imageNamed:@"icon_default_avatar"];
    [self addSubview:imaView];
    
    UILabel* lab=[[UILabel alloc]init];
    lab.frame=CGRectMake(self.frame.size.width/2, CGRectGetMaxY(imaView.frame), 50, 50);
    lab.text=@"无结果~";
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
