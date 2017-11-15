//
//  ActivationCodePayTableViewCell.m
//  yizu
//
//  Created by 徐健 on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivationCodePayTableViewCell.h"
@interface ActivationCodePayTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ActivationCodePayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        UILabel *subTitleLabel = [[UILabel alloc] init];
        subTitleLabel.textAlignment =NSTextAlignmentRight;
        [self addSubview:subTitleLabel];
        self.subTitleLabel = subTitleLabel;
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorLine;
        [self addSubview:lineView];
        self.lineView = lineView;
    }
    return self;
}
- (void)setDictCell:(NSDictionary *)dictCell
{
    _dictCell = dictCell;
    [self createData];
    [self createFrame];
}
- (void)createData
{
    self.titleLabel.text = _dictCell[@"code"];
    self.subTitleLabel.text = _dictCell[@"paymoney"];
}
- (void)createFrame
{
    self.titleLabel.frame = CGRectMake(20, 0, kSCREEN_WIDTH-50, 60);
    self.subTitleLabel.frame = CGRectMake(kSCREEN_WIDTH-100, 0, 90, 60);
    self.lineView.frame = CGRectMake(0, 60, kSCREEN_WIDTH, 0.5);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
