//
//  AgreementView.h
//  yizu
//
//  Created by 徐健 on 2017/11/6.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AgreementViewBlock)(UIButton *classBtn);

@interface AgreementView : UIView

@property (nonatomic, strong) AgreementViewBlock block;
- (instancetype)initWithFrame:(CGRect)frame andTitleColor:(UIColor *)titleColor;

@end
