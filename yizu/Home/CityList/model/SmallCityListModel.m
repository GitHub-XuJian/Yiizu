//
//  SmallCityListModel.m
//  yizu
//
//  Created by myMac on 2017/11/18.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "SmallCityListModel.h"

@implementation SmallCityListModel

+(instancetype)ModelWithDict:(NSDictionary *)dic
{
    SmallCityListModel* model=[self new];
    
    //[model setValuesForKeysWithDictionary:dic];
    model.cityId=dic[@"id"];
    model.name=dic[@"name"];
    
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
