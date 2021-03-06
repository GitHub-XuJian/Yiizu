//
//  HomeCategoryCell.m
//  yizu
//
//  Created by myMac on 2017/11/20.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeCategoryCell.h"
#import "HomeCategoryModel.h"


@interface HomeCategoryCell ()

@property (nonatomic, strong) UILabel* titleLable;

@property (nonatomic, strong) UIImageView* imaView;


@end

@implementation HomeCategoryCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        if (self) {
            
            self.titleLable = [[UILabel alloc] init];
            self.titleLable.textColor = [UIColor blackColor];
            self.titleLable.font = [UIFont systemFontOfSize:10];
            self.titleLable.textAlignment = NSTextAlignmentCenter;
            //self.titleLable.backgroundColor=[UIColor yellowColor];
            //[self addSubview:self.titleLable];
            [self.contentView addSubview:self.titleLable];
            
            self.imaView=[[UIImageView alloc]init];
            self.imaView.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:self.imaView];
            
        }
    }
    
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    
    self.imaView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20);
    
    self.titleLable.frame = CGRectMake(-10, CGRectGetMaxY(self.imaView.frame), self.frame.size.width+20, self.frame.size.height-self.imaView.frame.size.height);
    
}


- (void)setModel:(HomeCategoryModel *)model
{
    _model=model;
    
    self.titleLable.text=model.tradename;
   
    
    [self.imaView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,model.icon]]];
}

@end
