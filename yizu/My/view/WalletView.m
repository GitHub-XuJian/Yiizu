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
    NSArray *array = @[@"银行卡",@"零钱",@"积分"];
    NSArray *imageArray = @[@"WalletBankCard",@"change",@"integral"];

    for (int i = 0; i < array.count; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0+i*kSCREEN_WIDTH/3, 0, kSCREEN_WIDTH/3, 200);
        view.tag = i;
        [self addSubview:view];
        
        //点击手势
        UITapGestureRecognizer *r5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
        r5.numberOfTapsRequired = 1;
        [view addGestureRecognizer:r5];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(40, 40, kSCREEN_WIDTH/3-80, kSCREEN_WIDTH/3-80);
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [view addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, imageView.y+imageView.height+10, view.width, 20);
        titleLabel.text = array[i];
        titleLabel.textColor = [UIColor colorWithRed:0.30f green:0.30f blue:0.30f alpha:1.00f];;
        titleLabel.textAlignment =NSTextAlignmentCenter;
        [view addSubview:titleLabel];
        if (i == 1) {
            UILabel *subLabel = [[UILabel alloc] init];
            subLabel.frame = CGRectMake(0, titleLabel.y+titleLabel.height+10, view.width, 20);
            subLabel.textColor = [UIColor colorWithRed:0.60f green:0.60f blue:0.60f alpha:1.00f];;
            subLabel.textAlignment =NSTextAlignmentCenter;
            [view addSubview:subLabel];
            self.moneyLabel = subLabel;
        }
    }
}
- (void)doTapChange:(UITapGestureRecognizer *)sender
{
    DLog(@"%ld",sender.view.tag);
    if([_delegate respondsToSelector:@selector(clickWithTag:)]){
        [_delegate clickWithTag:sender.view.tag];
    }
    
    
}
@end
