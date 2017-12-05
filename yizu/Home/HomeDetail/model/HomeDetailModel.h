//
//  HomeDetailModel.h
//  yizu
//
//  Created by myMac on 2017/12/3.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeDetailModel : NSObject
//城市
@property (nonatomic, copy) NSString* city_id;

//详情轮播
@property (nonatomic, strong) NSArray* lun;
//详情小图
@property (nonatomic, strong) NSArray* dada;
//十图
//@property (nonatomic, strong) NSArray* list;
//距离
@property (nonatomic, copy) NSString* distance;

//商户名称
@property (nonatomic, copy) NSString* chambername;
//已售
@property (nonatomic, copy) NSString* obtained;
//点赞数
@property (nonatomic, copy) NSString* upvote;
//商户简介
@property (nonatomic, copy) NSString* chamberjj;
//商户id
@property (nonatomic, copy) NSString* chamber_id;
//排名
@property (nonatomic, copy) NSString* up;
//是否点过赞
@property (nonatomic, copy) NSString* status;

@property (nonatomic, copy) NSString* icon;

//更改收藏状态
@property (nonatomic, copy) NSString* Turvy;

//营业开始时间
@property (nonatomic, copy) NSString* starttime;
//营业结束时间
@property (nonatomic, copy) NSString* endtime;
//电话
@property (nonatomic, copy) NSString* chammobile;
//full
@property (nonatomic, copy) NSString* full;

@property (nonatomic, copy) NSString* lng;

@property (nonatomic, copy) NSString* lat;


+ (instancetype)ModelWithDict:(NSDictionary*)dic;

@end