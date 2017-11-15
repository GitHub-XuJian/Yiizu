//
//  ActivityDetailListModel.h
//  yizu
//
//  Created by myMac on 2017/11/15.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityDetailListModel : NSObject


//mainpic activityid movable
//大图
@property (nonatomic, copy) NSString* mainpic;
//关注数量
@property (nonatomic, copy) NSString* activityid;
//图片文字
@property (nonatomic, copy) NSString* movable;

+ (instancetype)modelWithDict:(NSDictionary*)dic;

@end
