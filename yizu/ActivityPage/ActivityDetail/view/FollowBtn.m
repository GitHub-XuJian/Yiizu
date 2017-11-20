//
//  FollowBtn.m
//  yizu
//
//  Created by myMac on 2017/11/17.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "FollowBtn.h"

static NSString * const normalImageName = @"ic_details_top_collection_normal_21x21_";
static NSString * const pressedImageName = @"ic_details_top_collection_prressed_21x21_";

@implementation FollowBtn


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
- (void)setup {
    
    [self addTarget:self action:@selector(follow) forControlEvents:UIControlEventTouchUpInside];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];//设置文字位置
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];//设置文字位置
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0,8, 0, 0)];
    
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    
}

- (void)follow {
    
    self.userInteractionEnabled = NO;
    
    self.isFollow = !self.isFollow;
    
    NSString* isGuan=@"";
    
    if (self.isFollow) {
        self.followCount=self.followCount+1;
        isGuan=@"1";
        
    }else
    {
        self.followCount=self.followCount-1;
        isGuan=@"2";
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.imageView.transform = CGAffineTransformMakeScale(1.7, 1.7);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
            self.userInteractionEnabled = YES;
        }];
        
    }];
    
    //http://47.104.18.18/index.php/Mobile/Bridge/attention/activityid/%@/personid/%@/number/%@
    
    NSString *newUrl = [NSString stringWithFormat:@"%@Mobile/Bridge/attention/activityid/%@/personid/%@/number/%@",Main_Server,self.activityid,isGuan,@"3"];
    
    
    newUrl = [newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [XAFNetWork GET:newUrl params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


//设置点赞图片
- (void)setIsFollow:(BOOL)isFollow
{
    _isFollow = isFollow;
   
    NSString *imageName = self.isFollow ? pressedImageName : normalImageName;
    
    [self setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    UIColor *textColor = self.isFollow ? [UIColor redColor] : [UIColor lightGrayColor];
    
    [self setTitleColor:textColor forState:UIControlStateNormal];
    
}
//设置点赞数
- (void)setFollowCount:(NSInteger)followCount
{
    _followCount = followCount;
    

    
//    if (followCount < 1) {
//
//        [self setTitle:nil forState:UIControlStateNormal];
//
//    }else {
        [self setTitle:[NSString stringWithFormat:@"%ld",(long)followCount] forState:UIControlStateNormal];
        
        
   // }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
