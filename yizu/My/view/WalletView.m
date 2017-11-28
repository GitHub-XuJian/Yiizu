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
        imageView.frame = CGRectMake(30, 30, kSCREEN_WIDTH/3-60, kSCREEN_WIDTH/3-60);
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [view addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, imageView.y+imageView.height+10, view.width, 20);
        titleLabel.text = array[i];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment =NSTextAlignmentCenter;
        [view addSubview:titleLabel];
        if (i == 1) {
            UILabel *subLabel = [[UILabel alloc] init];
            subLabel.frame = CGRectMake(0, titleLabel.y+titleLabel.height+10, view.width, 20);
            subLabel.text = array[i];
            subLabel.textColor = [UIColor whiteColor];
            subLabel.textAlignment =NSTextAlignmentCenter;
            [view addSubview:subLabel];
            self.moneyLabel = subLabel;
        }
    }
}
- (void)doTapChange:(UITapGestureRecognizer *)sender
{
    NSLog(@"%ld",sender.view.tag);
    if([_delegate respondsToSelector:@selector(clickWithTag:)]){
        [_delegate clickWithTag:sender.view.tag];
    }
    
    
}
@end
