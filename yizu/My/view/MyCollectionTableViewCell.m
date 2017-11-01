//
//  MyCollectionTableViewCell.m
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "MyCollectionTableViewCell.h"
@interface MyCollectionTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation MyCollectionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10, 10, 135/2-20, 135/2-20);
        imageView.clipsToBounds=YES;
        imageView.layer.cornerRadius=(135/2-20)/2;
        [self.contentView addSubview:imageView];
        self.iconImageView = imageView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(imageView.x+imageView.width+10, 10, kSCREEN_WIDTH/2, (135/2-20)/2);
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.frame = CGRectMake(imageView.x+imageView.width+10, nameLabel.y+nameLabel.height, kSCREEN_WIDTH-imageView.x+imageView.width, (135/2-20)/2);
        addressLabel.textColor = kLightGrayTextColor;
        addressLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:addressLabel];
        self.addressLabel = addressLabel;
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.frame = CGRectMake(kSCREEN_WIDTH/2, 10, kSCREEN_WIDTH/2-10, (135/2-20)/2);
        timeLabel.textColor = kLightGrayTextColor;
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
//        UILabel *lineview = [[UILabel alloc] init];
//        lineview.backgroundColor = kColorLine;
//        lineview.frame = CGRectMake(0, 135/2, kSCREEN_WIDTH, 0.5);
//        [self.contentView addSubview:lineview];
    }
    return self;
}
- (void)setCellModel:(MyCollectionModel *)cellModel
{
    self.cellModel = cellModel;
    
}
- (void)createData
{
    
}
- (void)createFrame
{
    
}
- (void)setNameStr:(NSString *)nameStr
{
    self.nameLabel.text = nameStr;
}
- (void)setIconImage:(UIImage *)iconImage
{
    self.iconImageView.image = iconImage;
}
- (void)setAddressStr:(NSString *)addressStr
{
    self.addressLabel.text = addressStr;
}
- (void)setTimeStr:(NSString *)timeStr
{
    self.timeLabel.text = timeStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
