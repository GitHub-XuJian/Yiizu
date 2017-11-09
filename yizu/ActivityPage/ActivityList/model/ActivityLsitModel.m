//
//  ActivityLsitModel.m
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityLsitModel.h"

@implementation ActivityLsitModel

+ (instancetype)modelWithDict:(NSDictionary *)dic
{
    ActivityLsitModel* model=[self new];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
