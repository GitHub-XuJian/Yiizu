//
//  HomeDetailFooter.m
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeDetailFooter.h"
#import "CellBtn.h"
#import "favoriteBtn.h"

@interface HomeDetailFooter ()

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *fullLab;
@property (weak, nonatomic) IBOutlet CellBtn *likeBtn;

@property (weak, nonatomic) IBOutlet favoriteBtn *favBtn;

@end

@implementation HomeDetailFooter


+(instancetype)makeCustomFooterView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeDetailFooter" owner:nil options:nil] firstObject];
}


- (void)setTime:(NSString *)time
{
    _time=time;
    self.timeLab.text=time;
}

- (void)setFull:(NSString *)full
{
    _full=full;
    self.fullLab.text=[NSString stringWithFormat:@"%@   >>>",full];
}

- (void)setPhone:(NSString *)phone
{
    _phone=phone;
    self.phoneLab.text=[NSString stringWithFormat:@"%@>>>",phone];
    self.phoneLab.userInteractionEnabled=YES;

    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneLabClike)];
    
    [self.phoneLab addGestureRecognizer:tap];
    
}

- (void)phoneLabClike
{
    NSLog(@"点击了电话号码");
    //[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:"] options:<#(nonnull NSDictionary<NSString *,id> *)#> completionHandler:<#^(BOOL success)completion#>
    //[[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel:12345678"]];
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.phoneLab.text];
     NSLog(@"strphone======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
  
    
}
- (void)setStatus:(NSString *)status
{
    _status=status;
    if (status) {
        self.likeBtn.islike=YES;
    }else
    {
        self.likeBtn.islike=NO;
    }
}

- (void)setUpvote:(NSString *)upvote
{
    _upvote=upvote;
    self.likeBtn.likeCount=upvote.integerValue;
}

- (void)setTurvy:(NSString *)turvy
{
    _turvy=turvy;
    if (turvy) {
        self.favBtn.issc=YES;
    }else
    {
        self.favBtn.issc=NO;
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
