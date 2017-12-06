//
//  HomeDetailImaView.m
//  yizu
//
//  Created by 李大霖 on 2017/12/4.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeDetailImaView.h"

@implementation HomeDetailImaView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        if (self) {
            
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
     DLog(@"点击事件");
    

    if ([self.delegate respondsToSelector:@selector(ImaViewima:)]) {
        DLog(@"响应");
        [self.delegate ImaViewima:self];
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
