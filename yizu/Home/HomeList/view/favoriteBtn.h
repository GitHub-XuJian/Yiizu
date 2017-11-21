//
//  favoriteBtn.h
//  yizu
//
//  Created by myMac on 2017/11/16.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface favoriteBtn : UIButton


@property (nonatomic) BOOL issc;                  //当前状态

@property (nonatomic,copy) NSString *requestID;     //点赞请求ID

@property (nonatomic,copy)NSString* chambername;    //保存店铺名字

@property (nonatomic,copy)NSString* userId;         //保存用户id





@end
