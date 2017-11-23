//
//  MallTransactionRecordsTableViewCell.h
//  yizu
//
//  Created by 徐健 on 2017/11/21.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MallTransactionRecordsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dictCell;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
