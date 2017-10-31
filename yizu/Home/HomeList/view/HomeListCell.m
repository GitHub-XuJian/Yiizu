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
#import "XAFNetWork.h"
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
     [self.likeCellBtn addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}
- (void)like
{
    //    NSLog(@"点%d",self.isUp);
    //    if (self.isUp ==NO) {
    //        [XAFNetWork GET:self.upUrl params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    //
    //            int ivalue = [self.numberUp intValue];
    //            ivalue++;
    //             self.upvoteLab.text=[NSString stringWithFormat:@"(%d)",ivalue];
    //                    NSLog(@"点赞%@",responseObject);
    //                    NSString* str=responseObject[@"diancuole"];
    //            if ([str isEqualToString:@"already"]) {
    //
    //            }
    //        } fail:^(NSURLSessionDataTask *task, NSError *error) {
    //
    //        }];
    //        self.isUp=YES;
    //
    //    }else
    //    {
    //
    //        [XAFNetWork GET:self.cancelUrl params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    //            NSLog(@"取消%@",responseObject);
    //        } fail:^(NSURLSessionDataTask *task, NSError *error) {
    //
    //        }];
    //        self.isUp=NO;
    //    }
}

- (IBAction)keepBtn:(UIButton *)sender
{
    if (sender.selected==NO) {
        sender.selected=YES;
        NSLog(@"收藏1");
    }else
    {
        sender.selected=NO;
         NSLog(@"收藏2");
    }
}




-(void)setModel:(HomeListModel *)model
{
    _model=model;
    //更改
    self.likeCellBtn.likeCount=model.upvote.integerValue;
    //NSLog(@"开始点赞%ld",(long)model.upvote.integerValue);
    self.likeCellBtn.islike=model.status;
    //NSLog(@"开始状态%@",model.status);
    
    self.nameLab.text=model.chambername;
    [self.ima1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.207.158.228/yizu/Public/img/img/%@",model.image1]]];
    [self.ima2 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.207.158.228/yizu/Public/img/img/%@",model.image2]]];
    [self.ima3 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://123.207.158.228/yizu/Public/img/img/%@",model.image3]]];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    
    self.obtainedLab.text=[NSString stringWithFormat:@"已售:%@",model.obtained];
    //self.chamberjjLab.text=model.chamberjj;
    
    
    [self.upView setTitle:[NSString stringWithFormat:@"| 排名：%@",model.up] forState:UIControlStateNormal];
    
    self.upUrl=[NSString stringWithFormat:@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_upvoteAdd/name/%@/number/1/personid/%@",model.chambername,model.chamber_id];
    
    self.cancelUrl=[NSString stringWithFormat:@"http://123.207.158.228/yizu/index.php/Mobile/Index/index_upvoteAdd/name/%@/number/100/personid/%@",model.chambername,model.chamber_id];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
