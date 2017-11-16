//
//  PersonalInformationTableViewCell.h
//  yizu
//
//  Created by 徐健 on 2017/11/16.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInformationTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *leftNameStr;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath;
@end
