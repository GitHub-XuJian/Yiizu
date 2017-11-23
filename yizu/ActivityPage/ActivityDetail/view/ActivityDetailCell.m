//
//  ActivityDetailCell.m
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityDetailCell.h"
#import "ActivityDetailListModel.h"
#import "FollowBtn.h"

@interface ActivityDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bigIma;

@property (weak, nonatomic) IBOutlet UILabel *movableLab;

@property (weak, nonatomic) IBOutlet FollowBtn *followBtn;

@end

@implementation ActivityDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ActivityDetailListModel *)model
{
    _model= model;
    [self.bigIma sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,model.mainpic]]];
    
    self.movableLab.text=model.movable;
    
    NSLog(@"%@",model.status);
    
    if ([model.status isEqualToString:@"1"]) {
        self.followBtn.isFollow=YES;
       
    }else
    {
        self.followBtn.isFollow=NO;
      
    }
    
    
    self.followBtn.activityid=model.activityid;
    self.followBtn.followCount=model.attention.integerValue;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
