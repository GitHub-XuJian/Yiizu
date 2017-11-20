//
//  HomeListCell.m
//  yizu
//
//  Created by myMac on 2017/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.

#define ImageAddress

#import "HomeListCell.h"
#import "HomeListModel.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "CellBtn.h"
#import "favoriteBtn.h"

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
//点赞
@property (weak, nonatomic) IBOutlet CellBtn *likeCellBtn;
//排名
@property (weak, nonatomic) IBOutlet UIButton *upView;

@property (weak, nonatomic) IBOutlet favoriteBtn *favBtn;







@end

@implementation HomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
     //[self.likeCellBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}






-(void)setModel:(HomeListModel *)model
{
    _model=model;
    
    self.likeCellBtn.likeCount=model.upvote.integerValue;
    //NSLog(@"开始点赞%ld",(long)model.upvote.integerValue);
    //self.likeCellBtn.islike=model.status;
//    if ([model.status isEqualToString:@"<null>"]) {
//        NSLog(@"开始状态null");
//        self.likeCellBtn.islike=NO;
//    }else
//    {
//        self.likeCellBtn.islike=YES;
//    }
    if (model.status) {
       self.likeCellBtn.islike=YES;
    }else
    {
        
       self.likeCellBtn.islike=NO;
        //NSLog(@"00000000000");
    }
    
    if (model.Turvy) {
        self.favBtn.issc=YES;
    }else
    {
        self.favBtn.issc=NO;
    }
    
    self.likeCellBtn.chambername=model.chambername;//保存店铺名字用于点赞
    self.favBtn.chambername=model.chambername;
    
    self.nameLab.text=model.chambername;
    [self.ima1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,model.image1]]];
    [self.ima2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,model.image2]]];
    [self.ima3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,model.image3]]];
    //改
    [self.iconView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,model.icon]]];
    
    
    self.obtainedLab.text=[NSString stringWithFormat:@"已售:%@",model.obtained];
    //一行时lab字体顶对齐
    //self.chamberjjLab.text=model.chamberjj;
    
    [self.upView setTitle:[NSString stringWithFormat:@"| 排名：%@",model.up] forState:UIControlStateNormal];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
