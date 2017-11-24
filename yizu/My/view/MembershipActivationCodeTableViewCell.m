//
//  MembershipActivationCodeTableViewCell.m
//  yizu
//
//  Created by 徐健 on 17/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MembershipActivationCodeTableViewCell.h"
@interface MembershipActivationCodeTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *classBtn;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation MembershipActivationCodeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kFontOther;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [classBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [classBtn.layer setBorderWidth:0.5];
        classBtn.layer.borderColor=[UIColor blackColor].CGColor;
        //将多余的部分切掉
        classBtn.layer.masksToBounds = YES;
        [self.contentView addSubview:classBtn];
        self.classBtn = classBtn;
        
        UILabel *lineview = [[UILabel alloc] init];
        lineview.backgroundColor = kColorLine;
        [self.contentView addSubview:lineview];
        self.lineView = lineview;
    }
    return self;
}
- (void)btnClick:(UIButton *)btn
{
    NSLog(@"%@",btn.titleLabel.text);
    _block(btn);
}

- (void)setDict:(NSDictionary *)dict
{
    self.nameLabel.frame = CGRectMake(65/3, 0, kSCREEN_WIDTH/2, kTableViewCell_HEIGHT);
    self.lineView.frame = CGRectMake(0, kTableViewCell_HEIGHT, kSCREEN_WIDTH, 0.5);
    self.nameLabel.text = dict[@"code"];
}
- (void)setButtonStr:(NSString *)buttonStr
{
    if (buttonStr.length) {
        if ([buttonStr isEqualToString:@"已分享"]) {
            self.classBtn.hidden = NO;
            self.classBtn.enabled = NO;
            self.classBtn.frame = CGRectMake(kSCREEN_WIDTH - 90, kTableViewCell_HEIGHT/2-30/2, 70, 30);
            [self.classBtn setTitle:buttonStr forState:UIControlStateNormal];
            //设置圆角
            self.classBtn.layer.cornerRadius = 10 / 2;
        }else{
            self.classBtn.hidden = NO;
            self.classBtn.frame = CGRectMake(kSCREEN_WIDTH - 70, kTableViewCell_HEIGHT/2-30/2, 50, 30);
            [self.classBtn setTitle:buttonStr forState:UIControlStateNormal];
            //设置圆角
            self.classBtn.layer.cornerRadius = 10 / 2;
        }
        
    }else{
        self.classBtn.hidden = YES;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
