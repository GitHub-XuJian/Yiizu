//
//  ActivityDetailLoopView.m
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityDetailLoopView.h"
#import "SDCycleScrollView.h"
#import "ActivityDetailLabmodel.h"

@interface ActivityDetailLoopView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong)NSMutableArray * imaArr;
@property (nonatomic, strong)SDCycleScrollView* SDScrollView;

@end

@implementation ActivityDetailLoopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame: frame]) {
        
        _imaArr=[[NSMutableArray alloc]init];
        [self loadData];
        
    }
    return self;
}
//轮播
- (void)loadData
{

    [XAFNetWork GET:@"http://www.xdfishing.cn/index.php/Mobile/Bridge/Bridgeround/" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        for (NSDictionary* dic in responseObject) {
            NSString* imaUrl=[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,dic[@"picnpath"]];
            [_imaArr addObject:imaUrl];
        }
        
        [self initCycleScrollView];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)initCycleScrollView
{
    self.SDScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 220) delegate:self placeholderImage:nil];
    self.SDScrollView.imageURLStringsGroup=_imaArr;
    self.SDScrollView.autoScrollTimeInterval=2.0;
    self.SDScrollView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    [self addSubview:self.SDScrollView];
    
    
    NSString* str=[NSString stringWithFormat:@"%@Mobile/Bridge/Bridgeword/id/%@",Main_Server,self.idq];
    
    [XAFNetWork GET:str params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"title===%@",responseObject);
        ActivityDetailLabmodel* model=[ActivityDetailLabmodel modelWithDict:responseObject];
        
        [self initTitleLab:model];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


- (void)initTitleLab:(ActivityDetailLabmodel*)model
{
    UIView* backView=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.SDScrollView.frame), self.frame.size.width, self.frame.size.height-self.SDScrollView.frame.size.height)];
    //backView.backgroundColor=[UIColor cyanColor];
    [self addSubview:backView];
    
    UILabel* lab1=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 0, 0)];
    lab1.text=model.title;
    lab1.font=[UIFont boldSystemFontOfSize:15];
    [lab1 sizeToFit];
    [backView addSubview:lab1];
    
    
    UILabel* lab2=[[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lab1.frame)+10, self.frame.size.width-40, 0)];
    
    lab2.numberOfLines=3;
    lab2.font=[UIFont systemFontOfSize:10];
    lab2.text=model.literal;
    [lab2 sizeToFit];
    [backView addSubview:lab2];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
