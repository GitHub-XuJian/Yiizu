//
//  CustomCellScrollView.h
//  yizu
//
//  Created by myMac on 2017/11/9.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScrollImaView;

@protocol ScrmyaaaDelegate <NSObject>

-(void)ImaaActid:(NSString*)actid;

@end

@class ScrollImaView;

@class ActivityLsitModel;

@interface CustomCellScrollView : UIScrollView

@property (nonatomic, strong) ActivityLsitModel* Amodel;

@property (nonatomic ,strong) ScrollImaView* imaView1;

@property (nonatomic, assign) id<ScrmyaaaDelegate> ScrDelegate;

@end
