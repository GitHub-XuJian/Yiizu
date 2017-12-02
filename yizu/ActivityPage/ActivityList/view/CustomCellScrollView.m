//
//  CustomCellScrollView.m
//  yizu
//
//  Created by myMac on 2017/11/9.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CustomCellScrollView.h"
#import "ScrollImaView.h"
#import "SmallActivityListModel.h"
#import "ActivityLsitModel.h"


@interface CustomCellScrollView ()<myViewidDelegate>



//@property (nonatomic ,strong) ScrollImaView* imaView;



@end

@implementation CustomCellScrollView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //[self updateUI:_imaArr];
    }
    return self;
}


- (void)awakeFromNib {
    
    //[self updateUI:_imaArr];
    
}


- (void)setAmodel:(ActivityLsitModel *)Amodel
{
    _Amodel=Amodel;
    
    
    CGFloat w =kSCREEN_WIDTH/2+30;
    self.showsHorizontalScrollIndicator=NO;
    self.bounces=NO;
    //self.contentSize=CGSizeMake(w*arr.count+arr.count*10, 0);
    self.contentSize=CGSizeMake(w*3+3*10, 0);
    //self.userInteractionEnabled=YES;
    
    NSString* ima=@"";
    NSString* acid=@"";
    for (int i=0 ; i<3;i++) {
        ima = [Amodel.pic[i] objectForKey:@"mainpic"];
        acid= [Amodel.pic[i] objectForKey:@"activityid"];
        
        self.imaView1=[[ScrollImaView alloc]initWithFrame: CGRectMake(10+i*(w+10), 0, w, self.frame.size.height)];
        self.imaView1.layer.cornerRadius = 10;
        self.imaView1.layer.masksToBounds=YES;
        //self.imaView.backgroundColor=[UIColor redColor];
        self.imaView1.delegate=self;
        [self.imaView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@Public/img/img/%@",Main_ServerImage,ima]]];
        self.imaView1.activityid=acid;
        [self addSubview:self.imaView1];
    }
}


    

   
-(void)ImaViewActid:(NSString *)actid
{
    NSLog(@"actid%@",actid);
    if ([self.ScrDelegate respondsToSelector:@selector(ImaaActid:)]) {
        [self.ScrDelegate ImaaActid:actid];
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
