//
//  ScrollImaView.m
//  yizu
//
//  Created by myMac on 2017/11/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ScrollImaView.h"

@interface ScrollImaView ()

@property (nonatomic, strong)UIImageView* imaView;

@end

@implementation ScrollImaView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        if (self) {
            
//            self.titleLable = [[UILabel alloc] init];
//            self.titleLable.textColor = [UIColor blackColor];
//            self.titleLable.font = [UIFont systemFontOfSize:10];
//            self.titleLable.textAlignment = NSTextAlignmentCenter;
//            //self.titleLable.backgroundColor=[UIColor yellowColor];
//            //[self addSubview:self.titleLable];
//            [self.contentView addSubview:self.titleLable];
//
            self.imaView=[[UIImageView alloc]init];
            //self.imaView.backgroundColor=[UIColor redColor];
            [self addSubview:self.imaView];
            
        }
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imaView.frame=self.frame;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
