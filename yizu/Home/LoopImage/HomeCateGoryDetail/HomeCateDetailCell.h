//
//  HomeCateDetailCell.h
//  yizu
//
//  Created by myMac on 2017/11/21.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HomeListModel;
@class CellBtn;
@class favoriteBtn;

@interface HomeCateDetailCell : UITableViewCell

@property (nonatomic, strong) HomeListModel* model;
@property (weak, nonatomic) IBOutlet CellBtn *likeBtn;
@property (weak, nonatomic) IBOutlet favoriteBtn *favBtn;

@end
