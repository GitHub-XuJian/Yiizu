//
//  HomeDetailCell.h
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeDetailScrollView;

@class CellBtn;

@class favoriteBtn;

@interface HomeDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet HomeDetailScrollView *homeScrollview;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *iconIma;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
//排名已售
@property (weak, nonatomic) IBOutlet UILabel *upLab;
//商户简介
@property (weak, nonatomic) IBOutlet UILabel *chamberjjLab;

@property (weak, nonatomic) IBOutlet CellBtn *likeBtn;
@property (weak, nonatomic) IBOutlet favoriteBtn *favBtn;

@end
