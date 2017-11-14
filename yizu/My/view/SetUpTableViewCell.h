//
//  SetUpTableViewCell.h
//  yizu
//
//  Created by 徐健 on 2017/11/13.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetUpTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *titleStr;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath;

@end
