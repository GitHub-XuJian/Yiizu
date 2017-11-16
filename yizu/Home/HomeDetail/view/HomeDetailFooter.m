//
//  HomeDetailFooter.m
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeDetailFooter.h"

@interface HomeDetailFooter ()

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *fullLab;


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
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
