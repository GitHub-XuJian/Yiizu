//
//  MallTransactionRecordsTableViewCell.m
//  yizu
//
//  Created by 徐健 on 2017/11/21.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MallTransactionRecordsTableViewCell.h"
@interface MallTransactionRecordsTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@property (nonatomic, strong) UIView *lineView;
@end
@implementation MallTransactionRecordsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *subTitleLabel = [[UILabel alloc] init];
        subTitleLabel.font = kFontOther;
        subTitleLabel.textColor = kLightGrayTextColor;
        [self addSubview:subTitleLabel];
        self.subTitleLabel = subTitleLabel;
        
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.textAlignment =NSTextAlignmentRight;
        moneyLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:moneyLabel];
        self.moneyLabel = moneyLabel;
        
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
    self.titleLabel.text = [NSString stringWithFormat:@"%@支付",_dictCell[@"orderbuy"]];
    self.subTitleLabel.text = [EncapsulationMethod timeStrWithTimeStamp:_dictCell[@"ordertime"]];
    self.moneyLabel.text = [NSString stringWithFormat:@"-%@",_dictCell[@"ordercuurt"]];
}
- (void)createFrame
{
    self.titleLabel.frame = CGRectMake(20, 5, 100, 25);
    self.subTitleLabel.frame = CGRectMake(20, self.titleLabel.y+self.titleLabel.height, 100, 25);
    self.moneyLabel.frame = CGRectMake(kSCREEN_WIDTH-100, 0, 90, 60);
    self.lineView.frame = CGRectMake(0, 60, kSCREEN_WIDTH, 0.5);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
