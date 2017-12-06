//
//  RankingView.m
//  yizu
//
//  Created by 徐健 on 2017/11/7.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "RankingView.h"

@implementation RankingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.70f green:0.13f blue:0.35f alpha:1.00f];
        //设置圆角
        self.layer.cornerRadius = 10;
        //将多余的部分切掉
        self.layer.masksToBounds = YES;
        
        [self createUIView];
    }
    return self;
}
- (void)createUIView
{
    
}
- (void)reloadRanking:(NSArray *)rankingArray
{
    for (int i = 0; i < rankingArray.count; i++) {
        NSDictionary *dict = rankingArray[i];
        UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"di%d",i+1]]];
        if (i == 0) {
            imageView1.frame = XCGRectMake(self.width/2-288/3/2, self.height/4*3-355/3, 288/3, 355/3);
        }else if(i == 1){
            imageView1.frame = XCGRectMake(self.width/4-185/3/2, self.height/4*3-223/3,185/3, 223/3);
        }else if(i == 2){
            imageView1.frame = XCGRectMake(self.width/2+self.width/4-185/3/2, self.height/4*3-223/3,185/3, 223/3);
        }
        [self addSubview:imageView1];
        
//        UIImageView *iconImage = [[UIImageView alloc] init];
//        iconImage.frame = XCGRectMake(0, 0, imageView1.width, imageView1.height);
//        [iconImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Main_ServerImage,dict[@"headpic"]]] placeholderImage:[UIImage imageNamed:@"iconRegistered"]];
//        //设置圆角
//        iconImage.layer.cornerRadius = imageView1.height/2;
//        //将多余的部分切掉
//        iconImage.layer.masksToBounds = YES;
//        [imageView1 addSubview:iconImage];
        UILabel *label1 = [[UILabel alloc] init];
        label1.frame = XCGRectMake(imageView1.x-5, imageView1.y+imageView1.height+5, imageView1.width+5, 20);
        label1.text = dict[@"pername"];
        label1.font = kFontOther;
        label1.textAlignment =NSTextAlignmentCenter;
        label1.textColor = [UIColor whiteColor];
        [self addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.frame = XCGRectMake(imageView1.x-5, label1.y+label1.height+5, imageView1.width+5, 20);
        label2.text = [NSString stringWithFormat:@"￥%@", dict[@"payzong"]];
        label2.font = kFontOther;
        label2.textAlignment =NSTextAlignmentCenter;
        label2.textColor = [UIColor whiteColor];
        [self addSubview:label2];
    }
}
@end
