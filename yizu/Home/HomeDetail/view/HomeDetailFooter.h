//
//  HomeDetailFooter.h
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeDetailFooter;

@protocol HomeDetailFooterDelegate <NSObject>

-(void)HomeDetailFooterView:(HomeDetailFooter*)footView;

@end

@interface HomeDetailFooter : UIView

@property (nonatomic, assign) id<HomeDetailFooterDelegate> delegate;

//营业时间
@property (nonatomic, copy) NSString* time;
//详细地址
@property (nonatomic, copy) NSString* full;
//商家电话
@property (nonatomic, copy) NSString* phone;
//点赞状态
@property (nonatomic, copy) NSString* status;
//点赞数量
@property (nonatomic, copy) NSString* upvote;
//
@property (nonatomic, copy) NSString* turvy;

+ (instancetype)makeCustomFooterView;


@end
