//
//  CellBtn.m
//  yizu
//
//  Created by myMac on 2017/10/30.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CellBtn.h"
static NSString * const normalImageName = @"ic_common_praise_normal_15x15_";
static NSString * const pressedImageName = @"ic_common_praise_pressed_15x15_";
static NSString * const likeUrl = @"http://";
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
    self.islike = false;
    
    
}
- (void)like {
    
    NSLog(@"在里面的按钮方法");
    self.userInteractionEnabled = NO;
    
    self.islike = !self.islike;
    
    if (self.onClick) {
        self.onClick(self);
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.transform = CGAffineTransformIdentity;
            self.userInteractionEnabled = YES;
        }];
        
    }];
    //AFHTTPSessionManager *manager = [XAFNetWork managerWithBaseURL:nil sessionConfiguration:NO];
    //
    //    NSArray *parameter  = self.islike ? @[@"111",@"/like"] : @[@"222",@"/like?"];   //取消赞111,反则222
    //
    //    NSMutableString *newUrl = [likeUrl mutableCopy];
    //
    //    [newUrl appendFormat:@"/%@%@",self.requestID,parameter.lastObject];
    //
    //    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //    }];
}
//设置点赞图片
- (void)setIslike:(BOOL)islike {
    _islike = islike;
    //NSLog(@"当前状态%d",islike);
    int upCount = islike ? 1 : -1;
    
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
    [self setTitle:[NSString stringWithFormat:@"%ld",(long)likeCount] forState:UIControlStateNormal];
//    if (likeCount < 1) {
//
//        [self setTitle:nil forState:UIControlStateNormal];
//
//    }else {
//        [self setTitle:[NSString stringWithFormat:@"%ld",(long)likeCount] forState:UIControlStateNormal];
        //        NSString *title = [NSString makeTextWithCount:likeCount];
        //
        //        [self setTitle:title forState:UIControlStateNormal];
        //
        //        width = [title getTextWidthWithFont:self.titleLabel.font] + MyWidth;
        
    //}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
