//
//  SetUpTableViewCell.m
//  yizu
//
//  Created by 徐健 on 2017/11/13.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "SetUpTableViewCell.h"
@interface SetUpTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *cacheLabel;
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
        
        if (indexPath.section == 1 && indexPath.row == 2) {
            UILabel *label = [[UILabel alloc] init];
            [self.contentView addSubview:label];
            self.cacheLabel =label;
        }else{
            if (indexPath.section == 0) {
                UILabel *rightLabel = [[UILabel alloc] init];
                rightLabel.frame = CGRectMake(kSCREEN_WIDTH-90, 0, 60, 60);
                rightLabel.text = @"未绑定";
                [self.contentView addSubview:rightLabel];
            }
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_details_top_collection_prressed_21x21_"]];
            if (indexPath.section == 1 && indexPath.row == 2) {
                imageView.hidden = YES;
            }
            imageView.frame = CGRectMake(kSCREEN_WIDTH-30, 60/2-20/2, 20, 20);
            [self.contentView addSubview:imageView];
        }
        
    }
    return self;
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
    NSLog(@"%.2f-------",displaySize);
    self.cacheLabel.text = [NSString stringWithFormat:@"%.2f M",displaySize];
    self.cacheLabel.frame = CGRectMake(kSCREEN_WIDTH-60, 0, 60, 60);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
