//
//  MyCollectionTableViewCell.h
//  yizu
//
//  Created by 徐健 on 17/10/23.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionModel.h"
typedef void (^MyCollectionTableViewCellBlock)(MyCollectionModel *model);

@interface MyCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) MyCollectionTableViewCellBlock block;

-(void)initWithMyCollectionModel:(MyCollectionModel *)cellmyCollectionModel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
