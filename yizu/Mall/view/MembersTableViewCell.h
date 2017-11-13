//
//  MembersTableViewCell.h
//  yizu
//
//  Created by 徐健 on 2017/11/10.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MembersTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *cellDict;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
