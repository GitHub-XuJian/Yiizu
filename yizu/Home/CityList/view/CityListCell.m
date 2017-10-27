//
//  CityListCell.m
//  yizu
//
//  Created by myMac on 2017/10/26.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "CityListCell.h"

@interface CityListCell ()

@property(nonatomic, strong)UILabel* titleLable;

@end

@implementation CityListCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        if (self) {
            
            self.titleLable = [[UILabel alloc] init];
            self.titleLable.textColor = [UIColor blackColor];
            self.titleLable.font = [UIFont systemFontOfSize:18];
            self.titleLable.textAlignment = NSTextAlignmentCenter;
            
            [self addSubview:self.titleLable];
            [self.contentView addSubview:self.titleLable];
            
        }
        
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.titleLable.frame = self.bounds;
    
}


- (void)setCityName:(NSString *)cityName {
    
    _cityName = cityName;
    
    self.titleLable.text = cityName;
    
}

@end
