//
//  HomeListCell.m
//  yizu
//
//  Created by myMac on 2017/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.


#import "HomeListCell.h"
#import "HomeListModel.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
@interface HomeListCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *ima1;
@property (weak, nonatomic) IBOutlet UIImageView *ima2;
@property (weak, nonatomic) IBOutlet UIImageView *ima3;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
//商户简介
@property (weak, nonatomic) IBOutlet UILabel *chamberjjLab;
//已售lab
@property (weak, nonatomic) IBOutlet UILabel *obtainedLab;
//点赞数
@property (weak, nonatomic) IBOutlet UILabel *upvoteLab;



@end

@implementation HomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(HomeListModel *)model
{
    _model=model;
    
    self.nameLab.text=model.chambername;
    [self.ima1 setImageWithURL:[NSURL URLWithString:model.image1]];
    [self.ima2 setImageWithURL:[NSURL URLWithString:model.image2]];
    [self.ima3 setImageWithURL:[NSURL URLWithString:model.image3]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    self.upvoteLab.text=[NSString stringWithFormat:@"(%@)",model.upvote];
    self.obtainedLab.text=[NSString stringWithFormat:@"已售:%@",model.obtained];
    self.chamberjjLab.text=model.chamberjj;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
