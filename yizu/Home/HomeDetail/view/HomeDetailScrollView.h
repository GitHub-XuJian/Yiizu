//
//  HomeDetailScrollView.h
//  yizu
//
//  Created by 李大霖 on 2017/12/4.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeDetailModel;
@class HomeDetailImaView;

@protocol HomeDetailScrollViewDelegate <NSObject>

-(void)HomeDetail:(HomeDetailImaView*)ima;

@end



@interface HomeDetailScrollView : UIScrollView

@property (nonatomic, strong)HomeDetailModel * Amodel;

@property (nonatomic, strong)HomeDetailImaView* homeImaView;

@property (nonatomic, strong) id <HomeDetailScrollViewDelegate> homeDelegate;

@end
