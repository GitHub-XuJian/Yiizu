//
//  ActivityCell.m
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityCell.h"
#import "ActivityLsitModel.h"

@interface ActivityCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bigIma;

@end

@implementation ActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ActivityLsitModel *)model
{
    _model =model;
    
    //[self.bigIma sd_setImageWithURL:[NSURL URLWithString:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,model.mainpic]]];
  [self.bigIma sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,model.mainpic]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
