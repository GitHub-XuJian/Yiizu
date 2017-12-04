//
//  HomeDetailController.h
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeListModel;

@interface HomeDetailController : UIViewController

@property (nonatomic,copy) NSString* chamber_id;
@property (nonatomic,copy) NSString* userId;

@property (nonatomic,strong) HomeListModel* model;

@property (nonatomic, assign) BOOL likeStart;

@end
