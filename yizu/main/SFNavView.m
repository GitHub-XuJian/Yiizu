//
//  SFNavView.m
//  ContactsManager
//
//  Created by 徐健 on 17/1/10.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import "SFNavView.h"

@implementation SFNavView
{
    LeftBtnBlock _leftBlock;
    RightBtnBlock _rightBlock;
}

- (instancetype)initWithFrame:(CGRect)frame
             andTitle:(NSString *)titleStr
      andLeftBtnTitle:(NSString *)leftBtnStr
     andRightBtnTitle:(NSString *)rightBtnStr
      andLeftBtnBlock:(LeftBtnBlock)leftBlock
     andRightBtnBlock:(RightBtnBlock)rightBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        _leftBlock = leftBlock;
        _rightBlock = rightBlock;
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgNavigation"]];
        //UIImageView *imageView = [[UIImageView alloc] initWithImage:nil];
        imageView.frame = frame;
        imageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:imageView];
        
        if (titleStr.length) {
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.frame = CGRectMake(kSCREEN_WIDTH/2-200/2, 20, 200, imageView.frame.size.height-20);
            titleLabel.text = titleStr;
            [titleLabel setFont:[UIFont systemFontOfSize:20]];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:titleLabel];
        }
        if (leftBtnStr.length) {
            UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            leftBtn.frame = CGRectMake(0, 20, imageView.frame.size.height, imageView.frame.size.height-20);
//            [leftBtn setTitle:leftBtnStr forState:UIControlStateNormal];
            [leftBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
            [leftBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateHighlighted];
            leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:leftBtn];
        }
        if (rightBtnStr.length) {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            rightBtn.frame = CGRectMake(kSCREEN_WIDTH-imageView.frame.size.height, 20, imageView.frame.size.height, imageView.frame.size.height-20);
            [rightBtn setTitle:rightBtnStr forState:UIControlStateNormal];
            [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:rightBtn];
        }
    }
    return self;
}
- (void)leftBtnClick
{
    _leftBlock();
}
- (void)rightBtnClick
{
    _rightBlock();
}

@end
