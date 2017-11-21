//
//  HeadCityBtnReusableView.m
//  yizu
//
//  Created by myMac on 2017/11/18.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HeadCityBtnReusableView.h"
#import "CityListModel.h"



@interface HeadCityBtnReusableView ()

@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIButton * btn;


@end


@implementation HeadCityBtnReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        if (self) {
           
//            self.titleLable = [[UILabel alloc] init];
//            self.titleLable.textColor = [UIColor blackColor];
//            self.titleLable.font = [UIFont systemFontOfSize:20];
//            self.titleLable.textAlignment = NSTextAlignmentCenter;
//            //self.titleLable.textAlignment = NSTextAlignmentLeft;
//            self.titleLable.userInteractionEnabled=YES;
//            UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labClickBtn)];
//            [self.titleLable addGestureRecognizer:tap];
//            [self addSubview:self.titleLable];
            self.btn=[[UIButton alloc]init];
            self.btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
            [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.btn.contentEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0);
            self.btn.titleEdgeInsets=UIEdgeInsetsMake(0, 20, 0, 0);
            [self.btn setImage:[UIImage imageNamed:@"icon_comment_more_s"] forState:UIControlStateNormal];
            [self.btn addTarget:self action:@selector(labClickBtn) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.btn];
            
        }
        
    }
    
    return self;
}


 - (void)labClickBtn
{
    self.model.visible=!self.model.isVisible;
    
    //刷新表格重新加载数据源方法
    //用代理实现
    if ([self.delegate respondsToSelector:@selector(HeadClickBtn:)]) {
        [self.delegate HeadClickBtn:self];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //self.titleLable.frame = self.bounds;
    self.btn.frame=self.bounds;
}

- (void)setTitleName:(NSString *)titleName {
    
    _titleName = titleName;
    
    //self.titleLable.text = titleName;
    [self.btn setTitle:titleName forState:UIControlStateNormal];
    
}

- (void)setModel:(CityListModel *)model
{
    _model=model;
    
    if (self.model.visible) {
        self.btn.imageView.transform=CGAffineTransformMakeRotation(M_PI_2);
    }else
    {
        self.btn.imageView.transform=CGAffineTransformMakeRotation(0);
    }
}

@end
