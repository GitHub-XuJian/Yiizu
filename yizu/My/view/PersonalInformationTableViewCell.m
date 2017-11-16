//
//  PersonalInformationTableViewCell.m
//  yizu
//
//  Created by 徐健 on 2017/11/16.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "PersonalInformationTableViewCell.h"
@interface PersonalInformationTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UILabel *sexLabel;
@property (nonatomic, strong) UILabel *realNameLabel;
@property (nonatomic, strong) UITextField *signatureTextField;
@property (nonatomic, strong) UIView *lineView;
@end
@implementation PersonalInformationTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kFontBodyTitle;
        nameLabel.textAlignment =NSTextAlignmentCenter;
        nameLabel.frame = CGRectMake(10, 0, 80, indexPath.row==0?80:60);
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel *lineview = [[UILabel alloc] init];
        lineview.backgroundColor = kColorLine;
        lineview.frame = CGRectMake(0, 0, kSCREEN_WIDTH, indexPath.row==0?80:60);
        [self.contentView addSubview:lineview];
        self.lineView = lineview;
        
        switch (indexPath.row) {
            case 0:{
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.frame = CGRectMake(kSCREEN_WIDTH-47/3-60, 10, 60, 60);
                //设置圆角
                imageView.layer.cornerRadius = imageView.frame.size.width / 2;
                imageView.backgroundColor = [UIColor redColor];
                //将多余的部分切掉
                imageView.layer.masksToBounds = YES;
                [self.contentView addSubview:imageView];
                self.iconImageView = imageView;
                break;
            }
            case 1:{
                UITextField *nameTextField = [[UITextField alloc] init];
                nameTextField.frame = CGRectMake(nameLabel.x+nameLabel.width+20, 0, kSCREEN_WIDTH-(nameLabel.x+nameLabel.width+20), 60);
                nameTextField.placeholder = @"还未填写昵称，请尽快填写";
                [self.contentView addSubview:nameTextField];
                self.nameTextField = nameTextField;
                break;
            }
            case 2:{
                UILabel *sexLabel = [[UILabel alloc] init];
                sexLabel.frame = CGRectMake(kSCREEN_WIDTH-80, 0, 70, 60);
                sexLabel.backgroundColor = [UIColor redColor];
                [self.contentView addSubview:sexLabel];
                self.sexLabel = sexLabel;
                break;
            }
            case 3:{
                UILabel *realNameLabel = [[UILabel alloc] init];
                realNameLabel.frame = CGRectMake(kSCREEN_WIDTH-80, 0, 70, 60);
                realNameLabel.backgroundColor = [UIColor yellowColor];
                [self.contentView addSubview:realNameLabel];
                self.realNameLabel = realNameLabel;
                break;
            }
            case 4:{
                UITextField *signatureTextField = [[UITextField alloc] init];
                signatureTextField.frame = CGRectMake(nameLabel.x+nameLabel.width+20, 0, kSCREEN_WIDTH-(nameLabel.x+nameLabel.width+20), 60);
                signatureTextField.placeholder = @"人生伟业的建立。不在能知，乃在能行";
                [self.contentView addSubview:signatureTextField];
                self.signatureTextField = signatureTextField;
                break;
            }
            default:
                break;
        }
        
    }
    return self;
}
- (void)setLeftNameStr:(NSString *)leftNameStr
{
    self.nameLabel.text = leftNameStr;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
