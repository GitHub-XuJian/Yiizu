//
//  CustomCellScrollView.h
//  yizu
//
//  Created by myMac on 2017/11/9.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActivityLsitModel;

@class CustomCellScrollView;

@protocol CustomCellScrollViewDelegate <NSObject>

-(void)CustomCellScrollViewClickBtn:(UIImageView*)HeaderView;

@end

@interface CustomCellScrollView : UIScrollView
@property (nonatomic,strong) NSArray* imaArr;

@property (nonatomic, assign) id<CustomCellScrollViewDelegate> CustomDelegate;

@end
