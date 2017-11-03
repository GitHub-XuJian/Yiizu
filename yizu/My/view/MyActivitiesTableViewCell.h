//
//  MyActivitiesTableViewCell.h
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyActivitiesModel.h"

@interface MyActivitiesTableViewCell : UITableViewCell

-(void)initWithMyActivitiesModel:(MyActivitiesModel *)activitiesModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
