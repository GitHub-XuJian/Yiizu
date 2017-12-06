
//
//  HomeListSorryCell.m
//  yizu
//
//  Created by myMac on 2017/12/3.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeListSorryCell.h"

@interface HomeListSorryCell ()



@end

@implementation HomeListSorryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.sorryIma=[[UIImageView alloc]init];
        self.sorryIma.image=[UIImage imageNamed:@"sorry"];
        [self.contentView addSubview:self.sorryIma];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat x=(kSCREEN_WIDTH-200)*0.5;
    
    self.sorryIma.frame=CGRectMake(x, 0, 200, 200);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
