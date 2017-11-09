//
//  ActivityPageModel.m
//  yizu
//
//  Created by myMac on 2017/11/8.
//  Copyright © 2017年 XuJian. All rights reserved.
//

#import "ActivityPageModel.h"

@implementation ActivityPageModel


+(instancetype)modelWithDict:(NSDictionary *)dic
{
    ActivityPageModel* model=[self new];
    
    [model setValuesForKeysWithDictionary:dic];
    
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
