//
//  FollowBtn.h
//  yizu
//
//  Created by myMac on 2017/11/17.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowBtn : UIButton


@property (nonatomic) BOOL isFollow;                  //当前状态

@property (nonatomic,copy) NSString *requestID;     //点赞请求ID

@property (nonatomic) NSInteger  followCount;         //设置赞数


@property (nonatomic,copy)NSString* userId;         //保存用户id

@property (nonatomic,copy)NSString* activityid;     //id
@end
