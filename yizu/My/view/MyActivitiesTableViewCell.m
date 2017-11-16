//
//  MyActivitiesTableViewCell.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MyActivitiesTableViewCell.h"
@interface MyActivitiesTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *statelabel;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) MyActivitiesModel *activitiesModel;
@end
@implementation MyActivitiesTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.iconImageView = imageView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kFontOther;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *addressLabel = [[UILabel alloc] init];
        //设置多行
        [addressLabel setNumberOfLines:0];
        addressLabel.textColor = kLightGrayTextColor;
        addressLabel.font = kFontMini;
        [self.contentView addSubview:addressLabel];
        self.addressLabel = addressLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = kLightGrayTextColor;
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        UILabel *statelabel = [[UILabel alloc] init];
        [self.contentView addSubview:statelabel];
        self.statelabel = statelabel;
        
        UILabel *lineview = [[UILabel alloc] init];
        lineview.backgroundColor = kColorLine;
        [self.contentView addSubview:lineview];
        self.lineView = lineview;
    }
    return self;
}
-(void)initWithMyActivitiesModel:(MyActivitiesModel *)activitiesModel
{
    self.activitiesModel = activitiesModel;
    [self createData];
    [self createFrame];
}
- (void)createData
{
    self.nameLabel.text = self.activitiesModel.nameStr;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.activitiesModel.iconImage]];
    self.addressLabel.text = self.activitiesModel.addressStr;
    self.timeLabel.text = self.activitiesModel.timeStr;
    self.statelabel.text = self.activitiesModel.stateStr;

}
- (void)createFrame
{
    self.iconImageView.frame = CGRectMake(10, 20, 100, 100-40);
    self.nameLabel.frame = CGRectMake(self.iconImageView.x+self.iconImageView.width+10, 10, kSCREEN_WIDTH/2, (135/2-20)/2);
    self.addressLabel.frame = CGRectMake(self.iconImageView.x+self.iconImageView.width+10, self.nameLabel.y+self.nameLabel.height, kSCREEN_WIDTH/2-50, 100-20-self.nameLabel.height);
    self.timeLabel.frame = CGRectMake(kSCREEN_WIDTH/2, 10, kSCREEN_WIDTH/2-10, (135/2-20)/2);
    self.statelabel.frame = CGRectMake(kSCREEN_WIDTH-70,100/2-30/2,70,30);
    self.lineView.frame = CGRectMake(0, 100, kSCREEN_WIDTH, 0.5);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
