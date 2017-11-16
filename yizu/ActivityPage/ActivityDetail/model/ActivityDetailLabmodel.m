//
//  ActivityDetailLabmodel.m
//  yizu
//
//  Created by myMac on 2017/11/14.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityDetailLabmodel.h"

@implementation ActivityDetailLabmodel

+ (instancetype)modelWithDict:(NSDictionary *)dic
{
    ActivityDetailLabmodel* model=[self new];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end
