//
//  PersonalInformationTableViewCell.m
//  yizu
//
//  Created by 徐健 on 2017/11/16.
//  Copyright © 2017年 XuJian. All rights reserved.
//
#define NametextFieldTag   19999999
#define SignatureFieldTag   19999993


#import "PersonalInformationTableViewCell.h"
@interface PersonalInformationTableViewCell()<UITextFieldDelegate>
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
        lineview.frame = CGRectMake(0, indexPath.row==0?80:60, kSCREEN_WIDTH, 0.5);
        [self.contentView addSubview:lineview];
        self.lineView = lineview;
        
        switch (indexPath.row) {
            case 0:{
                UIImageView *imageView = [[UIImageView alloc] init];
                imageView.frame = CGRectMake(kSCREEN_WIDTH-47/3-60, 10, 60, 60);
                //设置圆角
                imageView.layer.cornerRadius = imageView.frame.size.width / 2;
                //将多余的部分切掉
                imageView.layer.masksToBounds = YES;
                [self.contentView addSubview:imageView];
                self.iconImageView = imageView;
                break;
            }
            case 1:{
                UITextField *nameTextField = [[UITextField alloc] init];
                nameTextField.delegate = self;
                nameTextField.frame = CGRectMake(nameLabel.x+nameLabel.width+20, 0, kSCREEN_WIDTH-(nameLabel.x+nameLabel.width+20)-20, 60);
                nameTextField.tag = NametextFieldTag;
                nameTextField.text = [XSaverTool objectForKey:Nickname];
                nameTextField.textAlignment = NSTextAlignmentRight;
                nameTextField.placeholder = @"还未填写昵称，请尽快填写";
                [self.contentView addSubview:nameTextField];
                self.nameTextField = nameTextField;
                break;
            }
            case 2:{
                
                UILabel *sexLabel = [[UILabel alloc] init];
                sexLabel.frame = CGRectMake(kSCREEN_WIDTH-80, 0, 70, 60);
                sexLabel.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:sexLabel];
                self.sexLabel = sexLabel;
                break;
            }
            
            case 3:{
                UITextField *signatureTextField = [[UITextField alloc] init];
                signatureTextField.delegate = self;
                signatureTextField.frame = CGRectMake(nameLabel.x+nameLabel.width+20, 0, kSCREEN_WIDTH-(nameLabel.x+nameLabel.width+20)-20, 60);
                signatureTextField.textAlignment = NSTextAlignmentRight;
                signatureTextField.text = [XSaverTool objectForKey:Personxq];
                signatureTextField.tag = SignatureFieldTag;
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
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@public/%@",Main_ServerImage,[XSaverTool objectForKey:UserIconImage]]] placeholderImage:[UIImage imageNamed:@"icon_default_avatar"]];

    if ([[XSaverTool objectForKey:Sex] isEqualToString:@"1"]) {
        self.sexLabel.text = @"男";
    }else{
        self.sexLabel.text = @"女";
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[XSaverTool objectForKey:UserIDKey] forKey:@"personid"];
    NSString *keyStr;
    switch (textField.tag) {
        case NametextFieldTag:{
            [dict setValue:textField.text forKey:@"nickname"];
            keyStr = Nickname;
            break;
        }
        case SignatureFieldTag:{
            [dict setValue:textField.text forKey:@"personxq"];
            keyStr = Personxq;
            break;
        }
        default:
            break;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@Mobile/Mine/modifydata",Main_Server];
    [XAFNetWork GET:urlStr params:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue]) {
            [XSaverTool setObject:textField.text forKey:keyStr];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
