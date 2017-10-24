//
//  MyCollectionTableViewCell.h
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *addressStr;
@property (nonatomic, strong) NSString *timeStr;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
