//
//  ActivityDetailListModel.m
//  yizu
//
//  Created by myMac on 2017/11/15.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityDetailListModel.h"

@implementation ActivityDetailListModel

+ (instancetype)modelWithDict:(NSDictionary *)dic
{
    ActivityDetailListModel* model=[self new];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end
