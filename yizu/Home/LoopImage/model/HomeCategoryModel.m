//
//  HomeCategoryModel.m
//  yizu
//
//  Created by myMac on 2017/11/21.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "HomeCategoryModel.h"

@implementation HomeCategoryModel

+(instancetype)modelWithDict:(NSDictionary *)dic
{
    HomeCategoryModel* model=[self new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
