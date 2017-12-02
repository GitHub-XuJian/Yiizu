//
//  HomeListCell.h
//  yizu
//
//  Created by myMac on 2017/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CellBtn;

@class HomeListModel;
@interface HomeListCell : UITableViewCell

//点赞
@property (weak, nonatomic) IBOutlet CellBtn *likeCellBtn;

@property(nonatomic,strong)HomeListModel * model;



@end
