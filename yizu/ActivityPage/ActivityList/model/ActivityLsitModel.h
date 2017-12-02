//
//  ActivityLsitModel.h
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityLsitModel : NSObject



//大图
@property (nonatomic, copy) NSString* mainpic;

////活动城市id
@property (nonatomic, copy) NSString* city_id;
////小图数组
@property (nonatomic, strong) NSArray* pic;
//活动标题文字说明
@property (nonatomic, copy) NSString* writingpic;
//每行标题
@property (nonatomic, copy) NSString* caption1;
//活动id
@property (nonatomic, copy) NSString* activityid;

+(instancetype)modelWithDict:(NSDictionary*)dic;

@end
