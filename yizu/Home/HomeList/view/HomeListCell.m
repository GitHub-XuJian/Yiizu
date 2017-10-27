//
//  HomeListCell.m
//  yizu
//
//  Created by myMac on 2017/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeListCell.h"
#import "HomeListModel.h"
#import "UIImageView+AFNetworking.h"
@interface HomeListCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIImageView *ima1;
@property (weak, nonatomic) IBOutlet UIImageView *ima2;
@property (weak, nonatomic) IBOutlet UIImageView *ima3;
@property (weak, nonatomic) IBOutlet UIImageView *iconIma;
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
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
