//
//  HomeDetailScrollView.m
//  yizu
//
//  Created by 李大霖 on 2017/12/4.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeDetailScrollView.h"
#import "HomeDetailModel.h"
#import "HomeDetailImaView.h"

@interface HomeDetailScrollView ()<myHomeDetailImaDelegate>
@end

@implementation HomeDetailScrollView

- (void)setAmodel:(HomeDetailModel *)Amodel
{
    _Amodel=Amodel;
    
    CGFloat w =(kSCREEN_WIDTH-30)/3;
    self.showsHorizontalScrollIndicator=NO;
    self.bounces=NO;
    //self.contentSize=CGSizeMake(w*arr.count+arr.count*10, 0);
    self.contentSize=CGSizeMake(w*Amodel.dada.count+Amodel.dada.count*10, 0);
    //self.userInteractionEnabled=YES;
    
    
    NSString* ima=@"";
    
    for (int i=0;i<Amodel.dada.count;i++) {
        //NSLog(@"个数==%lu",Amodel.dada.count);
        ima = [NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,Amodel.dada[i]];
        //NSLog(@"十图==%@",[NSString stringWithFormat:@"%@Public/%@",Main_ServerImage,Amodel.dada[i]]);
        
                self.homeImaView=[[HomeDetailImaView alloc]initWithFrame: CGRectMake(10+i*(w+10), 0, w, self.frame.size.height)];
                self.homeImaView.layer.cornerRadius = 10;
                self.homeImaView.layer.masksToBounds=YES;
                //self.imaView.backgroundColor=[UIColor redColor];
                self.homeImaView.delegate=self;
                [self.homeImaView sd_setImageWithURL:[NSURL URLWithString:ima]];
                
                [self addSubview:self.homeImaView];
    }
}

- (void)ImaViewima:(HomeDetailImaView *)imaView
{
    NSLog(@"详情代理");
    if ([self.homeDelegate respondsToSelector:@selector(HomeDetail:)]) {
        [self.homeDelegate HomeDetail:imaView];
        NSLog(@"响应");
    }else
    {
        NSLog(@"响应");
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
