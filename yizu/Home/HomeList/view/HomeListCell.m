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
#import "CellBtn.h"
@interface HomeListCell ()
//点赞接口
@property(copy, nonatomic) NSString* upUrl;
//取消点赞接口
@property(copy, nonatomic) NSString* cancelUrl;



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








@end

@implementation HomeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
     //[self.likeCellBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}


- (IBAction)keepBtn:(UIButton *)sender
{
    
     sender.userInteractionEnabled = NO;
    if (sender.selected==NO) {
        sender.selected=YES;
        NSLog(@"收藏1");
        [UIView animateWithDuration:0.25 animations:^{
    
            sender.imageView.transform=CGAffineTransformMakeScale(1.5, 1.5);//宽高伸缩比例
        }];
        
    }else
    {
        sender.selected=NO;
         NSLog(@"收藏2");
        [UIView animateWithDuration:0.25 animations:^{
            sender.imageView.transform = CGAffineTransformIdentity;//变形后复原
            sender.userInteractionEnabled = YES;

        }];
    }
}




-(void)setModel:(HomeListModel *)model
{
    _model=model;
    //更改
    self.likeCellBtn.likeCount=model.upvote.integerValue;
    //NSLog(@"开始点赞%ld",(long)model.upvote.integerValue);
    //self.likeCellBtn.islike=model.status;
    //NSLog(@"开始点赞%@",model.status);
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
    }
    
    
    self.likeCellBtn.chambername=model.chambername;
    //self.likeCellBtn.chamber_id=model.chamber_id;
    
    self.nameLab.text=model.chambername;
    [self.ima1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/img/img/%@",Main_Server,model.image1]]];
    [self.ima2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/img/img/%@",Main_Server,model.image2]]];
    [self.ima3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/img/img/%@",Main_Server,model.image3]]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/img/img/%@",Main_Server,model.icon]]];
    
    
    self.obtainedLab.text=[NSString stringWithFormat:@"已售:%@",model.obtained];
    //self.chamberjjLab.text=model.chamberjj;
    
    
    [self.upView setTitle:[NSString stringWithFormat:@"| 排名：%@",model.up] forState:UIControlStateNormal];
    
    //self.upUrl=[NSString stringWithFormat:@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_upvoteAdd/name/%@/number/1/personid/%@",model.chambername,model.chamber_id];
    
    //self.cancelUrl=[NSString stringWithFormat:@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_upvoteAdd/name/%@/number/100/personid/%@",model.chambername,model.chamber_id];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
