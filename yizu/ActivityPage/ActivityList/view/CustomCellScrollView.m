//
//  CustomCellScrollView.m
//  yizu
//
//  Created by myMac on 2017/11/9.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CustomCellScrollView.h"

@implementation CustomCellScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}


- (void)awakeFromNib {
    
    [self setup];
    
}

- (void)setup
{
    self.showsHorizontalScrollIndicator=NO;
    self.bounces=NO;
   
    self.contentSize=CGSizeMake(kSCREEN_WIDTH/2*4+50, 0);
    for (int i=0; i<4; i++) {
        UIImageView* imaView=[[UIImageView alloc]init];
        imaView.layer.cornerRadius = 10;
    
        imaView.layer.masksToBounds=YES;
        imaView.backgroundColor=[UIColor redColor];
        imaView.frame=CGRectMake(10+i*(kSCREEN_WIDTH/2+10), 0, kSCREEN_WIDTH/2, self.frame.size.height);
        [self addSubview:imaView];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
