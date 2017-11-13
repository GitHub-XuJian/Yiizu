//
//  PWCustomSheet.m
//  自定义Sheet
//
//  Created by Oriental on 17/1/16.
//  Copyright © 2017年 Oriental Horizon. All rights reserved.
//

#import "PWCustomSheet.h"

@interface PWCustomSheet ()

@property (nonatomic,strong) UIView * contentView;

@end

@implementation PWCustomSheet

static NSArray * allbus = nil;

-(PWCustomSheet*)initWithButtons:(NSArray*)allButtons
{
    allbus = allButtons;
    PWCustomSheet * sheet = [[PWCustomSheet alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [sheet set];
    return sheet;
}

-(void)set
{
    [UIView animateWithDuration:0.3 animations:^{
        _contentView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44*(allbus.count + 1) -10, [UIScreen mainScreen].bounds.size.width, 44*(allbus.count + 1 )+10);
    }];
    
}
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        back.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapGesture)];
        [back addGestureRecognizer:tap];
        
        [self addSubview:back];
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height,  [UIScreen mainScreen].bounds.size.width,44*allbus.count)];
//        _contentView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_contentView];
        
        for (int i = 0; i<allbus.count; i++)
        {
            UIButton * bu = [UIButton buttonWithType:UIButtonTypeCustom];
            bu.tag = i;
            bu.backgroundColor = [UIColor whiteColor];
            bu.frame = CGRectMake(0, 44*i, [UIScreen mainScreen].bounds.size.width, 44);
            [_contentView addSubview:bu];
            [bu setTitle:allbus[i] forState:UIControlStateNormal];
            [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [bu addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1)];
            line.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
            [bu addSubview:line];
        }

        UIView *bView = [[UIView alloc]initWithFrame:CGRectMake(0, 44*allbus.count,[UIScreen mainScreen].bounds.size.width, 10)];
        bView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        [_contentView addSubview:bView];
        
        UIButton *cancalBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bView.frame), [UIScreen mainScreen].bounds.size.width, 44)];
        [cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [cancalBtn setImage:[UIImage imageNamed:@"Cancel"] forState:UIControlStateNormal];
        cancalBtn.backgroundColor = [UIColor whiteColor];
        [cancalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancalBtn addTarget:self action:@selector(TapGesture) forControlEvents:UIControlEventTouchUpInside];
//        [cancalBtn setBackgroundColor:[UIColor redColor]];
        [_contentView addSubview:cancalBtn];
        

    }
    return self;

}

-(void)TapGesture
{
    [self removeFromSuperview];
}
-(void)clickButton:(UIButton*)button
{
    [self.delegate  clickButton:button];
    
    [self removeFromSuperview];
}


@end
