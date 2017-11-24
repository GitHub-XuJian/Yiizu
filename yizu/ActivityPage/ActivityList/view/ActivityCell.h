//
//  ActivityCell.h
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActivityLsitModel;
@class CustomCellScrollView;
@interface ActivityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CustomCellScrollView *customScroll;
@property(nonatomic, strong)ActivityLsitModel* model;

@end
