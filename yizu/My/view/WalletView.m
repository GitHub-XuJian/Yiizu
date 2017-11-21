//
//  WalletView.m
//  yizu
//
//  Created by 徐健 on 2017/11/17.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "WalletView.h"
@interface WalletView ()
@property (nonatomic, strong) UILabel *moneyLabel;
@end

@implementation WalletView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUIView];
    }
    return self;
}
- (void)reloadMonay:(NSString *)monayStr
{
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@", monayStr];
}
- (void)createUIView
{
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.frame = CGRectMake(0, 126/3, self.width, 43/3);
    accountLabel.text = @"账户余额";
    accountLabel.font = [UIFont systemFontOfSize:18];
    accountLabel.textAlignment =NSTextAlignmentCenter;
    accountLabel.textColor = [UIColor whiteColor];
    [self addSubview:accountLabel];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.frame = CGRectMake(0, accountLabel.y+accountLabel.height+107/3, self.width, 102/3);
    moneyLabel.text = @"￥0";
    moneyLabel.font = [UIFont systemFontOfSize:50];
    moneyLabel.textAlignment =NSTextAlignmentCenter;
    moneyLabel.textColor = [UIColor whiteColor];
    [self addSubview:moneyLabel];
    self.moneyLabel = moneyLabel;
}
@end
