//
//  ActivityLsitModel.h
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityLsitModel : NSObject

//activityid = 21;
//"city_id" = 76;
//"end_time" = 1970;
//"locus_id" = 839;
//mainpic = "2017-11-07/5a014070b424d.png";
//movable = 14214421421421321;
//pic =     (
//           "2017-10-16/59e473386bf11.jpg",
//           "2017-10-16/59e473386d681.jpg",
//           "2017-10-16/59e473386f5c1.jpg"
//           );
//region = 1;
//sort = 1421421;
//specific = A;
//"start_time" = 1970;
//title = 2142142;
//writingpic = 321321321;

//activityid
//"活动id"
//title
//"活动名字"
//sort
//"活动分类"
//city_id
//"活动城市id"
//locus_id
//"活动区域id"
//movable
//"活动简介"
//writingpic
//活动标题文字说明
//mainpic
//"2017-11-07/5a01408e022a5.png"
//pic1
//"2017-10-17/59e5c15544de3.jpg"
//pic2
//"2017-10-17/59e5c1554693b.jpg"
//pic3
//"2017-10-17/59e5c155474f3.jpg"
//
//
//attention
//"关注没用的 以后用的"
//chamberid
//null
//chambername
//null
//start_time
//"开始时间图片"
//end_time
//"结束时间图片"
//specific
//"A"
//region
//"  2"

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

+(instancetype)modelWithDict:(NSDictionary*)dic;

@end
