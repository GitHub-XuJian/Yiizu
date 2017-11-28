//
//  favoriteBtn.m
//  yizu
//
//  Created by myMac on 2017/11/16.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "favoriteBtn.h"

static NSString * const sNormal = @"ic_me_item_collection_topic_20x20_";
static NSString * const sPressed = @"ic_details_top_collection_prressed_21x21_";

@implementation favoriteBtn


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
    
    [self addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];//设置文字位置
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];//设置文字位置
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0,8, 0, 0)];
    
    self.titleLabel.font = [UIFont systemFontOfSize:10];
    
}
- (void)like {
    
    if (!IsLoginState) {
        NSLog(@"没登录");
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"游客未登录" message:@"是否登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }else{
    
      NSLog(@"登录le");
    //self.userInteractionEnabled = NO;
    
    self.issc = !self.issc;
    
    NSString* isCang=@"";
    
    if (self.issc) {
        isCang=@"1";
    }else
    {
        isCang=@"2";
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
            self.userInteractionEnabled = YES;
        }];
        
    }];
    //Mobile/Index/index_keep/name/%@/number/%@/%@
    
    NSString *newUrl = [NSString stringWithFormat:@"%@Mobile/Index/index_keep/name/%@/number/%@/personid/%@",Main_Server,self.chambername,isCang,[XSaverTool objectForKey:UserIDKey]];
    
    
    newUrl = [newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [XAFNetWork GET:newUrl params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"shouchang==%@",responseObject);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    }
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {}

//设置点赞图片
- (void)setIssc:(BOOL)issc
{
    _issc = issc;
    NSString *imageName = self.issc ? sPressed : sNormal;
    
   
    
    [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
