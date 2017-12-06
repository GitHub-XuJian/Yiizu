//
//  ActivityCell.m
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityCell.h"
#import "ActivityLsitModel.h"
#import "CustomCellScrollView.h"
#import "SmallActivityListModel.h"

@interface ActivityCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bigIma;

@property (weak, nonatomic) IBOutlet UILabel *headLab;
@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UILabel *writingpicLab;

@end

@implementation ActivityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //DLog(@"%@\n%@",NSStringFromCGRect(self.customScroll.frame),NSStringFromCGRect(self.bigIma.frame));
    // Initialization code
    
//    self.collectionView.delegate=self;
//    self.collectionView.dataSource=self;
    
}

- (void)setModel:(ActivityLsitModel *)model
{
    _model =model;
    
    self.bigIma.layer.cornerRadius = 10;
    self.bigIma.layer.masksToBounds=YES;
    [self.bigIma sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,model.mainpic]]];
    self.headLab.text=model.caption1;
    self.cityLab.text=model.city_id;
    self.writingpicLab.text=model.writingpic;
    //self.customScrollView.imaArr=model.pic;

  self.customScrollView.Amodel=model;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
