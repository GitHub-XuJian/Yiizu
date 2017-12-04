
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

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        if (self) {
            
            self.imaView=[[UIImageView alloc]init];
            
            self.imaView.image=[UIImage imageNamed:@"sorry"];
            
            [self.contentView addSubview:self.imaView];
        }
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imaView.frame=self.bounds;
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
