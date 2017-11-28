//
//  CustomCellScrollView.m
//  yizu
//
//  Created by myMac on 2017/11/9.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CustomCellScrollView.h"
#import "ScrollImaView.h"



@interface CustomCellScrollView ()

@property (nonatomic, strong)NSMutableArray* arr;

@property (nonatomic ,strong) ScrollImaView* imaView;



@end

@implementation CustomCellScrollView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self updateUI:_imaArr];
    }
    return self;
}


- (void)awakeFromNib {
    
    [self updateUI:_imaArr];
    
}


- (void)setImaArr:(NSArray *)imaArr
{
    _imaArr=imaArr;
    _arr=[[NSMutableArray alloc]init];
    [self updateUI:imaArr];
}

- (void)updateUI:(NSArray*)arr
{
    CGFloat w =kSCREEN_WIDTH/2+30;
    self.showsHorizontalScrollIndicator=NO;
    self.bounces=NO;
    self.contentSize=CGSizeMake(w*arr.count+arr.count*10, 0);
    
    

    for (NSDictionary* dic in arr) {
        NSString* str=dic[@"mainpic"];
        
        [_arr addObject:str];
    }
    
    
    for (int i=0; i<3; i++) {
        self.imaView=[[ScrollImaView alloc]initWithFrame: CGRectMake(10+i*(w+10), 0, w, self.frame.size.height)];
        self.imaView.layer.cornerRadius = 10;
        self.imaView.layer.masksToBounds=YES;
        //self.imaView.backgroundColor=[UIColor redColor];

         [self.imaView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,[arr[i]objectForKey:@"mainpic"]]]];
        
        self.imaView.activityid=[arr[i]objectForKey:@"activityid"];
        
       //NSString* str=[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,[arr[i]objectForKey:@"...id"];
        //NSLog(@"ima==第%d组\n%@",i,[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,[arr[i]objectForKey:@"mainpic"] ]);
        self.imaView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer* imaTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imaViewClike)];
        
        [self addGestureRecognizer:imaTap];
        [self addSubview:self.imaView];
    }
    
    //for (int i=0; i<arr.count; i++) {
//        for (UIImageView* img in self.subviews) {
//            [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,str]]];
//            NSLog(@"===%@",[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,str]);
//        }
    //}
    
   
}


- (void)imaViewClike
{
   
    if ([self.CustomDelegate respondsToSelector:@selector(CustomCellScrollViewClickBtn:)]) {
        
        [self.CustomDelegate CustomCellScrollViewClickBtn:self.imaView];
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
