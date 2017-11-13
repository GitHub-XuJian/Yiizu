//
//  MembershipActivationCodeTableViewCell.h
//  yizu
//
//  Created by 徐健 on 17/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReloadBlock)();

@interface MembershipActivationCodeTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSString *buttonStr;
@property (nonatomic, strong) ReloadBlock block;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
