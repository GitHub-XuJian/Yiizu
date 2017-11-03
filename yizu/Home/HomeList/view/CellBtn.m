//
//  CellBtn.m
//  yizu
//
//  Created by myMac on 2017/10/30.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CellBtn.h"
#import "XAFNetWork.h"

static NSString * const normalImageName = @"ic_common_praise_normal_15x15_";
static NSString * const pressedImageName = @"ic_common_praise_pressed_15x15_";

@implementation CellBtn

+ (instancetype)likeCountViewWithCount:(NSInteger)count requestID:(NSString *)ID {
    
    CellBtn *like = [[CellBtn alloc] init];
    like.likeCount = count;
    like.requestID = ID;
    
    return like;
}
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
    
    //NSLog(@"%d",self.islike);
    
    /////////
    //self.islike = NO;
    
    
}
- (void)like {
    
 
    self.userInteractionEnabled = NO;
    
    self.islike = !self.islike;
    
    if (self.onClick) {
        self.onClick(self);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.imageView.transform = CGAffineTransformMakeScale(1.7, 1.7);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
            self.userInteractionEnabled = YES;
        }];
        
    }];
    
    NSString *isZan  = self.islike ? @"1" : @"2";  //取消赞2,反则1
       NSLog(@"在里面的按钮方法%@",isZan);
    NSString *newUrl = [NSString stringWithFormat:@"%@Mobile/Index/index_upvoteAdd/name/%@/number/%@/personid/%@",Main_Server,self.chambername,isZan,@"3"];
    NSLog(@"点赞jie口:%@",newUrl);
   newUrl = [newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [XAFNetWork GET:newUrl params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"dianzan"] isEqualToString:@"success"]) {
            NSLog(@"点赞成功%@",responseObject[@"dianzan"]);
        }else if ([[responseObject objectForKey:@"dianzan"] isEqualToString:@"failed"])
        {
            NSLog(@"取消点赞%@",responseObject[@"dianzan"]);
        }else if ([[responseObject objectForKey:@"dianzan"] isEqualToString:@"already"])
        {
            NSLog(@"已经点赞%@",responseObject[@"dianzan"]);
        }

    } fail:^(NSURLSessionDataTask *task, NSError *error) {

    }];
    
}
//设置点赞图片
- (void)setIslike:(BOOL)islike {
    _islike = islike;
   
    int upCount = islike ? 1 : -1;
    // NSLog(@"当前状态%d==%d",islike,upCount);
    self.likeCount = self.likeCount + upCount;
    
    NSString *imageName = self.islike ? pressedImageName : normalImageName;
    
    [self setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    UIColor *textColor = self.islike ? [UIColor redColor] : [UIColor lightGrayColor];
    
    [self setTitleColor:textColor forState:UIControlStateNormal];
    
}
//设置点赞数
- (void)setLikeCount:(NSInteger)likeCount {
    _likeCount = likeCount;
#define MyWidth 30.0f
    //CGFloat width = MyWidth;
    
    //NSLog(@"点赞数set方法%ld",(long)likeCount);
    
    if (likeCount < 1) {

        [self setTitle:nil forState:UIControlStateNormal];

    }else {
        [self setTitle:[NSString stringWithFormat:@"%ld",(long)likeCount-1] forState:UIControlStateNormal];
        
        
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
