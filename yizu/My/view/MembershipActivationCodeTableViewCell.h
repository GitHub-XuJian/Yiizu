//
//  MembershipActivationCodeTableViewCell.h
//  yizu
//
//  Created by 徐健 on 17/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MembershipActivationCodeTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *nameStr;
@property (nonatomic, strong) NSString *buttonStr;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
