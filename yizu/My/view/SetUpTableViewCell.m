//
//  SetUpTableViewCell.m
//  yizu
//
//  Created by 徐健 on 2017/11/13.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#define NameTextfieldTag  112211


#import "SetUpTableViewCell.h"
@interface SetUpTableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *cacheLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UITextField *nameTextField;

@end
@implementation SetUpTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andIndexPath:(NSIndexPath *)indexPath;
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = kFontBodyTitle;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:label];
            self.cacheLabel =label;
        }else{
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    UILabel *rightLabel = [[UILabel alloc] init];
                    rightLabel.textAlignment = NSTextAlignmentRight;
                    [self.contentView addSubview:rightLabel];
                    self.rightLabel = rightLabel;
                }
                
                if (indexPath.row == 1) {
                    UITextField *textfield = [[UITextField alloc] init];
                    textfield.frame = CGRectMake(kSCREEN_WIDTH-kSCREEN_WIDTH/2-30, 0, kSCREEN_WIDTH/2, 60);
                    textfield.textAlignment = NSTextAlignmentRight;
                    textfield.delegate = self;
                    textfield.tag = NameTextfieldTag;
                    textfield.placeholder = @"请输入真实姓名";
                    [self.contentView addSubview:textfield];
                    self.nameTextField = textfield;
                }
            }
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightImage"]];
            if ((indexPath.section == 1 && indexPath.row == 2)||(indexPath.section == 0&& indexPath.row == 1)) {
                imageView.hidden = YES;
            }
            imageView.contentMode  = UIViewContentModeScaleAspectFit;
            imageView.frame = CGRectMake(kSCREEN_WIDTH-30, 60/2-20/2, 20, 20);
            [self.contentView addSubview:imageView];
        }
        
    }
    return self;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[XSaverTool objectForKey:UserIDKey] forKey:@"personid"];
    switch (textField.tag) {
        case NameTextfieldTag:{
            [dict setValue:textField.text forKey:@"pername"];
            break;
        }
        default:
            break;
    }
    _block(dict);
}
- (void)setCellDict:(NSDictionary *)cellDict
{
    _cellDict = cellDict;
    if ([cellDict[@"pername"] length]) {
        self.nameTextField.text = cellDict[@"pername"];
        self.nameTextField.enabled = NO;
    }
}
- (void)setRightLabelStr:(NSString *)rightLabelStr
{
    self.rightLabel.frame = CGRectMake(kSCREEN_WIDTH-kSCREEN_WIDTH/2-30, 0, kSCREEN_WIDTH/2, 60);
    self.rightLabel.text = rightLabelStr;
}
- (void)setTitleStr:(NSString *)titleStr
{
    self.nameLabel.text = titleStr;
    self.nameLabel.frame = CGRectMake(20, 0, kSCREEN_WIDTH-10, 60);
    /**
     * 计算缓存
     */
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    double displaySize = size/ 1000.0 /1000.0;
    DLog(@"%.2f-------",displaySize);
    self.cacheLabel.text = [NSString stringWithFormat:@"%.2f M",displaySize];
    self.cacheLabel.frame = CGRectMake(kSCREEN_WIDTH-120, 0, 100, 60);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
