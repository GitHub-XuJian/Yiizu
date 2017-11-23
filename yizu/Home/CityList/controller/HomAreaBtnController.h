//
//  HomAreaBtnController.h
//  yizu
//
//  Created by myMac on 2017/10/27.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomAreaBtnController;

@protocol HomAreaBtnDelegate <NSObject>

-(void)HomAreaBtnTitle:(NSString*)title;

@end

@interface HomAreaBtnController : UITableViewController

@property (nonatomic, assign)id<HomAreaBtnDelegate> delegate;

@property(nonatomic, copy)NSString* cityId;

@end
