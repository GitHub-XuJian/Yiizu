//
//  MembershipActivationCodeView.m
//  yizu
//
//  Created by 徐健 on 17/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MembershipActivationCodeView.h"

@implementation MembershipActivationCodeView
{
    ClassBlock _classClock;
    UIView * _lineView;
}
- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSMutableArray *)titleArray andClassBlock:(ClassBlock)classBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        _classClock = classBlock;
        self.backgroundColor = kMAIN_BACKGROUND_COLOR;
        CGFloat btn_W = kSCREEN_WIDTH/titleArray.count;
        for (int i = 0 ; i < titleArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*btn_W, 0, btn_W, self.height);
            btn.tag = i;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:kLightGrayTextColor forState:UIControlStateNormal];
            btn.selected = NO;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(classClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == 0) {
                btn.selected = YES;
                [self classClick:btn];
            }
        }
        UIView *lineView = [[UIView alloc] init];
        lineView.frame = CGRectMake(btn_W/2-30/2, self.height-5, 30, 3);
        lineView.backgroundColor = [UIColor blackColor];
        //设置圆角
        lineView.layer.cornerRadius = 3 / 2;
        //将多余的部分切掉
        lineView.layer.masksToBounds = YES;
        [self addSubview:lineView];
        _lineView = lineView;
    }
    return self;
}
- (void)classClick:(UIButton *)btn
{
    for (id obj in self.subviews)  {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton* theButton = (UIButton*)obj;
            if (![theButton isEqual:btn]) {
                theButton.selected = NO;
            }else{
                theButton.selected = YES;
                [UIView animateWithDuration:0.5 animations:^{
                    _lineView.x =theButton.x+(theButton.width/2-30/2);
                }];
            }
        }
    }
    _classClock(btn);
}
@end
