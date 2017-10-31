//
//  CustomSearchBar.m
//  yizu
//
//  Created by myMac on 2017/10/30.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CustomSearchBar.h"

@implementation CustomSearchBar
+ (instancetype)makeCustomSearchBar {
    return [[[NSBundle mainBundle] loadNibNamed:@"CustomSearchBar" owner:nil options:nil] firstObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
