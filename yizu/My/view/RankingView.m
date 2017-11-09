//
//  RankingView.m
//  yizu
//
//  Created by 徐健 on 2017/11/7.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "RankingView.h"

@implementation RankingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.70f green:0.13f blue:0.35f alpha:1.00f];
        //设置圆角
        self.layer.cornerRadius = 10;
        //将多余的部分切掉
        self.layer.masksToBounds = YES;
        
        [self createUIView];
    }
    return self;
}
- (void)createUIView
{
   
}

@end
