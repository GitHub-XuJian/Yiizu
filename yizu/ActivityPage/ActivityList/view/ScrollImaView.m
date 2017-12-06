//
//  ScrollImaView.m
//  yizu
//
//  Created by myMac on 2017/11/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ScrollImaView.h"

@interface ScrollImaView ()

//@property (nonatomic, strong)UIImage* ima;

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
            //self.ima=[[UIImage alloc]init];
       
            self.userInteractionEnabled=YES;
            UITapGestureRecognizer* imaTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imaViewClike)];
            imaTap.numberOfTapsRequired = 1;
            [self addGestureRecognizer:imaTap];
            
        }
    }
    
    return self;
}


- (void)imaViewClike
{
    
    DLog(@"点击事件=%@",self.activityid);
    if ([self.delegate respondsToSelector:@selector(ImaViewActid:)]) {
        DLog(@"响应%@",self.activityid);
        [self.delegate ImaViewActid :self.activityid];
    }else
    {
        DLog(@"没响应");
    }
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
