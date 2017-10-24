//
//  MembershipActivationCodeView.h
//  yizu
//
//  Created by 徐健 on 17/10/24.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClassBlock)(UIButton *classBtn);

@interface MembershipActivationCodeView : UIView

- (instancetype)initWithFrame:(CGRect)frame andTitleArray:(NSMutableArray *)titleArray andClassBlock:(ClassBlock)classBlock;

@end
