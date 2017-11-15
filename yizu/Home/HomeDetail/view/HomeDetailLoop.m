//
//  HomeDetailLoop.m
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeDetailLoop.h"
#import "SDCycleScrollView.h"

@interface HomeDetailLoop ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)SDCycleScrollView* SDScrollView;
@property (nonatomic, strong)NSMutableArray * imaUrlArr;

@end

@implementation HomeDetailLoop

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSMutableArray *)imaUrlArr
{
    if (_imaUrlArr==nil) {
        _imaUrlArr=[NSMutableArray array];
    }
   return  _imaUrlArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame: frame]) {
        
        [self initCycleScrollView];
        
    }
    return self;
}


- (void)initCycleScrollView
{
    
//    NSMutableArray *imageArray = [NSMutableArray array];
//
//    for ( int i = 1 ; i <= 4; i ++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
//        [imageArray addObject:image];
//    }

    self.SDScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 200) delegate:self placeholderImage:nil];
    //self.SDScrollView.imageURLStringsGroup=self.imaUrlArr;
    self.SDScrollView.autoScrollTimeInterval=2.0;
    self.SDScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    [self addSubview:self.SDScrollView];
}

- (void)setIma1:(NSString *)ima1
{
    _ima1=ima1;
    [_imaUrlArr addObject:ima1];
    //NSLog(@"loopURL===%@",ima1);

}

- (void)setIma2:(NSString *)ima2
{
    _ima2=ima2;
    [_imaUrlArr addObject:ima2];
}
- (void)setIma3:(NSString *)ima3
{
    _ima3=ima3;
    [_imaUrlArr addObject:ima3];
    self.SDScrollView.imageURLStringsGroup=self.imaUrlArr;
}
@end
