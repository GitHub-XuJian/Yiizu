//
//  HomeDetailModel.m
//  yizu
//
//  Created by myMac on 2017/12/3.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeDetailModel.h"

@implementation HomeDetailModel


+(instancetype)ModelWithDict:(NSDictionary *)dic
{
    
    HomeDetailModel* model=[self new];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
