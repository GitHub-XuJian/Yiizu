//
//  MembersHeadView.h
//  yizu
//
//  Created by 徐健 on 2017/11/10.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MembersHeadViewDelegate <NSObject>

-(void)clickButton:(UIButton *)button;

@end
@interface MembersHeadView : UIView
@property (nonatomic,weak) id<MembersHeadViewDelegate>delegate;

-(void)reloadData;
@end
