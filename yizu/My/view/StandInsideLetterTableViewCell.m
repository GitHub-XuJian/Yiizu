//
//  StandInsideLetterTableViewCell.m
//  yizu
//
//  Created by 徐健 on 2017/12/4.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "StandInsideLetterTableViewCell.h"

@interface StandInsideLetterTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation StandInsideLetterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *label2 = [[UILabel alloc] init];
        [self.contentView addSubview:label2];
        self.titleLabel = label2;
        
        UILabel *label3 = [[UILabel alloc] init];
        label3.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:label3];
        self.timeLabel = label3;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = kColorLine;
        [self.contentView addSubview:lineView];
        self.lineView = lineView;
    }
    return self;
}
- (void)setCellDict:(NSDictionary *)cellDict
{
    self.titleLabel.frame = CGRectMake(10, 0, kSCREEN_WIDTH/2-10, 60);
    self.timeLabel.frame = CGRectMake(kSCREEN_WIDTH-(kSCREEN_WIDTH/2-10)-10, 0, kSCREEN_WIDTH/2-10, 60);
    self.lineView.frame = CGRectMake(0, 60, kSCREEN_WIDTH, 0.5);

    if ([cellDict[@"stata"] isEqualToString:@"0"]) {
        self.titleLabel.text = @"未读";
    }else{
        self.titleLabel.text = @"已读";
    }
    self.timeLabel.text = [EncapsulationMethod timeStrWithTimeStampMinutes:cellDict[@"pdate"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
