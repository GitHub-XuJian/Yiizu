//
//  SmallActivityListModel.m
//  yizu
//
//  Created by myMac on 2017/11/30.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "SmallActivityListModel.h"

@implementation SmallActivityListModel

+ (instancetype)modelWithDict:(NSDictionary *)dic
{
    SmallActivityListModel* model =[self new];
    
    [model setValuesForKeysWithDictionary:dic];
    
    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end
