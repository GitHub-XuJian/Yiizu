//
//  ActivityLsitModel.m
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityLsitModel.h"
#import "SmallActivityListModel.h"

@implementation ActivityLsitModel

+ (instancetype)modelWithDict:(NSDictionary *)dic
{
    ActivityLsitModel* model=[self new];
    
    [model setValuesForKeysWithDictionary:dic];
    
//    model.mainpic=dic[@"mainpic"];
//    model.city_id=dic[@"city_id"];
//    model.writingpic= dic[@"writingpic"];
//    model.caption1=dic[@"caption1"];
//    model.activityid= dic[@"activityid"];
//
//    NSMutableArray* arrModel=[NSMutableArray array];
//    for (NSDictionary* small_dic in dic[@"pic"]) {
//        SmallActivityListModel* sModel=[SmallActivityListModel modelWithDict:small_dic];
//        [arrModel addObject:sModel];
//    }
//    model.pic=arrModel;
    
    return model;
}



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
