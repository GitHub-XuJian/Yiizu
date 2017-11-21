//
//  HeadCityBtnReusableView.h
//  yizu
//
//  Created by myMac on 2017/11/18.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeadCityBtnReusableView;

@protocol HeadCityBtnViewDelegate <NSObject>

-(void)HeadClickBtn:(HeadCityBtnReusableView*)HeaderView;

@end

@class CityListModel;

@interface HeadCityBtnReusableView : UICollectionReusableView

@property (nonatomic,strong) NSString *titleName;

@property(nonatomic,strong)id<HeadCityBtnViewDelegate>delegate;

@property(nonatomic,strong)CityListModel* model;

@end
